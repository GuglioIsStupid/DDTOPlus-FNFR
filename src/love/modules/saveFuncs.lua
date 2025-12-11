--[[
public static function getFlixelSave(company:String, title:String, localPath:String = 'ninjamuffin99', name:String = 'funkin', newPath:Bool = false):Bool
	{
		// before anyone asks, this is copy-pasted from FlxSave
		var invalidChars = ~/[ ~%&\\;:"',<>?#]+/;

		// Avoid checking for .sol files directly in AppData
		if (localPath == "")
		{
			var path = company;

			if (path == null || path == "")
			{
				path = "HaxeFlixel";
			}
			else
			{
				#if html5
				// most chars are fine on browsers
				#else
				path = invalidChars.split(path).join("-");
				#end
			}

			localPath = path;
		}

		var directory = lime.system.System.applicationStorageDirectory;
		var path = '';

		if (newPath)
			path = haxe.io.Path.normalize('$directory/../../../$localPath') + "/";
		else
			path = haxe.io.Path.normalize('$directory/../../../$company/$title/$localPath') + "/";

		name = StringTools.replace(name, "//", "/");
		name = StringTools.replace(name, "//", "/");

		if (StringTools.startsWith(name, "/"))
		{
			name = name.substr(1);
		}

		if (StringTools.endsWith(name, "/"))
		{
			name = name.substring(0, name.length - 1);
		}

		if (name.indexOf("/") > -1)
		{
			var split = name.split("/");
			name = "";

			for (i in 0...(split.length - 1))
			{
				name += "#" + split[i] + "/";
			}

			name += split[split.length - 1];
		}

		#if debug
		trace(path + name + ".sol");
		#end

		return FileSystem.exists(path + name + ".sol");
	}]]

-- use base lua (not love2d) for file stuff
function getFlixelSave(company, title, localpath, name, newPath)
    company = company or ""
    title = title or ""
    localpath = localpath or "ninjamuffin99"
    name = name or "funkin"
    newPath = newPath or false

    local invalidChars = "[ ~%%&\\;:'\",<>?#]+"

    if localpath == "" then
        local path = company
        if path == nil or path == "" then
            path = "HaxeFlixel"
        else
            path = string.gsub(path, invalidChars, "-")
        end
        localpath = path
    end

    local directory = "" 
    if love.system.getOS() == "Windows" then
        directory = os.getenv("APPDATA") .. "/"
    elseif love.system.getOS() == "Linux" then
        directory = os.getenv("HOME") .. "/.local/share/"
    elseif love.system.getOS() == "OS X" then
        directory = os.getenv("HOME") .. "/Library/Application Support/"
    else
        return false
    end

    name = string.gsub(name, "//", "/")
    if string.sub(name, 1, 1) == "/" then
        name = string.sub(name, 2)
    end

    if string.sub(name, -1) == "/" then
        name = string.sub(name, 1, -2)
    end

    local path = ""
    if newPath then
        path = directory .. localpath .. "/"
    else
        path = directory .. company .. "/" .. title .. "/" .. localpath .. "/"
    end

    if string.find(name, "/") then
        local split = {}
        for str in string.gmatch(name, "([^/]+)") do
            table.insert(split, str)
        end

        name = ""
        for i = 1, #split - 1 do
            name = name .. "#" .. split[i] .. "/"
        end
        name = name .. split[#split]
    end

    print(path .. name .. ".sol")

    local fullpath = path .. name .. ".sol"
    local file = io.open(fullpath, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

function getRenpySave(doki)
    doki = doki or "DDLC-1454445547"

    local directory = ""
    local renpy = "RenPy"
    local path = ""

    if love.system.getOS() == "Linux" then
        renpy = ".renpy"
        path = string.gsub(os.getenv("HOME") .. "/" .. renpy .. "/" .. doki .. "/", "//", "/")
    elseif love.system.getOS() == "OS X" then
        directory = "" 
        if love.system.getOS() == "OS X" then
            directory = os.getenv("HOME") .. "/Library/Application Support/"
        end
        path = string.gsub(directory .. renpy .. "/" .. doki .. "/", "//", "/")
    elseif love.system.getOS() == "Windows" then
        local dir = "" 
        if love.system.getOS() == "Windows" then
            dir = os.getenv("APPDATA") .. "/"
        elseif love.system.getOS() == "Linux" then
            dir = os.getenv("HOME") .. "/.local/share/"
        elseif love.system.getOS() == "OS X" then
            dir = os.getenv("HOME") .. "/Library/Application Support/"
        else
            dir = love.filesystem.getSaveDirectory() .. "/"
        end
        path = string.gsub(dir .. renpy .. "/" .. doki .. "/", "//", "/")
    else
        return false
    end

    local fullpath = path .. "persistent"
    print(fullpath)
    local file = io.open(fullpath, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

function getDDLCPSave()
    local path = ""
    if love.system.getOS() == "Windows" then
        path = os.getenv("USERPROFILE") .. "\\AppData\\LocalLow\\Team Salvato\\Doki Doki Literature Club Plus\\save_preferences.sav"
    elseif love.system.getOS() == "Linux" then
        path = os.getenv("HOME") .. "/.config/unity3d/Team Salvato/Doki Doki Literature Club Plus/save_preferences.sav"
    elseif love.system.getOS() == "OS X" then
        path = os.getenv("HOME") .. "/Library/Application Support/Team Salvato/Doki Doki Literature Club Plus/save_preferences.sav"
    else
        return false
    end

    print(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

function getSoftSave()
    return getFlixelSave("Disky", "Soft Mod") or getFlixelSave("SoftTeam", "FNFSoft", ".", "soft")
end

function getBadEndSave()
    return getFlixelSave("Team TBD", "DokiTakeover", "teamtbd", "badending") or getFlixelSave(nil, nil, "TeamTBD", "BadEnding", true)
end

function getSundaySave()
    return getFlixelSave("kadedev", "Vs Sunday") or getFlixelSave("kadedev", "Vs Sunday WITH SHADERS")
end

function getTabiSave()
    return getFlixelSave("Homskiy", "Tabi", "homskiy", "tabi") or getFlixelSave("Tabi Team", "Tabi")
end

--print(getFlixelSave("TeamTBD", "DokiTakeover", "", "", true))
--print(getRenpySave())
--print(getDDLCPSave())
--print(getSoftSave())
--print(getBadEndSave())
--print(getSundaySave())
--print(getTabiSave())