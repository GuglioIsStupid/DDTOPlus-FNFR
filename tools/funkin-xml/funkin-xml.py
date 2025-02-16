import os
import sys
import xml.etree.ElementTree as ET
import re
import random

def process_xml(xmlfile):
    try:
        xmlname = os.path.basename(xmlfile)
        sheetxml = ET.parse(xmlfile).getroot()

        imgFile = sheetxml.attrib.get('imagePath', '')

        animLists = {}

        lua = ('return graphics.newSprite(\n'
               f'\tgraphics.imagePath("{imgFile.replace(".png", "")}"),\n'
               '\t{\n')

        c = 0
        for SubTexture in sheetxml.findall('SubTexture'):
            c += 1

            name = SubTexture.get('name')
            x = SubTexture.get('x')
            y = SubTexture.get('y')
            width = SubTexture.get('width')
            height = SubTexture.get('height')
            offsetx = SubTexture.get('frameX', '0')
            offsety = SubTexture.get('frameY', '0')
            offsetWidth = SubTexture.get('frameWidth', '0')
            offsetHeight = SubTexture.get('frameHeight', '0')
            rotated = SubTexture.get('rotated', 'false')

            lua += '\t\t{x = ' + x + ', y = ' + y + ', width = ' + width + ', height = ' + height + \
                   ', offsetX = ' + offsetx + ', offsetY = ' + offsety + ', offsetWidth = ' + offsetWidth + \
                   ', offsetHeight = ' + offsetHeight + ', rotated = ' + rotated + '}, -- ' + str(c) + ': ' + name + '\n'

            realName = re.sub(r'\d+$', '', name)

            if realName not in animLists:
                animLists[realName] = {"start": str(c), "name": realName}
            animLists[realName]["stop"] = str(c)
            animLists[realName]["speed"] = '24'
            animLists[realName]["offsetX"] = '0'
            animLists[realName]["offsetY"] = '0'

        lua += '\t},\n'

        lua += "\t{\n"

        for animName, animData in animLists.items():
            lua += f'\t\t["{animData["name"]}"] = {{start = {animData["start"]}, stop = {animData["stop"]}, ' \
                   f'speed = {animData["speed"]}, offsetX = {animData["offsetX"]}, offsetY = {animData["offsetY"]}}},\n'

        lua += '\t},\n'

        lua += f'\t"{random.choice(list(animLists.values()))["name"]}",\n'
        lua += f'\tfalse\n'

        lua += ")"

        luaFile = xmlname.replace('.xml', '') + '.lua'

        with open(luaFile, 'w') as f:
            f.write(lua)
            
        print(f"Lua file written: {luaFile}")
    except Exception as e:
        print(f"Error processing {xmlfile}: {e}")

def main():
    if len(sys.argv) < 2:
        print("Usage: python script.py <file1.xml> <file2.xml> ...")
        sys.exit(1)

    for xmlfile in sys.argv[1:]:
        if os.path.exists(xmlfile) and xmlfile.endswith('.xml'):
            process_xml(xmlfile)
        else:
            print(f"Invalid file or file not found: {xmlfile}")

if __name__ == '__main__':
    main()
