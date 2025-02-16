local util = {}

function util.lerp(a, b, t)
    return a + (b - a) * t
end

function util.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end

function util.startsWith(str, start)
    return str:sub(1, #start) == start
end

function util.endsWith(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

function util.round(x) 
    return x >= 0 and math.floor(x + .5) or math.ceil(x - .5) 
end

function util.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

local invalidChars = " ~%%&\\;:\"',<>?#]+" -- Invalid characters for a flixel save file
function util.getFlixelSave(company, title, localPath, name, newPath)
    localPath = localPath or "ninjamuffin99"
    name = name or "funkin"
    newPath = newPath or false

    if localPath == "" then
        local path = company 
        if path == nil or path == "" then
            path = "HaxeFlixel"
        else
            path = path:gsub(invalidChars, "-")
        end

        localPath = path
    end
    local directory = love.filesystem.getAppdataDirectory() .. "/"
    local path = ""

    if newPath then
        path = directory .. localPath .. "/"
    else
        path = directory .. company .. "/" .. title .. "/" .. localPath .. "/"
    end
    
    name = name:gsub("//", "/")
    name = name:gsub("//", "/")

    if util.startsWith(name, "/") then
        name = name:sub(2)
    end

    if util.endsWith(name, "/") then
        name = name:sub(1, #name - 1)
    end

    if name:find("/") then
        local split = util.split(name, "/")
        name = ""

        for i = 1, #split - 1 do
            name = name .. "#" .. split[i] .. "/"
        end

        name = name .. split[#split]
    end

    -- print(path .. name .. ".sol")

    local file = io.open(path .. name .. ".sol", "r")
    if file then
        file:close()
        return true
    end

    return false
end

function util.getFNFRSave(identity)
end

local checkForFlixel = love.system.getOS() ~= "NX"
function util.getModSave(identity, ...)
    if type(identity) == "string" then -- There is a known port of the mod to FNFR
        if util.getFNFRSave(identity) then
            return true
        end
    end

    if checkForFlixel then
        return util.getFlixelSave(...)
    end

    return false
end

--[[
public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = OpenFlAssets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}]]

function util.coolTextFile(path)
    local function trim(s)
        return (s:gsub("^%s*(.-)%s*$", "%1"))
    end

    local daList = love.filesystem.read(path)
    daList = trim(daList)
    ---@diagnostic disable-next-line: cast-local-type
    daList = util.split(daList, "\n")

    for i = 1, #daList do
        daList[i] = trim(daList[i])
    end

    return daList
end

function util.contains(tbl, value)
    for i = 1, #tbl do
        if tbl[i] == value then
            return true
        end
    end

    return false
end

-- God like coding
--[[
function util.🍰(🥰, 🥵)
    🥰 = 🥰 or 🥵
    🥵 = 🥵 or 🥰
    return 🥰 + 🥵
end

function util.🍩(🥰, 🥵)
    🥰 = 🥰 or 🥵
    🥵 = 🥵 or 🥰
    return 🥰 * 🥵
end

function util.☠️(🥰, 🥵)
    🥰 = 🥰 or 🥵
    🥵 = 🥵 or 🥰
    return 🥰 / 🥵
end

function util.😍(☠️)
    return math.floor(☠️)
end

function util.❓⌚()
    local ⌚️= os.time()

    local 🆕📅 = os.date("*t", ⌚️)

    return 🆕📅
end

function util.📅()
    local 🆕📅 = util.❓⌚()
    return 🆕📅.year .. "-" .. 🆕📅.month .. "-" .. 🆕📅.day
end

print(util.📅())
--]]
return util