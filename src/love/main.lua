--[[----------------------------------------------------------------------------
Friday Night Funkin' Rewritten v1.1.0 beta 2

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]
if love.filesystem.isFused() then function print() end end -- print functions tend the make the game lag when in update functions, so we do this to prevent that
function math.randomI(min, max, ignore)
	local val = love.math.random(min, max)
	--while loop to prevent the same value from being returned twice in a row
	while val == ignore do
		val = love.math.random(min, max)
	end
	return val
end
function uitextflarge(text,x,y,limit,align,hovered,r,sx,sy,ox,oy,kx,ky)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local limit = limit or 750
	local align = align or "center"
	local hovered = hovered or false
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	if not hovered then graphics.setColor(0,0,0) else graphics.setColor(1,1,1) end
	love.graphics.printf(text,x-6,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x+6,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x,y-6,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x,y+6,limit,align,r,sx,sy,ox,oy,kx,ky)
	if not hovered then graphics.setColor(1,1,1) else graphics.setColor(0,0,0) end
	love.graphics.printf(text,x,y,limit,align,r,sx,sy,ox,oy,kx,ky)
end
function uitextf(text,x,y,limit,align,r,sx,sy,ox,oy,kx,ky,alpha)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local limit = limit or 750
	local align = align or "left"
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	graphics.setColor(0,0,0, alpha or 1)
	love.graphics.printf(text,x-2,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x+2,y,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x,y-2,limit,align,r,sx,sy,ox,oy,kx,ky)
	love.graphics.printf(text,x,y+2,limit,align,r,sx,sy,ox,oy,kx,ky)
	graphics.setColor(1,1,1, alpha or 1)
    love.graphics.printf(text,x,y,limit,align,r,sx,sy,ox,oy,kx,ky)
end
function uitext(text,x,y,r,sx,sy,ox,oy,kx,ky,alpha)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	graphics.setColor(0,0,0, alpha or 1)
	love.graphics.print(text,x-2,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x+2,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y-2,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y+2,r,sx,sy,a,ox,oy,kx,ky)
	graphics.setColor(1,1,1, alpha or 1)
    love.graphics.print(text,x,y,r,sx,sy,a,ox,oy,kx,ky)
end

function borderedText(text,x,y,r,sx,sy,ox,oy,kx,ky,alpha)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	graphics.setColor(0,0,0, alpha or 1)
	love.graphics.print(text,x-1,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x+1,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y-1,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y+1,r,sx,sy,a,ox,oy,kx,ky)
	graphics.setColor(1,1,1, alpha or 1)
	love.graphics.print(text,x,y,r,sx,sy,a,ox,oy,kx,ky)
end
function borderedText2(text,x,y,r,sx,sy,col1,col2, ox,oy,kx,ky,alpha, forcedSize)
	local x = x or 0
	local y = y or 0
	local r = r or 0
	local sx = sx or 1
	local sy = sy or 1
	local ox = ox or 0
	local oy = oy or 0
	local kx = kx or 0
	local ky = ky or 0
	local forcedSize = forcedSize or 2

	local col1 = col1 or {0,0,0}
	local col2 = col2 or {1,1,1}
	graphics.setColor(col1[1],col1[2],col1[3], alpha or 1)
	--[[ love.graphics.print(text,x-3,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x+3,y,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y-3,r,sx,sy,a,ox,oy,kx,ky)
	love.graphics.print(text,x,y+3,r,sx,sy,a,ox,oy,kx,ky) ]]
	for nx = -forcedSize, forcedSize do
		for ny = -forcedSize, forcedSize do
			love.graphics.print(text,x+nx,y+ny,r,sx,sy,a,ox,oy,kx,ky)
		end
	end
	graphics.setColor(col2[1],col2[2],col2[3], alpha or 1)
	love.graphics.print(text,x,y,r,sx,sy,a,ox,oy,kx,ky)
	graphics.setColor(1,1,1, alpha or 1)
end

function saveSettings()
    if settings.hardwareCompression ~= settingdata.saveSettingsMoment.hardwareCompression then
        settingdata = {}
        if settings.hardwareCompression then
            imageTyppe = "dds" 
        else
            imageTyppe = "png"
        end
        settingdata.saveSettingsMoment = {
            hardwareCompression = settings.hardwareCompression,
            downscroll = settings.downscroll,
            ghostTapping = settings.ghostTapping,
            showDebug = settings.showDebug,
            setImageType = "dds",
            sideJudgements = settings.sideJudgements,
            botPlay = settings.botPlay,
            middleScroll = settings.middleScroll,
            randomNotePlacements = settings.randomNotePlacements,
            practiceMode = settings.practiceMode,
            noMiss = settings.noMiss,
            customScrollSpeed = settings.customScrollSpeed,
            keystrokes = settings.keystrokes,
            scrollUnderlayTrans = settings.scrollUnderlayTrans,
            Hitsounds = settings.Hitsounds,
            vocalsVol = settings.vocalsVol,
            instVol = settings.instVol,
            hitsoundVol = settings.hitsoundVol,
            noteSkins = settings.noteSkins,
            flashinglights = settings.flashinglights,
            window = settings.window,
            customBindDown = customBindDown,
            customBindUp = customBindUp,
            customBindLeft = customBindLeft,
            customBindRight = customBindRight,
			selfAwareness = settings.selfAwareness,

			mirrorMode = settings.mirrorMode,

            settingsVer = settingsVer
        }
        serialized = lume.serialize(settingdata)
        love.filesystem.write("settings", serialized)
        love.window.showMessageBox("Settings Saved!", "Settings saved. Vanilla Engine will now restart to make sure your settings saved")
        love.event.quit("restart")
    else
        settingdata = {}
        if settings.hardwareCompression then
            imageTyppe = "dds" 
        else
            imageTyppe = "png"
        end
        settingdata.saveSettingsMoment = {
            hardwareCompression = settings.hardwareCompression,
            downscroll = settings.downscroll,
            ghostTapping = settings.ghostTapping,
            showDebug = settings.showDebug,
            setImageType = "dds",
            sideJudgements = settings.sideJudgements,
            botPlay = settings.botPlay,
            middleScroll = settings.middleScroll,
            randomNotePlacements = settings.randomNotePlacements,
            practiceMode = settings.practiceMode,
            noMiss = settings.noMiss,
            customScrollSpeed = settings.customScrollSpeed,
            keystrokes = settings.keystrokes,
            scrollUnderlayTrans = settings.scrollUnderlayTrans,
            Hitsounds = settings.Hitsounds,
            vocalsVol = settings.vocalsVol,
            instVol = settings.instVol,
            hitsoundVol = settings.hitsoundVol,
            noteSkins = settings.noteSkins,
            flashinglights = settings.flashinglights,
			selfAwareness = settings.selfAwareness,

			mirrorMode = settings.mirrorMode,

            customBindDown = customBindDown,
            customBindUp = customBindUp,
            customBindLeft = customBindLeft,
            customBindRight = customBindRight,
            settingsVer = settingsVer
        }
        serialized = lume.serialize(settingdata)
        love.filesystem.write("settings", serialized)
        graphics:fadeOutWipe(
            0.7,
            function()
                Gamestate.switch(menuSelect)
                status.setLoading(false)
            end
        )
    end

	
end
--[[

function love.load() -- Todo, add custom framerate support

end
]]

UNLOCKED_ALL = false
function love.load()
	paused = false
	settings = {}
	local curOS = love.system.getOS()

	-- Load libraries
	baton = require "lib.baton"
	ini = require "lib.ini"
	lovesize = require "lib.lovesize"
	Gamestate = require "lib.gamestate"
	Timer = require "lib.timer"
	json = require "lib.json"
	lume = require "lib.lume"

	-- Load modules
	status = require "modules.status"
	audio = require "modules.audio"
	graphics = require "modules.graphics"
	camera = require "modules.camera"
	beatHandler = require "modules.beatHandler"
	util = require "modules.util"
	cutscene = require "modules.cutscene"
	dialogue = require "modules.dialogue"
	settings = require "settings"
	lyrics = require "modules.lyrics"

	playMenuMusic = true

	scrollingBG = {
		vx = -25,
		vy = -25,
		x = 0,
		y = 0,
		alpha = 0,
		img = graphics.newImage(graphics.imagePath("scrollingBG")),

		update = function(self, dt)
			self.x = self.x + self.vx * dt
			self.y = self.y + self.vy * dt
			-- at a certain point, reset the position
			if self.x < -self.img:getWidth() then
				self.x = 0
			end
			if self.y < -self.img:getHeight() then
				self.y = 0
			end
		end,

		draw = function(self)
			graphics.setColor(1, 1, 1, self.alpha)
			for x = -5, 20 do
				for y = -5, 20 do
					self.img.x = self.x + (self.img:getWidth() * (x - 1))
					self.img.y = self.y + (self.img:getHeight() * (y - 1))
					self.img:draw()
				end
			end
		end
	}

	if love.filesystem.getInfo("settings") then 
		settingdata = love.filesystem.read("settings")
		settingdata = lume.deserialize(settingdata)
	
		settings.hardwareCompression = settingdata.saveSettingsMoment.hardwareCompression
		settings.downscroll = settingdata.saveSettingsMoment.downscroll
		settings.ghostTapping = settingdata.saveSettingsMoment.ghostTapping
		settings.showDebug = settingdata.saveSettingsMoment.showDebug
		graphics.setImageType(settingdata.saveSettingsMoment.setImageType)
		settings.sideJudgements = settingdata.saveSettingsMoment.sideJudgements
		settings.botPlay = settingdata.saveSettingsMoment.botPlay
		settings.middleScroll = settingdata.saveSettingsMoment.middleScroll
		settings.practiceMode = settingdata.saveSettingsMoment.practiceMode
		settings.noMiss = settingdata.saveSettingsMoment.noMiss
		settings.customScrollSpeed = settingdata.saveSettingsMoment.customScrollSpeed
		settings.scrollUnderlayTrans = settingdata.saveSettingsMoment.scrollUnderlayTrans
		settings.noteSkins = settingdata.saveSettingsMoment.noteSkins
		customBindDown = settingdata.saveSettingsMoment.customBindDown
		customBindUp = settingdata.saveSettingsMoment.customBindUp
		customBindLeft = settingdata.saveSettingsMoment.customBindLeft
		customBindRight = settingdata.saveSettingsMoment.customBindRight

		settings.mirrorMode = settingdata.saveSettingsMoment.mirrorMode
		settings.selfAwareness = settingdata.saveSettingsMoment.selfAwareness
	
		settingsVer = settingdata.saveSettingsMoment.settingsVer
	
		settingdata.saveSettingsMoment = {
			hardwareCompression = settings.hardwareCompression,
			downscroll = settings.downscroll,
			ghostTapping = settings.ghostTapping,
			showDebug = settings.showDebug,
			setImageType = "dds",
			sideJudgements = settings.sideJudgements,
			botPlay = settings.botPlay,
			middleScroll = settings.middleScroll,
			practiceMode = settings.practiceMode,
			noMiss = settings.noMiss,
			customScrollSpeed = settings.customScrollSpeed,
			keystrokes = settings.keystrokes,
			scrollUnderlayTrans = settings.scrollUnderlayTrans,
			customBindDown = customBindDown,
			customBindUp = customBindUp,
			customBindLeft = customBindLeft,
			customBindRight = customBindRight,
			mirrorMode = settings.mirrorMode,
			selfAwareness = settings.selfAwareness,
			settingsVer = settingsVer
		}
		serialized = lume.serialize(settingdata)
		love.filesystem.write("settings", serialized)
	end
	if settingsVer ~= 9 then
		love.window.showMessageBox("Uh Oh!", "Settings have been reset.", "warning")
		love.filesystem.remove("settings")
	end
	if not love.filesystem.getInfo("settings") or settingsVer ~= 9 then
		settings.hardwareCompression = true
		graphics.setImageType("dds")
		settings.downscroll = false
		settings.middleScroll = false
		settings.ghostTapping = true
		settings.showDebug = false
		settings.sideJudgements = false
		settings.botPlay = false
		settings.practiceMode = false
		settings.noMiss = false
		settings.customScrollSpeed = 1
		settings.keystrokes = false
		settings.scrollUnderlayTrans = 0
		settings.mirrorMode = false
		--settings.noteSkins = 1
		customBindLeft = "a"
		customBindRight = "d"
		customBindUp = "w"
		customBindDown = "s"
	
		settings.flashinglights = false
		selfAwareness = true
		settingsVer = 9
		settingdata = {}
		settingdata.saveSettingsMoment = {
			hardwareCompression = settings.hardwareCompression,
			downscroll = settings.downscroll,
			ghostTapping = settings.ghostTapping,
			showDebug = settings.showDebug,
			setImageType = "dds",
			sideJudgements = settings.sideJudgements,
			botPlay = settings.botPlay,
			middleScroll = settings.middleScroll,
			practiceMode = settings.practiceMode,
			noMiss = settings.noMiss,
			customScrollSpeed = settings.customScrollSpeed,
			keystrokes = settings.keystrokes,
			scrollUnderlayTrans = settings.scrollUnderlayTrans,
			mirrorMode = settings.mirrorMode,
			customBindLeft = customBindLeft,
			customBindRight = customBindRight,
			customBindUp = customBindUp,
			customBindDown = customBindDown,
			selfAwareness = settings.selfAwareness,
			
			settingsVer = settingsVer
		}
		serialized = lume.serialize(settingdata)
		love.filesystem.write("settings", serialized)
	end

	volumeWidth = {width = 160}
	volFade = 0

	-- Load settings
	--settings = require "settings"
	input = require "input"

	-- Load Debugs
	debugMenu = require "states.debug.debugMenu"
	spriteDebug = require "states.debug.sprite-debug"
	stageDebug = require "states.debug.stage-debug"

	-- Load stages
	stages = {
		["bigroom"] = require "stages.bigroom",
		["clubroom"] = require "stages.clubroom",
		["clubroom-festival"] = require "stages.clubroom-festival",
		["musicroom"]  = require "stages.musicroom",
		["ynm"] = require "stages.ynm",
		["medley"] = require "stages.medley",
		["school"] = require "stages.school",
		["wilted"] = require "stages.wilted",
		["drinks"] = require "stages.drinks",
		["epiphany"] = require "stages.epiphany",
		["libitina"] = require "stages.libitina"
	}

	-- Load Menus
	clickStart = require "states.click-start"
	menu = require "states.doki.menu"
	menuWeek = require "states.doki.story"
	menuFreeplay = require "states.doki.freeplay"
	menuSettings = require "states.doki.options"
	menuCredits = require "states.menu.menuCredits"
	menuSelect = require "states.doki.select"
	
	chooseDoki = require "states.misc.chooseDoki"

	firstStartup = true

	-- Load weeks
	weeks = require "states.weeks"

	-- Load substates
	gameOver = require "substates.game-over"
	settingsKeybinds = require "substates.settings-keybinds"

	-- Load week data
	weekData = {
		require "weeks.week6",
		require "weeks.sayori",
		require "weeks.natsuki",
		require "weeks.yuri",
		require "weeks.monika",
		require "weeks.festival",
		require "weeks.encore",
		require "weeks.mc",
		require "weeks.girlfriend",
		require "weeks.zipper",
		require "states.misc.chooseDoki",
		require "weeks.wilted",
		require "weeks.drinks",
		require "weeks.dual-demise",
		require "weeks.epiphany",
		require "weeks.libitina",
	}

	weekDesc = { -- Add your week description here
		"HATING SIMULATOR FT. MOAWLING",
	}

	weekMeta = { -- Add/remove weeks here
		{
			"Pixel Monika",
			{
				"High School Conflict",
				"Bara No Yume",
				"Your Demise",
				"Your Reality",
			},
		},
		{
			"Sayori",
			{
				"Rain Clouds",
				"My Confession"
			}
		},
		{
			"Natsuki",
			{
				"My Sweets",
				"Baka"
			}
		},
		{
			"Yuri",
			{
				"Deep Breaths",
				"Obsession"
			}
		},
		{
			"Monika",
			{
				"Reconsiliation",
			}
		},
		{
			"Festival",
			{
				"Crucify (Yuri Mix)",
				"beathoven (Natsuki Mix)",
				"It's Complicated (Sayori Mix)",
				"Glitcher (Monika Mix)",
				"Titular (MC Mix)"
			}
		},
		{
			"Encore",
			{
				"Hot Air Balloon",
				"Shrinking Violet",
				"Joyride",
				"Our Harmony"
			}
		},
		{
			"MC",
			{
				"NEET",
				"You and Me",
				"Takeover Medley"
			}
		},
		{
			"Girlfriend",
			{
				"Love N Funkin",
			}
		},
		{
			"Zipper",
			{
				"Constricted"
			}
		},
		{
			"Catfight",
			{
				"Catfight"
			}
		},
		{
			"Wilted",
			{
				"Wilted"
			}
		},
		{
			"Drinks On Me",
			{
				"Drinks On Me"
			}
		},
		{
			"Dual Demise",
			{
				"Dual Demise"
			}
		},
		{
			"Epiphany",
			{
				"Epiphany"
			}
		},
		--[[ -- Not available in this release.
		{
			"Libitina",
			{
				"Libitina"
			}
		},
		--]]
	}

	catfight = require "weeks.catfight"

	glitchy = love.graphics.newShader("shaders/pixel.glsl")
	fisheye = love.graphics.newShader("shaders/fisheye.glsl")
	glitch = love.graphics.newShader("shaders/glitch.glsl")
	static = love.graphics.newShader("shaders/static.glsl")

	highscore = require "modules.highscore"
	highscore:loadFile()

	function set_preset()
		presetData = json.decode(love.filesystem.read("data/glitch.json")).presets[1]
		glitch:send("prob", (0.25 - (presetData[1]/8)))
		glitch:send("intensityChromatic", presetData[2])
	end

	set_preset()

	math.randomseed(os.time())

	SaveData = {
		weekUnlocked = 1,
		costumes = {
			sayori = "default",
			natsuki = "default",
			yuri = "default",
			monika = "default",
			mc = "default",
			boyfriend = "default",
			girlfriend = "default",
		},
		songs = {
			beatPrologue = false,
			beatSayori = false,
			beatNatsuki = false,
			beatYuri = false,
			beatMonika = false,
			beatFestival = false,
			beatEncore = false,
			beatProtag = false,
			beatSide = false,
			unlockedEpiphany = false,
			beatEpiphany = false,
			beatCatfight = false,
			beatVA11HallA = false,
			beatLibitina = false,
			sideStatus = {}
		},
		costumeUnlock = {
			unlockHFCostume = false,
			unlockAntipathyCostume = false,
			unlockSoftCostume = false,
		},
		yam = {
			yamMonika = false,
			yamSayori = false,
			yamNatsuki = false,
			yamYuri = false,
			yamLoss = false,
		},
		popup = {
			popupPrologue = false,
			popupSayori = false,
			popupNatsuki = false,
			popupYuri = false,
			popupMonika = false,
			popupFestival = false,
			popupEncore = false,
			popupProtag = false,
			popupSide = false,
			popupEpiphany = false,
			popupLibitina = false,
		}
	}

	local curSave
	local function recursiveCheck(tbl, save)
		for i, v in pairs(tbl) do
			if type(v) == "table" then
				recursiveCheck(v, save[i])
			else
				if save[i] then
					tbl[i] = save[i]
				end
			end
		end
	end
	if love.filesystem.getInfo("save") then
		curSave = love.filesystem.read("save")
		curSave = lume.deserialize(curSave)
		recursiveCheck(SaveData, curSave)
	end

	if UNLOCKED_ALL then
		SaveData.weekUnlocked = 10
		print("Unlocked")
		for i, v in pairs(SaveData.songs) do
			if type(v) == "boolean" then
				SaveData.songs[i] = true
			end
		end
	end

	function checkAllSongsBeaten(checkLibitina)
		local freeplayList

		for i = 1, 5 do
			freeplayList = util.coolTextFile("data/freeplay/Page" .. i .. ".txt")

			for j = 1, #freeplayList do
				local song = util.split(freeplayList[j], ":")
				if song[1]:lower() == "erb" then
					goto continue
				end
				if song[1]:lower() == "epiphany" then
					goto continue
				end
				if not checkLibitina and song[1]:lower() == "libitina" then
					goto continue
				end

				if highscore:getScore(song[1], 1) < 1 and highscore:getMirrorScore(song[1], 1) < 1 then
					return false
				end

				::continue::
			end
		end

		return true
	end

	costumes = {
		["sayori"] = {
			order = {},
		},
		["natsuki"] = {
			order = {},
		},
		["yuri"] = {
			order = {},
		},
		["monika"] = {
			order = {},
		},
		["protag"] = {
			order = {},
		},
		["boyfriend"] = {
			order = {},
		},
		["girlfriend"] = {
			order = {},
		},
	}

	-- LÖVE init
	if curOS == "OS X" then
		love.window.setIcon(love.image.newImageData("icons/macos.png"))
	else
		love.window.setIcon(love.image.newImageData("icons/default.png"))
	end

	lovesize.set(1280, 720)

	-- Variables
	font = love.graphics.newFont("fonts/vcr.ttf", 24)
	FNFFont = love.graphics.newFont("fonts/fnFont.ttf", 24)
	credFont = love.graphics.newFont("fonts/fnFont.ttf", 32)   -- guglio is a bitch 
	uiFont = love.graphics.newFont("fonts/Dosis-SemiBold.ttf", 32)
	pauseFont = love.graphics.newFont("fonts/Dosis-SemiBold.ttf", 96)
	weekFont = love.graphics.newFont("fonts/Dosis-SemiBold.ttf", 84)
	weekFontSmall = love.graphics.newFont("fonts/Dosis-SemiBold.ttf", 54)
	riffic = love.graphics.newFont("fonts/riffic.ttf", 20 * 1.5)
	tracklistFont = love.graphics.newFont("fonts/riffic.ttf", 32)
	weekTitleFont = love.graphics.newFont("fonts/riffic.ttf", 32 * 1.2)
	freeplayFont = love.graphics.newFont("fonts/Halogen.otf", 29)
	optionsFont = love.graphics.newFont("fonts/riffic.ttf", 36)
	optionDescFont = love.graphics.newFont("fonts/Aller_Rg.ttf", 16)

	weekNum = 1
	songDifficulty = 2

	storyMode = false
	countingDown = false

	uiScale = {zoom = 1, x = 1, y = 1, sizeX = 1, sizeY = 1}

	musicTime = 0
	health = 0

	music = love.audio.newSource("music/menu/freakyMenu.ogg", "stream")
	music:setLooping(true)

	fixVol = tonumber(string.format(
		"%.1f  ",
		(love.audio.getVolume())
	))

	if curOS == "Web" then
		Gamestate.switch(clickStart)
	else
		Gamestate.switch(menu)
	end
end

function love.resize(width, height)
	if shaderCanvas then
		shaderCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
	end
	if funCanvas then
		funCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
	end
	if funCanvas2 then
		funCanvas2 = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
	end
	lovesize.resize(width, height)
end

function love.keypressed(key)
	if key == "6" then
		love.filesystem.createDirectory("screenshots")

		love.graphics.captureScreenshot("screenshots/" .. os.time() .. ".png")
	elseif key == "7" then
		Gamestate.switch(debugMenu)
	elseif key == "0" then
		volFade = 1
		if fixVol == 0 then
			love.audio.setVolume(lastAudioVolume)
		else
			lastAudioVolume = love.audio.getVolume()
			love.audio.setVolume(0)
		end
	elseif key == "-" then
		volFade = 1
		if fixVol > 0 then
			love.audio.setVolume(love.audio.getVolume() - 0.1)
		end
	elseif key == "=" then
		volFade = 1
		if fixVol <= 0.9 then
			love.audio.setVolume(love.audio.getVolume() + 0.1)
		end
    else
		Gamestate.keypressed(key)
	end
end

function love.textinput(t)
	Gamestate.textinput(t)
end

function love.mousepressed(x, y, button, istouch, presses)
	Gamestate.mousepressed(x, y, button, istouch, presses)
end

function love.update(dt)
	dt = math.min(dt, 1 / 30)
	if volFade > 0 then
		volFade = volFade - 1 * dt
	end

	input:update()

	if status.getNoResize() then
		Gamestate.update(dt)
	else
		love.graphics.setFont(font)
		graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.update(dt)
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())
		love.graphics.setFont(font)
	end

	Timer.update(dt)
end

function love.draw()
	love.graphics.setFont(font)
	graphics.screenBase(lovesize.getWidth(), lovesize.getHeight())
	lovesize.begin()
		graphics.setColor(1, 1, 1) -- Fade effect on
		Gamestate.draw()
		love.graphics.setColor(1, 1, 1) -- Fade effect off
		love.graphics.setFont(font)
		if status.getLoading() then
			love.graphics.print("Loading...", lovesize.getWidth() - 175, lovesize.getHeight() - 50)
		end
		if volFade > 0  then
			love.graphics.setColor(1, 1, 1, volFade)
			fixVol = tonumber(string.format(
				"%.1f  ",
				(love.audio.getVolume())
			))
			love.graphics.setColor(0.5, 0.5, 0.5, volFade - 0.3)

			love.graphics.rectangle("fill", 1110, 0, 170, 50)

			love.graphics.setColor(1, 1, 1, volFade)

			if volTween then Timer.cancel(volTween) end
			volTween = Timer.tween(
				0.2, 
				volumeWidth, 
				{width = fixVol * 160},
				"out-quad"
			)
			love.graphics.rectangle("fill", 1113, 10, volumeWidth.width, 30)
			graphics.setColor(1, 1, 1, 1)
		end
		if fade.mesh then 
			graphics.setColor(1,1,1)
			love.graphics.draw(fade.mesh, 0, fade.y, 0, lovesize.getWidth(), fade.height)
		end
	lovesize.finish()

	graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())

	-- Debug output
	if settings.showDebug and not (Gamestate.current() == debugMenu or Gamestate.current() == stageDebug or Gamestate.current() == spriteDebug) then
		borderedText(status.getDebugStr(settings.showDebug), 5, 5, nil, 0.6, 0.6)
	end
end

function love.focus(t)
	Gamestate.focus(t)
end

function love.quit()
	-- save SaveData
	if not UNLOCKED_ALL then
		local serialized = lume.serialize(SaveData)
		love.filesystem.write("save", serialized)
	end
	highscore:saveFile()
end