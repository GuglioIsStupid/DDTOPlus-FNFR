--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

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

local animList = {
	"singLEFT",
	"singDOWN",
	"singUP",
	"singRIGHT"
}
local inputList = {
	"gameLeft",
	"gameDown",
	"gameUp",
	"gameRight"
}
local arrowAngles = {math.rad(180), math.rad(90), math.rad(270), math.rad(0)}
if settings.downscroll then
	-- ezezezezezezezezezezezezez workaround lol
	arrowAngles = {math.rad(180), math.rad(270), math.rad(90), math.rad(0)}
end
local noteCamTweens = {
	function()
		camera:moveToExtra((60/bpm), 15, 0)
	end,

	function()
		camera:moveToExtra((60/bpm), 0, -15)
	end,

	function()
		camera:moveToExtra((60/bpm), 0, 15)
	end,

	function()
		camera:moveToExtra((60/bpm), -15, 0)
	end
}

local ratingTimers = {}

local useAltAnims
local notMissed = {}
local option = "normal"

return {
	enter = function(self, option)
		FORCEP2NOMATTERWHAT = false
		playMenuMusic = false
		beatHandler.reset()
		option = option or "normal"
		camera.x, camera.y = 0, 0
		camera.zooming, camera.locked = false, false

		arrowAngles = {math.rad(180), math.rad(90), math.rad(270), math.rad(0)}
		if settings.downscroll then
			-- ezezezezezezezezezezezezez workaround lol
			arrowAngles = {math.rad(180), math.rad(270), math.rad(90), math.rad(0)}
		end

		if option ~= "pixel" then
			pixel = false
			sounds = {
				countdown = {
					three = love.audio.newSource("sounds/countdown-3.ogg", "static"),
					two = love.audio.newSource("sounds/countdown-2.ogg", "static"),
					one = love.audio.newSource("sounds/countdown-1.ogg", "static"),
					go = love.audio.newSource("sounds/countdown-go.ogg", "static")
				},
				miss = {
					love.audio.newSource("sounds/miss1.ogg", "static"),
					love.audio.newSource("sounds/miss2.ogg", "static"),
					love.audio.newSource("sounds/miss3.ogg", "static")
				},
				death = love.audio.newSource("sounds/death.ogg", "static"),
				breakfast = love.audio.newSource("music/breakfast.ogg", "stream")
			}

			images = {
				icons = love.graphics.newImage(graphics.imagePath("icons")),
				notes = love.graphics.newImage(graphics.imagePath("notesM")),
				numbers = love.graphics.newImage(graphics.imagePath("numbers")),
				numbersp = love.graphics.newImage(graphics.imagePath("pixel/numbers")),
				notesplashes = love.graphics.newImage(graphics.imagePath("noteSplashes")),
				notesp = love.graphics.newImage(graphics.imagePath("pixel/notes")),
				notesplashesp = love.graphics.newImage(graphics.imagePath("pixel/pixelSplashes"))
			}

			sprites = {
				icons = love.filesystem.load("sprites/icons.lua"),
				numbers = love.filesystem.load("sprites/numbers.lua"),
				numbersP = love.filesystem.load("sprites/pixel/numbers.lua"),
				noteSplash = love.filesystem.load("sprites/noteSplashes.lua"),
				noteSplashP = love.filesystem.load("sprites/pixel/pixelSplashes.lua")
			}

			rating = love.filesystem.load("sprites/rating.lua")()
			ratingP = love.filesystem.load("sprites/pixel/rating.lua")()

			rating.sizeX, rating.sizeY = 0.75, 0.75

			girlfriend = love.filesystem.load("sprites/characters/girlfriend/" .. SaveData.costumes.girlfriend .. ".lua")()
			boyfriend = love.filesystem.load("sprites/characters/boyfriend/" .. SaveData.costumes.boyfriend .. ".lua")()
		else
			pixel = true
			love.graphics.setDefaultFilter("nearest", "nearest")
			sounds = {
				countdown = {
					three = love.audio.newSource("sounds/pixel/countdown-3.ogg", "static"),
					two = love.audio.newSource("sounds/pixel/countdown-2.ogg", "static"),
					one = love.audio.newSource("sounds/pixel/countdown-1.ogg", "static"),
					go = love.audio.newSource("sounds/pixel/countdown-date.ogg", "static")
				},
				miss = {
					love.audio.newSource("sounds/pixel/miss1.ogg", "static"),
					love.audio.newSource("sounds/pixel/miss2.ogg", "static"),
					love.audio.newSource("sounds/pixel/miss3.ogg", "static")
				},
				death = love.audio.newSource("sounds/pixel/death.ogg", "static"),
				breakfast = love.audio.newSource("music/breakfast.ogg", "stream")
			}

			images = {
				icons = love.graphics.newImage(graphics.imagePath("icons")),
				notesp = love.graphics.newImage(graphics.imagePath("pixel/notes")),
				numbersp = love.graphics.newImage(graphics.imagePath("pixel/numbers")),
				notesplashesp = love.graphics.newImage(graphics.imagePath("pixel/pixelSplashes"))
			}

			sprites = {
				icons = love.filesystem.load("sprites/icons.lua"),
				numbers = love.filesystem.load("sprites/pixel/numbers.lua"),
				noteSplash = love.filesystem.load("sprites/pixel/pixelSplashes.lua")
			}

			rating = love.filesystem.load("sprites/pixel/rating.lua")()

			girlfriend = love.filesystem.load("sprites/pixel/girlfriend.lua")()
			boyfriend = love.filesystem.load("sprites/characters/pixel/boyfriend.lua")()
		end

		numbers = {}
		numbersP = {}
		for i = 1, 3 do
			numbers[i] = sprites.numbers()

			if option ~= "pixel" then
				numbers[i].sizeX, numbers[i].sizeY = 0.5, 0.5
			end
		end

		if settings.downscroll then
			downscrollOffset = -750
		else
			downscrollOffset = 0
		end

		enemyIcon = sprites.icons()
		boyfriendIcon = sprites.icons()

		enemyIcon.y = 350 + downscrollOffset
		boyfriendIcon.y = 350 + downscrollOffset
		enemyIcon.sizeX = 1.5
		boyfriendIcon.sizeX = -1.5
		enemyIcon.sizeY = 1.5
		boyfriendIcon.sizeY = 1.5

		countdownFade = {}
		countdown = love.filesystem.load("sprites/countdown.lua")()

		bars = {}
		bars[1] = {
			y = -95,
			height = 95,
		}
		bars[2] = {
			y = 815,
			height = 95,
		}

		self.d_sprites = {}

		mirrorMode = settings.mirrorMode
	end,

	load = function(self)
		self.blackscreen = {
			alpha = 0,
			visible = false
		}
		changeIcons = true
		showEnemyIcon = true
		botplayY = 0
		botplayAlpha = {1}
		paused = false
		pauseMenuSelection = 1
		function boyPlayAlphaChange()
			Timer.tween(1.25, botplayAlpha, {0}, "in-out-cubic", function()
				Timer.tween(1.25, botplayAlpha, {1}, "in-out-cubic", boyPlayAlphaChange)
			end)
		end

		uiAlpha = {1}
		boyPlayAlphaChange()
		pauseBG = graphics.newImage(graphics.imagePath("pause/pause_box"))
		pauseShadow = graphics.newImage(graphics.imagePath("pause/pause_shadow"))
		for i = 1, 4 do
			notMissed[i] = true
		end
		useAltAnims = false

		camera.x, camera.y = -boyfriend.x + 100, -boyfriend.y + 75

		rating.x = 20
		if ratingP then
			ratingP.x = 20
		end
		if not pixel then
			for i = 1, 3 do
				numbers[i].x = -100 + 50 * i
			end
		else
			for i = 1, 3 do
				numbers[i].x = -100 + 58 * i
			end
		end
		if numbersP[1] then
			for i = 1, 3 do
				numbersP[i].x = -100 + 58 * i
			end
		end

		ratingVisibility = {0}
		ratingVisibilityP = {0}
		combo = 0

		if curEnemy ~= "monikaALT" then
			enemy:animate("idle")
		else
			enemy:animate("idle alt")
		end
		if enemy2 then enemy2:animate("idle") end
		if enemy3 then enemy3:animate("idle") end
		boyfriend:animate("idle")
		if boyfriend2 then boyfriend2:animate("idle") end

		if not camera.points["boyfriend"] then camera:addPoint("boyfriend", -boyfriend.x + 100, -boyfriend.y + 75) end
		if not camera.points["enemy"] then camera:addPoint("enemy", -enemy.x - 100, -enemy.y + 75) end

		if hasPixelNotes then
			for i = 1, 3 do
				numbersP[i] = sprites.numbersP()
				if option ~= "pixel" then
					numbersP[i].sizeX, numbersP[i].sizeY = 0.5, 0.5
				end

				numbersP[i].x = -100 + 58 * i
			end
		end

		camera.zooming = true
		camera.locked = false

		self.did = false
		self.canCarryOn = true

		graphics:fadeInWipe(0.6)
	end,

	calculateRating = function(self)
		ratingPercent = score / ((noteCounter + misses) * 350)
		if ratingPercent == nil or ratingPercent < 0 then 
			ratingPercent = 0
		elseif ratingPercent > 1 then
			ratingPercent = 1
		end
	end,

	setupDialogue = function(self, file, config)
		if not storyMode then
			return
		end
		self.dialogueSequenceCallback = function() end

		self.displayDialogue = true

		inCutscene = true

		self.dialogueData = json.decode(love.filesystem.read(file))
		if music then 
			music:stop()
		end
		if self.dialogueData.startingMusic == "Lunchbox" then
			music = love.audio.newSource("music/pixel/Lunchbox.ogg", "stream")
		else
			music = nil
		end

		self.boxes = {}
		self.speakers = {}

		if self.dialogueData.initStyle == "pixel" then
			self.boxes["monika"] = love.filesystem.load("sprites/week6/dialogueBox-monika.lua")()
			self.boxes["default"] = love.filesystem.load("sprites/week6/dialogueBox.lua")()

			self.boxes["monika"].x = 650
			self.boxes["default"].x = 650
			self.boxes["monika"].y = 375
			self.boxes["default"].y = 375

			self.speakers["monika"] = love.filesystem.load("sprites/dialogue/pixel/monika.lua")()
			self.speakers["bf"] = love.filesystem.load("sprites/dialogue/pixel/bf.lua")()
			self.speakers["senpai"] = love.filesystem.load("sprites/dialogue/pixel/senpai.lua")()

			self.speakers["monika"].y = 205
			self.speakers["bf"].y = 205
			self.speakers["senpai"].y = 205

			self.boxes["monika"].sizeX, self.boxes["monika"].sizeY = 5, 6
			self.boxes["default"].sizeX, self.boxes["default"].sizeY = 5, 6

			self.speakers["monika"].sizeX, self.speakers["monika"].sizeY = 6, 6
			self.speakers["bf"].sizeX, self.speakers["bf"].sizeY = 6, 6
			self.speakers["senpai"].sizeX, self.speakers["senpai"].sizeY = 6, 6

			self.dialogueSounds = {
				text = love.audio.newSource("sounds/pixel/text.ogg", "static"),
				confirm = love.audio.newSource("sounds/pixel/continue-text.ogg", "static"),
			}
		end

		self.d_cur = 1
		self.d_timer = 0
		self.d_progress = 1
		self.d_output = ""
		self.d_isDone = false
		self.d_charSpeaking = ""
		self.d_fullDialogue = ""
		self.d_curExpression = ""
		self.d_rightSpr = nil
		self.d_leftSpr = nil

		self.d_sprites = {}

		self.d_isEndDialogue = config and config.isEndDialogue or false

		if music then
			music:setLooping(true)
			music:play()
		end
	end,

	d_update = function(self, dt)
		for i = 1, #self.d_sprites do
			if self.d_sprites[i].update then
				self.d_sprites[i]:update(dt)
			end
		end
		if self.d_isDone then
			return
		end
		if not self.dialogueData then
			return
		end
		-- is next char different?
		if self.d_charSpeaking ~= self.dialogueData.dialogue[self.d_cur].name and self.speakers[self.d_charSpeaking] then
			self.speakers[self.d_charSpeaking].visible = true
		else
			if self.d_side ~= self.dialogueData.dialogue[self.d_cur].side and self.speakers[self.d_charSpeaking] then
				self.speakers[self.d_charSpeaking].visible = true
			end
		end
		self.d_charSpeaking = self.dialogueData.dialogue[self.d_cur].name
		self.d_curExpression = self.dialogueData.dialogue[self.d_cur].expression
		self.d_isCommand = self.dialogueData.dialogue[self.d_cur].isCommand
		self.d_side = self.dialogueData.dialogue[self.d_cur].side
		self.d_fullDialogue = self.dialogueData.dialogue[self.d_cur].string
		self.d_duration = self.dialogueData.dialogue[self.d_cur].duration

		if not self.d_isCommand then
			if self.speakers[self.d_charSpeaking] then
				if self.d_side == "left" then
					self.speakers[self.d_charSpeaking].x = 340
					self.d_leftSpr = self.speakers[self.d_charSpeaking]
				elseif self.d_side == "right" then
					self.speakers[self.d_charSpeaking].x = 980
					self.speakers[self.d_charSpeaking].flipX = true
					self.d_rightSpr = self.speakers[self.d_charSpeaking]
				else
					self.speakers[self.d_charSpeaking].x = 640
				end
				self.speakers[self.d_charSpeaking]:animate(self.d_curExpression)
				self.speakers[self.d_charSpeaking]:update(dt)
			end

			if self.boxes[self.d_charSpeaking] then
				self.boxes[self.d_charSpeaking]:update(dt)
			else
				self.boxes["default"]:update(dt)
			end

			if music then
				if not music:isPlaying() then
					music:play()
				end
			end

			self.d_timer = self.d_timer + dt

			if self.d_timer > 0.05 then
				if self.d_progress < #self.d_fullDialogue then
					self.dialogueSounds.text:play()
					self.d_progress = self.d_progress + 1
					self.d_output = self.d_fullDialogue:sub(1, math.floor(self.d_progress))

					self.d_timer = 0
				else
					self.d_timer = 0
				end
			end
		else

			self:d_next(true)
			self:d_command()
		end
	end,

	dialogueSequenceCallback = function(self)
		
	end,
	
	did = false,

	d_command = function(self)
		if self.d_isDone then
			return
		end
		local cmd = self.d_charSpeaking
		local arg = self.d_fullDialogue
		local duration = self.d_duration

		if cmd == "playsound" then
		elseif cmd == "startmusic" then
		elseif cmd == "glitch" then
		elseif cmd == "autoskip" then
		elseif cmd == "hideright" then
			if self.d_rightSpr then
				self.d_rightSpr.visible = false
			end
		elseif cmd == "hideleft" then
			if self.d_leftSpr then
				self.d_leftSpr.visible = false
			end
		elseif cmd == "crash" then
			-- save data
			error(":)")
		elseif cmd == "showbackgroundimage" then
			local spr = graphics.newImage(graphics.imagePath("dialogue/" .. arg))
			spr.name = arg
			table.insert(self.d_sprites, spr)
		elseif cmd == "hidebackground" then
			for i = 1, #self.d_sprites do
				if self.d_sprites[i].name == arg then
					table.remove(self.d_sprites, i)
				end
			end
		elseif cmd == "fadeout" then
			self.canCarryOn = false
			print("FADE OUT")
			Timer.tween(duration, self.blackscreen, {alpha = 1}, "in-out-cubic", function()
				self.blackscreen.visible = true
				self.canCarryOn = true
				self.displayDialogue = false
				print("FADED OUT DONE")
			end)
		elseif cmd == "fadein" then
			self.canCarryOn = false
			print("FADE IN")
			Timer.tween(duration, self.blackscreen, {alpha = 0}, "in-out-cubic", function()
				self.blackscreen.visible = false
				self.canCarryOn = true
				self.displayDialogue = true
				print("FADED IN DONE")
			end)
		elseif cmd == "hidedialogue" then
		elseif cmd == "hidebgfade" then
		elseif cmd == "showbgFade" then
		elseif cmd == "flash" then
		elseif cmd == "shake" then
		elseif cmd == "fadecg" then
		elseif cmd == "swapstyle" or cmd == "styleswap" then
		elseif cmd == "playcutscene" then
			--[[ if arg == "fakeout" then ]]
			self.displayDialogue = false
			--[[ end ]]

			self:playbackCutscene(arg, duration)
		end

		self:d_next(true)
	end,

	d_next = function(self, wasCommand)
		if not self.canCarryOn then
			return
		end
		if not self.dialogueData then
			return
		end
		if not self.displayDialogue then
			return
		end
		if wasCommand then
			if self.d_cur < #self.dialogueData.dialogue then
				self.d_cur = self.d_cur + 1
				self.d_timer = 0
				self.d_progress = 1
				self.d_output = ""

				if self.speakers[self.d_charSpeaking] then
					if self.speakers[self.d_charSpeaking].repeatAnim then
						self.speakers[self.d_charSpeaking]:animate(self.d_curExpression)
					end
				end

				if self.boxes[self.d_charSpeaking] then
					if self.boxes[self.d_charSpeaking].repeatAnim then
						self.boxes[self.d_charSpeaking]:animate("anim")
					end
				else
					if self.boxes["default"].repeatAnim then
						self.boxes["default"]:animate("anim")
					end
				end
			else
				self.d_isDone = true

				if self.d_isEndDialogue then
					print("FINISHED END")
					self:dialogueSequenceCallback()

					if music then
						music:stop()
					end
				else
					print("FINISHED INTRO")
					self:dialogueSequenceCallback()
					inCutscene = false
				end
			end

			return
		end
		if not self.d_fullDialogue then
			return
		end
		
		self.dialogueSounds.confirm:play()

		if self.d_progress < #self.d_fullDialogue then
			self.d_progress = #self.d_fullDialogue
			self.d_output = self.d_fullDialogue
		else
			if self.d_cur < #self.dialogueData.dialogue then
				self.d_cur = self.d_cur + 1
				self.d_timer = 0
				self.d_progress = 1
				self.d_output = ""

				if self.speakers[self.d_charSpeaking] then
					if self.speakers[self.d_charSpeaking].repeatAnim then
						self.speakers[self.d_charSpeaking]:animate(self.d_curExpression)
					end
				end
			
				if self.boxes[self.d_charSpeaking] then
					if self.boxes[self.d_charSpeaking].repeatAnim then
						self.boxes[self.d_charSpeaking]:animate("anim")
					end
				else
					if self.boxes["default"].repeatAnim then
						self.boxes["default"]:animate("anim")
					end
				end
			else
				self.d_isDone = true

				if self.d_isEndDialogue then
					print("FINISHED END")
					self:dialogueSequenceCallback()

					if music then
						music:stop()
					end
				else
					print("FINISHED INTRO")
					self:dialogueSequenceCallback()
					inCutscene = false
				end
			end
		end
	end,

	d_draw = function(self)
		for i = 1, #self.d_sprites do
			love.graphics.push()
				love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
				self.d_sprites[i]:draw()
			love.graphics.pop()
		end
		if not self.displayDialogue then
			return
		end
		if not self.dialogueData then
			return
		end

		if self.d_leftSpr then
			self.d_leftSpr:draw()
		end
		if self.d_rightSpr then
			self.d_rightSpr:draw()
		end

		if self.boxes[self.d_charSpeaking] then
			self.boxes[self.d_charSpeaking]:draw()
		else
			self.boxes["default"]:draw()
		end

		local lastFont = love.graphics.getFont()
		local scale = 1
		if self.dialogueData.initStyle == "pixel" then 
			love.graphics.setFont(pixelFont)
			scale = 3
		else
			love.graphics.setFont(font)
		end
		local box = self.boxes[self.d_charSpeaking] or self.boxes["default"]
		local fw = box:getFrameWidth()*box.sizeX
		local fh = box:getFrameHeight()*box.sizeY
		love.graphics.printf(self.d_output, box.x - fw/2 + 160, box.y + 50, (fw - 350)/scale, "left", 0, scale, scale)
	end,

	playbackCutscene = function(self, id, duration)
		if id == "fakeout" and not self.did then
			self.did = true
			local schoolFakeout = love.filesystem.load("sprites/week6/evil-school.lua")()
			schoolFakeout.sizeX, schoolFakeout.sizeY = 7, 7
			table.insert(self.d_sprites, schoolFakeout)

			love.audio.play(love.audio.newSource("sounds/awhellnaw.ogg", "static"))

			Timer.after(1.3, function()
				Timer.after(0.5, function()
					self.blackscreen.visible = true
					self.blackscreen.alpha = 1
					
					song = 3
					weekData[1]:load()
				end)
			end)
		elseif id == "pixelend" and not self.did then
			local endsceneone = love.filesystem.load("sprites/week6/End1.lua")()
			endsceneone.sizeX, endsceneone.sizeY = 6, 6
			endsceneone.x = 3
			endsceneone:animate("idle")
			table.insert(self.d_sprites, endsceneone)
			self.canCarryOn = false
			self.did = true

			Timer.after(2.2, function()
				love.audio.play(love.audio.newSource("sounds/gameover/dah.ogg", "static"))
				Timer.after(2.8, function()
					self.canCarryOn = true
				end)
			end)
		end
	end,

	initUI = function(self, option)
		whoHasPixelNotes = "none"
		events = {}
		enemyNotes = {}
		boyfriendNotes = {}

		if hasPixelNotes then
			enemyNotesP = {}
			boyfriendNotesP = {}
		end
		health = 1
		score = 0
		misses = 0
		ratingPercent = 0.0
		noteCounter = 0
		showPixelNotes = false
		useUIAlphaForNotes = true

		if not pixel then
			sprites.leftArrow = love.filesystem.load("sprites/left-arrowM.lua")
			sprites.downArrow = love.filesystem.load("sprites/down-arrowM.lua")
			sprites.upArrow = love.filesystem.load("sprites/up-arrowM.lua")
			sprites.rightArrow = love.filesystem.load("sprites/right-arrowM.lua")

			sprites.leftArrowDeath = love.filesystem.load("sprites/left-arrowD.lua")
			sprites.downArrowDeath = love.filesystem.load("sprites/down-arrowD.lua")
			sprites.upArrowDeath = love.filesystem.load("sprites/up-arrowD.lua")
			sprites.rightArrowDeath = love.filesystem.load("sprites/right-arrowD.lua")

			love.graphics.setDefaultFilter("nearest", "nearest")
			sprites.leftArrowP = love.filesystem.load("sprites/pixel/left-arrow.lua")
			sprites.downArrowP = love.filesystem.load("sprites/pixel/down-arrow.lua")
			sprites.upArrowP = love.filesystem.load("sprites/pixel/up-arrow.lua")
			sprites.rightArrowP = love.filesystem.load("sprites/pixel/right-arrow.lua")
			love.graphics.setDefaultFilter("linear", "linear")
		else
			sprites.leftArrow = love.filesystem.load("sprites/pixel/left-arrow.lua")
			sprites.downArrow = love.filesystem.load("sprites/pixel/down-arrow.lua")
			sprites.upArrow = love.filesystem.load("sprites/pixel/up-arrow.lua")
			sprites.rightArrow = love.filesystem.load("sprites/pixel/right-arrow.lua")

			sprites.leftArrowDeath = love.filesystem.load("sprites/pixel/left-arrow-death.lua")
			sprites.downArrowDeath = love.filesystem.load("sprites/pixel/down-arrow-death.lua")
			sprites.upArrowDeath = love.filesystem.load("sprites/pixel/up-arrow-death.lua")
			sprites.rightArrowDeath = love.filesystem.load("sprites/pixel/right-arrow-death.lua")
		end

		enemyArrows = {
			sprites.leftArrow(),
			sprites.downArrow(),
			sprites.upArrow(),
			sprites.rightArrow()
		}
		boyfriendArrows= {
			sprites.leftArrow(),
			sprites.downArrow(),
			sprites.upArrow(),
			sprites.rightArrow()
		}
		if hasPixelNotes then
			enemyArrowsP = {
				sprites.leftArrowP(),
				sprites.downArrowP(),
				sprites.upArrowP(),
				sprites.rightArrowP()
			}
			boyfriendArrowsP = {
				sprites.leftArrowP(),
				sprites.downArrowP(),
				sprites.upArrowP(),
				sprites.rightArrowP()
			}
		end

		boyfriendSplashes = {
			sprites.noteSplash(),
			sprites.noteSplash(),
			sprites.noteSplash(),
			sprites.noteSplash()
		}
		if hasPixelNotes then
			boyfriendSplashesP = {
				sprites.noteSplashP(),
				sprites.noteSplashP(),
				sprites.noteSplashP(),
				sprites.noteSplashP()
			}
		end

		for i = 1, 4 do
			if settings.middleScroll then 
				boyfriendArrows[i].x = -410 + 165 * i
				boyfriendSplashes[i].x = -410 + 165 * i
				-- ew stuff
				enemyArrows[1].x = -925 + 165 * 1 
				enemyArrows[2].x = -925 + 165 * 2
				enemyArrows[3].x = 100 + 165 * 3
				enemyArrows[4].x = 100 + 165 * 4

				if hasPixelNotes then
					enemyArrowsP[1].x = -925 + 165 * 1 
					enemyArrowsP[2].x = -925 + 165 * 2
					enemyArrowsP[3].x = 100 + 165 * 3
					enemyArrowsP[4].x = 100 + 165 * 4

					boyfriendArrowsP[i].x = -410 + 165 * i
					boyfriendSplashesP[i].x = -410 + 165 * i
				end
			else
				enemyArrows[i].x = -925 + 165 * i
				boyfriendArrows[i].x = 100 + 165 * i
				boyfriendSplashes[i].x = 100 + 165 * i

				if hasPixelNotes then
					enemyArrowsP[i].x = -925 + 165 * i
					boyfriendArrowsP[i].x = 100 + 165 * i
					boyfriendSplashesP[i].x = 100 + 165 * i
				end
			end

			enemyArrows[i].y = -400
			boyfriendArrows[i].y = -400
			boyfriendSplashes[i].y = -400

			boyfriendArrows[i].alpha = 1
			enemyArrows[i].alpha = 1

			if hasPixelNotes then
				enemyArrowsP[i].y = -400
				boyfriendArrowsP[i].y = -400
				boyfriendSplashesP[i].y = -400
			end

			enemyArrows[i]:animate("off")
			boyfriendArrows[i]:animate("off")
			if hasPixelNotes then
				enemyArrowsP[i]:animate("off")
				boyfriendArrowsP[i]:animate("off")
			end

			if settings.downscroll then 
				enemyArrows[i].sizeY = -1
				boyfriendArrows[i].sizeY = -1
			end
			if hasPixelNotes then
				if settings.downscroll then 
					enemyArrowsP[i].sizeY = -1
					boyfriendArrowsP[i].sizeY = -1
				end
			end

			enemyNotes[i] = {}
			boyfriendNotes[i] = {}
			if hasPixelNotes then
				enemyNotesP[i] = {}
				boyfriendNotesP[i] = {}
			end
		end
	end,

	generateNotes = function(self, chart)
		local eventBpm

		chart = json.decode(love.filesystem.read(chart))
		chart = chart["song"]
		curSong = chart["song"]

		bpm = chart["bpm"]
		if not bpm or bpm == 0 then
			bpm = 100
		end
		beatHandler.setBPM(bpm)

		if settings.customScrollSpeed == 1 then
			speed = chart["speed"] or 1
		else
			speed = settings.customScrollSpeed
		end

		for i = 1, #chart["notes"] do
			for j = 1, #chart["notes"][i]["sectionNotes"] do
				local sprite
				local sectionNotes = chart["notes"][i]["sectionNotes"]

				local mustHitSection = chart["notes"][i]["mustHitSection"]
				local altAnim = chart["notes"][i]["altAnim"] or false
				local noteType = sectionNotes[j][2]
				local noteTime = sectionNotes[j][1]
				local noteVer = sectionNotes[j][4] or "0"

				eventBpm = chart.notes[i].bpm
				if eventBpm == 0 or eventBpm == nil then
					eventBpm = bpm
				end

				noteVer = tostring(noteVer) or "0"
				if j == 1 then
					table.insert(events, {eventTime = sectionNotes[1][1], mustHitSection = mustHitSection, bpm = eventBpm, altAnim = altAnim})
				end

				if noteType == 0 or noteType == 4 then
					sprite = sprites.leftArrow
					spriteD = sprites.leftArrowDeath
					if hasPixelNotes then
						spriteP = sprites.leftArrowP
					end
				elseif noteType == 1 or noteType == 5 then
					sprite = sprites.downArrow
					spriteD = sprites.downArrowDeath
					if hasPixelNotes then
						spriteP = sprites.downArrowP
					end
				elseif noteType == 2 or noteType == 6 then
					sprite = sprites.upArrow
					spriteD = sprites.upArrowDeath
					if hasPixelNotes then
						spriteP = sprites.upArrowP
					end
				elseif noteType == 3 or noteType == 7 then
					sprite = sprites.rightArrow
					spriteD = sprites.rightArrowDeath
					if hasPixelNotes then
						spriteP = sprites.rightArrowP
					end
				end

				if noteVer ~= "2" then
					if mustHitSection then
						if noteType >= 4 then
							local id = noteType - 3
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x

							table.insert(enemyNotes[id], sprite())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
							enemyNotes[id][c].ver = noteVer
							enemyNotes[id][c].time = noteTime
							if hasPixelNotes then
								table.insert(enemyNotesP[id], spriteP())
								enemyNotesP[id][c].x = x
								enemyNotesP[id][c].y = -400 + noteTime * 0.6 * speed

								if settings.downscroll then
									enemyNotesP[id][c].sizeY = -1
								end

								enemyNotesP[id][c]:animate("on", false)
							end

							if settings.downscroll then
								enemyNotes[id][c].sizeY = -1
							end
					
							enemyNotes[id][c]:animate("on", false)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #enemyNotes[id] + 1
					
									table.insert(enemyNotes[id], sprite())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									enemyNotes[id][c].ver = noteVer
					
									enemyNotes[id][c]:animate("hold", false)

									if hasPixelNotes then
										table.insert(enemyNotesP[id], spriteP())
										enemyNotesP[id][c].x = x
										enemyNotesP[id][c].y = -400 + (noteTime + k) * 0.6 * speed
					
										enemyNotesP[id][c]:animate("hold", false)
									end
								end
					
								c = #enemyNotes[id]
					
								enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
								enemyNotes[id][c]:animate("end", false)
								if hasPixelNotes then
									enemyNotesP[id][c].offsetY = 2
					
									enemyNotesP[id][c]:animate("end", false)
								end
							end
						elseif noteType < 4 and noteType >= 0 then
							local id = noteType + 1
							local c = #boyfriendNotes[id] + 1
							local x = boyfriendArrows[id].x

							table.insert(boyfriendNotes[id], sprite())
							boyfriendNotes[id][c].x = x
							boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
							boyfriendNotes[id][c].time = noteTime
							boyfriendNotes[id][c].ver = noteVer
							
							if settings.downscroll then
								boyfriendNotes[id][c].sizeY = -1
							end
					
							boyfriendNotes[id][c]:animate("on", false)

							if hasPixelNotes then
								table.insert(boyfriendNotesP[id], spriteP())
								boyfriendNotesP[id][c].x = x
								boyfriendNotesP[id][c].y = -400 + noteTime * 0.6 * speed
								boyfriendNotesP[id][c].time = noteTime

								if settings.downscroll then
									boyfriendNotesP[id][c].sizeY = -1
								end

								boyfriendNotesP[id][c]:animate("on", false)
							end
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #boyfriendNotes[id] + 1
					
									table.insert(boyfriendNotes[id], sprite())
									boyfriendNotes[id][c].x = x
									boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									boyfriendNotes[id][c].ver = noteVer
					
									boyfriendNotes[id][c]:animate("hold", false)

									if hasPixelNotes then
										table.insert(boyfriendNotesP[id], spriteP())
										boyfriendNotesP[id][c].x = x
										boyfriendNotesP[id][c].y = -400 + (noteTime + k) * 0.6 * speed

										boyfriendNotesP[id][c]:animate("hold", false)
									end
								end
					
								c = #boyfriendNotes[id]
					
								boyfriendNotes[id][c].offsetY = not pixel and 10 or 2
					
								boyfriendNotes[id][c]:animate("end", false)

								if hasPixelNotes then
									boyfriendNotesP[id][c].offsetY = 2

									boyfriendNotesP[id][c]:animate("end", false)
								end
							end
						end
					else
						if noteType >= 4 then
							local id = noteType - 3
							local c = #boyfriendNotes[id] + 1
							local x = boyfriendArrows[id].x				
					
							table.insert(boyfriendNotes[id], sprite())
							boyfriendNotes[id][c].x = x
							boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
							boyfriendNotes[id][c].time = noteTime
							boyfriendNotes[id][c].ver = noteVer

							if hasPixelNotes then
								table.insert(boyfriendNotesP[id], spriteP())
								boyfriendNotesP[id][c].x = x
								boyfriendNotesP[id][c].y = -400 + noteTime * 0.6 * speed
								boyfriendNotesP[id][c].time = noteTime
								
								if settings.downscroll then
									boyfriendNotesP[id][c].sizeY = -1
								end

								boyfriendNotesP[id][c]:animate("on", false)
							end

							if settings.downscroll then
								boyfriendNotes[id][c].sizeY = -1
							end
					
							boyfriendNotes[id][c]:animate("on", false)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #boyfriendNotes[id] + 1
					
									table.insert(boyfriendNotes[id], sprite())
									boyfriendNotes[id][c].x = x
									boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									boyfriendNotes[id][c].ver = noteVer
					
									boyfriendNotes[id][c]:animate("hold", false)

									if hasPixelNotes then
										table.insert(boyfriendNotesP[id], spriteP())
										boyfriendNotesP[id][c].x = x
										boyfriendNotesP[id][c].y = -400 + (noteTime + k) * 0.6 * speed

										boyfriendNotesP[id][c]:animate("hold", false)
									end
								end
					
								c = #boyfriendNotes[id]
					
								boyfriendNotes[id][c].offsetY = not pixel and 10 or 2
					
								boyfriendNotes[id][c]:animate("end", false)

								if hasPixelNotes then
									boyfriendNotesP[id][c].offsetY = 2

									boyfriendNotesP[id][c]:animate("end", false)
								end
							end
						elseif noteType < 4 and noteType >= 0 then
							local id = noteType + 1
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x

							table.insert(enemyNotes[id], sprite())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
							enemyNotes[id][c].ver = noteVer
							enemyNotes[id][c].time = noteTime

							if settings.downscroll then
								enemyNotes[id][c].sizeY = -1
							end
					
							enemyNotes[id][c]:animate("on", false)

							if hasPixelNotes then
								table.insert(enemyNotesP[id], spriteP())
								enemyNotesP[id][c].x = x
								enemyNotesP[id][c].y = -400 + noteTime * 0.6 * speed

								if settings.downscroll then
									enemyNotesP[id][c].sizeY = -1
								end

								enemyNotesP[id][c]:animate("on", false)
							end
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #enemyNotes[id] + 1
					
									table.insert(enemyNotes[id], sprite())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									enemyNotes[id][c].ver = noteVer
									if k > sectionNotes[j][3] - 71 / speed then
										enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
										enemyNotes[id][c]:animate("end", false)
									else
										enemyNotes[id][c]:animate("hold", false)
									end

									if hasPixelNotes then
										table.insert(enemyNotesP[id], spriteP())
										enemyNotesP[id][c].x = x
										enemyNotesP[id][c].y = -400 + (noteTime + k) * 0.6 * speed

										if k > sectionNotes[j][3] - 71 / speed then
											enemyNotesP[id][c].offsetY = 2

											enemyNotesP[id][c]:animate("end", false)
										else
											enemyNotesP[id][c]:animate("hold", false)
										end
									end
								end
					
								c = #enemyNotes[id]
					
								enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
								enemyNotes[id][c]:animate("end", false)

								if hasPixelNotes then
									enemyNotesP[id][c].offsetY = 2

									enemyNotesP[id][c]:animate("end", false)
								end
							end
						end
					end
				elseif noteVer == "2" then
					if mustHitSection then
						if noteType >= 4 then
							local id = noteType - 3
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x

							table.insert(enemyNotes[id], spriteD())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
							enemyNotes[id][c].time = noteTime

							if settings.downscroll then
								enemyNotes[id][c].sizeY = -1
							end
					
							enemyNotes[id][c]:animate("on", true)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #enemyNotes[id] + 1
					
									table.insert(enemyNotes[id], spriteD())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									enemyNotes[id][c].type = "death"
					
									enemyNotes[id][c]:animate("hold", false)
								end
					
								c = #enemyNotes[id]
					
								enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
								enemyNotes[id][c]:animate("end", false)
							end
							enemyNotes[id][c].type = "death"
							print("death")
						elseif noteType < 4 and noteType >= 0 then
							local id = noteType + 1
							local c = #boyfriendNotes[id] + 1
							local x = boyfriendArrows[id].x

							table.insert(boyfriendNotes[id], spriteD())
							boyfriendNotes[id][c].x = x
							boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
							boyfriendNotes[id][c].time = noteTime
							
							if settings.downscroll then
								boyfriendNotes[id][c].sizeY = -1
							end
					
							boyfriendNotes[id][c]:animate("on", true)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #boyfriendNotes[id] + 1
					
									table.insert(boyfriendNotes[id], spriteD())
									boyfriendNotes[id][c].x = x
									boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									boyfriendNotes[id][c].type = "death"
					
									boyfriendNotes[id][c]:animate("hold", false)
								end
					
								c = #boyfriendNotes[id]
					
								boyfriendNotes[id][c].offsetY = not pixel and 10 or 2
					
								boyfriendNotes[id][c]:animate("end", false)
							end
							boyfriendNotes[id][c].type = "death"
						end
					else
						if noteType >= 4 then
							local id = noteType - 3
							local c = #boyfriendNotes[id] + 1
							local x = boyfriendArrows[id].x				
					
							table.insert(boyfriendNotes[id], spriteD())
							boyfriendNotes[id][c].x = x
							boyfriendNotes[id][c].y = -400 + noteTime * 0.6 * speed
							boyfriendNotes[id][c].time = noteTime

							if settings.downscroll then
								boyfriendNotes[id][c].sizeY = -1
							end
					
							boyfriendNotes[id][c]:animate("on", true)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #boyfriendNotes[id] + 1
					
									table.insert(boyfriendNotes[id], spriteD())
									boyfriendNotes[id][c].x = x
									boyfriendNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									boyfriendNotes[id][c].type = "death"
					
									boyfriendNotes[id][c]:animate("hold", false)
								end
					
								c = #boyfriendNotes[id]
					
								boyfriendNotes[id][c].offsetY = not pixel and 10 or 2
					
								boyfriendNotes[id][c]:animate("end", false)
								boyfriendNotes[id][c].type = "death"
							end
							boyfriendNotes[id][c].type = "death"
						elseif noteType < 4 and noteType >= 0 then
							local id = noteType + 1
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x

							table.insert(enemyNotes[id], spriteD())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
							enemyNotes[id][c].time = noteTime
							enemyNotes[id][c].type = "death"

							if settings.downscroll then
								enemyNotes[id][c].sizeY = -1
							end
					
							enemyNotes[id][c]:animate("on", true)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #enemyNotes[id] + 1
					
									table.insert(enemyNotes[id], spriteD())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									if k > sectionNotes[j][3] - 71 / speed then
										enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
										enemyNotes[id][c]:animate("end", false)
									else
										enemyNotes[id][c]:animate("hold", false)
									end
									enemyNotes[id][c].type = "death"
								end
					
								c = #enemyNotes[id]
					
								enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
								enemyNotes[id][c]:animate("end", false)
							end
							enemyNotes[id][c].type = "death"
							print("death", enemyNotes[id][c].type)
						end
					end
				end
			end
		end

		for i = 1, 4 do
			table.sort(enemyNotes[i], function(a, b) return a.y < b.y end)
			table.sort(boyfriendNotes[i], function(a, b) return a.y < b.y end)

			if hasPixelNotes then
				table.sort(enemyNotesP[i], function(a, b) return a.y < b.y end)
				table.sort(boyfriendNotesP[i], function(a, b) return a.y < b.y end)
			end

			for j = 1, #enemyNotes[i] do
				enemyNotes[i][j].type = enemyNotes[i][j].type or "normal"
			end
			for j = 1, #boyfriendNotes[i] do
				boyfriendNotes[i][j].type = boyfriendNotes[i][j].type or "normal"
			end
		end
	end,

	generateNotes2 = function(self, chart)
		local eventBpm

		chart = json.decode(love.filesystem.read(chart))
		chart = chart["song"]
		curSong = chart["song"]

		for i = 1, #chart["notes"] do
			for j = 1, #chart["notes"][i]["sectionNotes"] do
				local sprite
				local sectionNotes = chart["notes"][i]["sectionNotes"]

				local mustHitSection = chart["notes"][i]["mustHitSection"]
				local altAnim = chart["notes"][i]["altAnim"] or false
				local noteType = sectionNotes[j][2]
				local noteTime = sectionNotes[j][1]
				local noteVer = sectionNotes[j][4] or "0"

				noteVer = tostring(noteVer) or "0"

				if noteType == 0 or noteType == 4 then
					sprite = sprites.leftArrow
				elseif noteType == 1 or noteType == 5 then
					sprite = sprites.downArrow
				elseif noteType == 2 or noteType == 6 then
					sprite = sprites.upArrow
				elseif noteType == 3 or noteType == 7 then
					sprite = sprites.rightArrow
				end

				if noteVer == "0" then
					if mustHitSection then
						if noteType >= 4 then
							local id = noteType - 3
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x

							table.insert(enemyNotes[id], sprite())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
							enemyNotes[id][c].ver = noteVer

							if settings.downscroll then
								enemyNotes[id][c].sizeY = -1
							end
					
							enemyNotes[id][c]:animate("on", false)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #enemyNotes[id] + 1
					
									table.insert(enemyNotes[id], sprite())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									enemyNotes[id][c].ver = noteVer
					
									enemyNotes[id][c]:animate("hold", false)
								end
					
								c = #enemyNotes[id]
					
								enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
								enemyNotes[id][c]:animate("end", false)
							end
						end
					else
						if noteType < 4 and noteType >= 0 then
							local id = noteType + 1
							local c = #enemyNotes[id] + 1
							local x = enemyArrows[id].x

							table.insert(enemyNotes[id], sprite())
							enemyNotes[id][c].x = x
							enemyNotes[id][c].y = -400 + noteTime * 0.6 * speed
							enemyNotes[id][c].ver = noteVer

							if settings.downscroll then
								enemyNotes[id][c].sizeY = -1
							end
					
							enemyNotes[id][c]:animate("on", false)
					
							if sectionNotes[j][3] > 0 then
								local c
					
								for k = 71 / speed, sectionNotes[j][3], 71 / speed do
									local c = #enemyNotes[id] + 1
					
									table.insert(enemyNotes[id], sprite())
									enemyNotes[id][c].x = x
									enemyNotes[id][c].y = -400 + (noteTime + k) * 0.6 * speed
									enemyNotes[id][c].ver = noteVer
									if k > sectionNotes[j][3] - 71 / speed then
										enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
										enemyNotes[id][c]:animate("end", false)
									else
										enemyNotes[id][c]:animate("hold", false)
									end
								end
					
								c = #enemyNotes[id]
					
								enemyNotes[id][c].offsetY = not pixel and 10 or 2
					
								enemyNotes[id][c]:animate("end", false)
							end
						end
					end
				end
			end
		end

		for i = 1, 4 do
			table.sort(enemyNotes[i], function(a, b) return a.y < b.y end)
		end

		-- Workarounds for bad charts that have multiple notes around the same place
		for i = 1, 4 do
			local offset = 0

			for j = 2, #enemyNotes[i] do
				local index = j - offset

				if enemyNotes[i][index]:getAnimName() == "on" and enemyNotes[i][index - 1]:getAnimName() == "on" and ((enemyNotes[i][index].y - enemyNotes[i][index - 1].y <= 10)) then
					table.remove(enemyNotes[i], index)

					offset = offset + 1
				end
			end
		end
	end,

	-- Gross countdown script
	setupCountdown = function(self)
		if music then
			music:stop()
		end
		lastReportedPlaytime = 0
		musicTime = (240 / bpm) * -1000

		musicThres = 0
		musicPos = 0

		countingDown = true
		countdownFade[1] = 0
		audio.playSound(sounds.countdown.three)
		Timer.after(
			(60 / bpm),
			function()
				countdown:animate("ready")
				countdownFade[1] = 1
				audio.playSound(sounds.countdown.two)
				Timer.tween(
					(60 / bpm),
					countdownFade,
					{0},
					"linear",
					function()
						countdown:animate("set")
						countdownFade[1] = 1
						audio.playSound(sounds.countdown.one)
						Timer.tween(
							(60 / bpm),
							countdownFade,
							{0},
							"linear",
							function()
								countdown:animate("go")
								countdownFade[1] = 1
								audio.playSound(sounds.countdown.go)
								Timer.tween(
									(60 / bpm),
									countdownFade,
									{0},
									"linear",
									function()
										countingDown = false

										previousFrameTime = love.timer.getTime() * 1000
										musicTime = 0
										beatHandler.reset(0)

										if inst then inst:play() end
										voices:play()

										--voices:seek(98)
										--inst:seek(98)
									end
								)
							end
						)
					end
				)
			end
		)
	end,

	update = function(self, dt)
		if input:pressed("pause") and not countingDown and not inCutscene and not doingDialogue and not paused then
			if not graphics.isFading() then 
				paused = true
				pauseTime = musicTime
				if paused then 
					if inst then inst:pause() end
					voices:pause()
					if voices_Monika and voices_Monika:isPlaying() then voices_Monika:pause() end
					if voices_Natsuki and voices_Natsuki:isPlaying() then voices_Natsuki:pause() end
					if voices_Sayori and voices_Sayori:isPlaying() then voices_Sayori:pause() end
					if voices_Yuri and voices_Yuri:isPlaying() then voices_Yuri:pause() end
					love.audio.play(sounds.breakfast)
					sounds.breakfast:setLooping(true) 
				end
			end
			return
		end
		if paused then 
			previousFrameTime = love.timer.getTime() * 1000
			musicTime = pauseTime
			if input:pressed("gameDown") then
				if pauseMenuSelection == 3 then
					pauseMenuSelection = 1
				else
					pauseMenuSelection = pauseMenuSelection + 1
				end
			end

			if input:pressed("gameUp") and paused then
				if pauseMenuSelection == 1 then
					pauseMenuSelection = 3
				else
					pauseMenuSelection = pauseMenuSelection - 1
				end
			end
			if input:pressed("confirm") then
				love.audio.stop(sounds.breakfast) -- since theres only 3 options, we can make the sound stop without an else statement
				if pauseMenuSelection == 1 then
					if inst then inst:play() end
					voices:play()
					if voices_Monika and choosen == "monika" then voices_Monika:play() end
					if voices_Natsuki and choosen == "natsuki" then voices_Natsuki:play() end
					if voices_Sayori and choosen == "sayori" then voices_Sayori:play() end
					if voices_Yuri and choosen == "yuri" then voices_Yuri:play() end
					paused = false 
				elseif pauseMenuSelection == 2 then
					pauseRestart = true
					Gamestate.push(gameOver)
				elseif pauseMenuSelection == 3 then
					paused = false
					if inst then inst:stop() end
					voices:stop()
					if inst then inst:stop() end
					quitPressed = true
					leftSong = true
				end
			end
			return
		end
		if inCutscene then return end
		beatHandler.update(dt)

		oldMusicThres = musicThres
		if countingDown or love.system.getOS() == "Web" then -- Source:tell() can't be trusted on love.js!
			musicTime = musicTime + 1000 * dt
		else
			if not graphics.isFading() then
				local time = love.timer.getTime()
				local seconds = voices:tell("seconds")

				musicTime = musicTime + (time * 1000) - (previousFrameTime or 0)
				previousFrameTime = time * 1000

				if lastReportedPlaytime ~= seconds * 1000 then
					lastReportedPlaytime = seconds * 1000
					musicTime = (musicTime + lastReportedPlaytime) / 2
				end
			end
		end
		absMusicTime = math.abs(musicTime)
		musicThres = math.floor(absMusicTime / 100) -- Since "musicTime" isn't precise, this is needed

		if input:pressed("debugZoomIn") then
			if inst:tell() + 15 < inst:getDuration() then
				inst:seek(inst:tell() + 15)
				voices:seek(voices:tell() + 15)
			end
			
		elseif input:pressed("debugZoomOut") then
			if inst:tell() - 15 > 0 then
				inst:seek(inst:tell() - 15)
				voices:seek(voices:tell() - 15)
			end
		end

		for i = 1, #events do
			if events[i].eventTime <= absMusicTime then
				local oldBpm = bpm

				if camera.mustHit then
					if events[i].mustHitSection then
						mustHitSection = true
						camera:moveToPoint(1.25, "boyfriend")
					else
						mustHitSection = false
						camera:moveToPoint(1.25, "enemy")
					end
				end

				if events[i].altAnim then
					useAltAnims = true
				else
					useAltAnims = false
				end

				table.remove(events, i)

				break
			end
		end

		if (beatHandler.onBeat() and beatHandler.getBeat() % camera.camBopInterval == 0 and camera.zooming and camera.zoom < 1.35) then 
			camera.zoom = camera.zoom + 0.015 * camera.camBopIntensity
			uiScale.zoom = uiScale.zoom + 0.03 * camera.camBopIntensity
		end

		if camera.zooming then 
			camera.zoom = util.lerp(camera.defaultZoom, camera.zoom, util.clamp(1 - (dt * 3.125), 0, 1))
			uiScale.zoom = util.lerp(1, uiScale.zoom, util.clamp(1 - (dt * 3.125), 0, 1))
		end

		girlfriend:update(dt)
		if girlfriend2 then girlfriend2:update(dt) end
		enemy:update(dt)
		if enemy2 then enemy2:update(dt) end
		if enemy3 then enemy3:update(dt) end
		boyfriend:update(dt)
		if boyfriend2 then boyfriend2:update(dt) end

		boyfriend:beat(beatHandler.getBeat())
		if boyfriend2 then boyfriend2:beat(beatHandler.getBeat()) end
		enemy:beat(beatHandler.getBeat())
		if enemy2 then enemy2:beat(beatHandler.getBeat()) end
		if enemy3 then enemy3:beat(beatHandler.getBeat()) end
		girlfriend:beat(beatHandler.getBeat())
		if girlfriend2 then girlfriend2:beat(beatHandler.getBeat()) end
	end,

	updateUI = function(self, dt)
		if inCutscene then 
			self:d_update(dt)
			return
		end
		if paused then return end
		musicPos = musicTime * 0.6 * speed

		for i = 1, 4 do
			local enemyArrow = enemyArrows[i]
			local boyfriendArrow = boyfriendArrows[i]
			local enemyNote = enemyNotes[i]
			local boyfriendNote = boyfriendNotes[i]
			local curAnim = animList[i]
			local curInput = inputList[i]
			local boyfriendSplash = boyfriendSplashes[i]
			local noteNum = i
			local boyfriendNoteP
			local enemyNoteP
			local enemyArrowP
			local boyfriendArrowP
			local boyfriendSplashP

			enemyArrow:update(dt)
			boyfriendArrow:update(dt)
			boyfriendSplash:update(dt)
			if hasPixelNotes then
				boyfriendNoteP = boyfriendNotesP[i]
				enemyNoteP = enemyNotesP[i]
				enemyArrowP = enemyArrowsP[i]
				boyfriendArrowP = boyfriendArrowsP[i]
				boyfriendSplashP = boyfriendSplashesP[i]

				enemyArrowP:update(dt)
				boyfriendArrowP:update(dt)
				boyfriendSplashP:update(dt)

				if mirrorMode then
					boyfriendSplashP.x = enemyArrowP.x
				else
					boyfriendSplashP.x = boyfriendArrowP.x
				end
			end

			if mirrorMode then 
				boyfriendSplash.x = enemyArrow.x
			else
				boyfriendSplash.x = boyfriendArrow.x
			end

			if not enemyArrow:isAnimated() and not mirrorMode then
				enemyArrow:animate("off", false)
			end
			if settings.botPlay or mirrorMode then
				if not boyfriendArrow:isAnimated() then
					boyfriendArrow:animate("off", false)
				end
			end

			if hasPixelNotes then
				if not enemyArrowP:isAnimated() and not mirrorMode then
					enemyArrowP:animate("off", false)
				end
				if settings.botPlay or mirrorMode then
					if not boyfriendArrowP:isAnimated() then
						boyfriendArrowP:animate("off", false)
					end
				end
			end

			for j = 1, #boyfriendNote do
				boyfriendNote[j].x = boyfriendArrow.x
			end
			for j = 1, #enemyNote do
				enemyNote[j].x = enemyArrow.x
			end

			if #enemyNote > 0 then
				if ((enemyNote[1].y - musicPos <= -410) and not mirrorMode) or (mirrorMode and settings.botPlay) then
					voices:setVolume(1)

					enemyArrow:animate("confirm", false)
					if hasPixelNotes then
						enemyArrowP:animate("confirm", false)
					end

					local char = enemy

					if enemyNote[1].ver == "3" then
						if numOfChar >= 3 then
							char = enemy2
						else
							char = girlfriend
						end
					elseif enemyNote[1].ver == "4" or enemyNote[1].ver == "GF Sing" then
						if numOfChar >= 4 then
							char = enemy3
						else
							char = girlfriend
						end
					elseif enemyNote[1].ver == "6" then
						char = girlfriend
					end

					if enemyNote[1].type ~= "death" then
						if enemyNote[1]:getAnimName() == "hold" or enemyNote[1]:getAnimName() == "end" then
							if useAltAnims then
								if enemyNote[1].ver == "5" then
									if enemy2.holdTimer > enemy2.maxHoldTimer then
										enemy2:animate(curAnim .. " alt", false)
									end
									if enemy3.holdTimer > enemy3.maxHoldTimer then
										enemy3:animate(curAnim .. " alt", false)
									end
									if enemy.holdTimer > enemy.maxHoldTimer then
										enemy:animate(curAnim .. " alt", false)
									end
								else
									if char.holdTimer > char.maxHoldTimer then
										char:animate(curAnim .. " alt", false)
									end
									if FORCEP2NOMATTERWHAT then
										if enemy2.holdTimer > enemy2.maxHoldTimer then
											enemy2:animate(curAnim .. " alt", false)
										end
									end
								end
							else
								if enemyNote[1].ver == "5" then
									if enemy2.holdTimer > enemy2.maxHoldTimer then
										enemy2:animate(curAnim, false)
									end
									if enemy3.holdTimer > enemy3.maxHoldTimer then
										enemy3:animate(curAnim, false)
									end
									if enemy.holdTimer > enemy.maxHoldTimer then
										enemy:animate(curAnim, false)
									end								else
									if char.holdTimer > char.maxHoldTimer then
										char:animate(curAnim, false)
									end
									if FORCEP2NOMATTERWHAT then
										if enemy2.holdTimer > enemy2.maxHoldTimer then
											enemy2:animate(curAnim, false)
										end
									end
								end
							end
						elseif enemyNote[1]:getAnimName() ~= "hold" or enemyNote[1]:getAnimName() ~= "end" then
							--print(enemyNote[1].type, enemyNote[1].type == "death")
							if useAltAnims then
								if enemyNote[1].ver == "5" then
									enemy2:animate(curAnim .. " alt", false)
									enemy3:animate(curAnim .. " alt", false)
									enemy:animate(curAnim .. " alt", false)
								else
									char:animate(curAnim .. " alt", false)
									if FORCEP2NOMATTERWHAT then
										enemy2:animate(curAnim .. " alt", false)
									end
								end
							else
								if enemyNote[1].ver == "5" then
									enemy2:animate(curAnim, false)
									enemy3:animate(curAnim, false)
									enemy:animate(curAnim, false)
								else
									char:animate(curAnim, false)
									if FORCEP2NOMATTERWHAT then
										enemy2:animate(curAnim, false)
									end
								end
							end
						end
					end

					char.lastHit = musicTime

					table.remove(enemyNote, 1)
					if hasPixelNotes then
						table.remove(enemyNoteP, 1)
					end
				end

				if input:pressed(curInput) and mirrorMode then
					enemyArrow:animate("press", false)
					if hasPixelNotes then
						enemyArrowP:animate("press", false)
					end
					local char = enemy
						if mirrorMode and not settings.botPlay then 
							-- if settings.botPlay is true, break our the if statement
						if settings.botPlay then break end
						success = false
		
						if settings.ghostTapping then
							success = true
						end
						
						for j = 1, #enemyNote do
							if enemyNote[j] and enemyNote[j]:getAnimName() == "on" then
								if (enemyNote[j].time - musicTime <= 150) then
									local notePos
									local ratingAnim
	
									notMissed[noteNum] = true
									success = true
	
									notePos = math.abs(enemyNote[j].time - musicTime)
	
									voices:setVolume(1)
	
									boyfriend.lastHit = musicTime
	
									if notePos <= 55 then -- "Sick"
										score = score + 350
										ratingAnim = "sick"
	
										boyfriendSplash:animate(tostring(i) .. love.math.random(1,2), false)
										if hasPixelNotes then
											boyfriendSplashP:animate(tostring(i) .. love.math.random(1,2), false)
										end
									elseif notePos <= 90 then -- "Good"
										score = score + 200
										ratingAnim = "good"
									elseif notePos <= 120 then -- "Bad"
										score = score + 100
										ratingAnim = "bad"
									else -- "Shit"
										if settings.ghostTapping then
											success = false
										end
										ratingAnim = "shit"
									end
									combo = combo + 1
									noteCounter = noteCounter + 1
	
									rating:animate(ratingAnim, false)
									if ratingP then
										ratingP:animate(ratingAnim, false)
									end
									numbers[1]:animate(tostring(math.floor(combo / 100 % 10)), false)
									numbers[2]:animate(tostring(math.floor(combo / 10 % 10)), false)
									numbers[3]:animate(tostring(math.floor(combo % 10)), false)
	
									if numbersP[1] then
										numbersP[1]:animate(tostring(math.floor(combo / 100 % 10)), false)
										numbersP[2]:animate(tostring(math.floor(combo / 10 % 10)), false)
										numbersP[3]:animate(tostring(math.floor(combo % 10)), false)
									end
									for i = 1, 10 do
										if ratingTimers[i] then Timer.cancel(ratingTimers[i]) end
									end
		
									rating.y = 300 - 50 + (settings.downscroll and 0 or -490)
									if ratingP then
										ratingP.y = 300 - 50 + (settings.downscroll and 0 or -490)
									end
									for i = 1, 3 do
										numbers[i].y = 300 + 50 + (settings.downscroll and 0 or -490)
									end
									if numbersP[1] then
										for i = 1, 3 do
											numbersP[i].y = 300 + 50 + (settings.downscroll and 0 or -490)
										end
									end
	
		
									ratingVisibility[1] = 1
									ratingTimers[1] = Timer.tween(2, ratingVisibility, {0}, "linear")
									ratingTimers[2] = Timer.tween(2, rating, {y = 300 + (settings.downscroll and 0 or -490) - 100}, "out-elastic")
		
									ratingTimers[3] = Timer.tween(2, numbers[1], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
									ratingTimers[4] = Timer.tween(2, numbers[2], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
									ratingTimers[5] = Timer.tween(2, numbers[3], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
		
									if numbersP[1] then
										ratingVisibilityP[1] = 1
		
										ratingTimers[6] = Timer.tween(2, ratingVisibilityP, {0}, "linear")
										ratingTimers[7] = Timer.tween(2, ratingP, {y = 300 + (settings.downscroll and 0 or -490) - 100}, "out-elastic")
		
										ratingTimers[8] = Timer.tween(2, numbersP[1], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
										ratingTimers[9] = Timer.tween(2, numbersP[2], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
										ratingTimers[10] = Timer.tween(2, numbersP[3], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
									end
	
									if not settings.ghostTapping or success then
										enemyArrow:animate("confirm", false)
										if hasPixelNotes then
											enemyArrowP:animate("confirm", false)
										end

										if enemyNote[j].ver == "3" then
											if numOfChar >= 3 then
												char = enemy2
											else
												char = girlfriend
											end
										elseif enemyNote[1].ver == "4" or enemyNote[1].ver == "GF Sing" then
											if numOfChar >= 4 then
												char = enemy3
											else
												char = girlfriend
											end
										elseif enemyNote[1].ver == "6" then
											char = girlfriend
										end

										if FORCEP2NOMATTERWHAT then
											enemy2:animate(curAnim, false)
										end
	
										if enemyNote[1].type ~= "death" then
											char:animate(curAnim, false)
										end
	
										if enemyNote[j]:getAnimName() ~= "hold" and enemyNote[j]:getAnimName() ~= "end" then
											health = health - 0.095
										else
											health = health - 0.0125
										end
	
										success = true
									end
	
									table.remove(enemyNote, j)
									if hasPixelNotes then
										table.remove(enemyNoteP, 1)
									end
	
									self:calculateRating()
								else
									break
								end
							end
						end
					end

					if not success then
						audio.playSound(sounds.miss[love.math.random(3)])
	
						notMissed[noteNum] = false
	
						if combo >= 5 then girlfriend:animate("sad", false) end
	
						enemy:animate("miss " .. curAnim, false)
	
						score = score - 10
						combo = 0
						health = health - 0.135
						misses = misses + 1
					end
				end
			end

			if #enemyNote > 0 and mirrorMode then
				if (enemyNote[1].y - musicPos < -600) then
					if inst then voices:setVolume(0) end

					notMissed[noteNum] = false

					if enemyNote[1]:getAnimName() ~= "hold" and enemyNote[1]:getAnimName() ~= "end" then 
						health = health + 0.095
						misses = misses - 1
					else
						health = health + 0.0125
					end

					table.remove(enemyNote, 1)
					if hasPixelNotes then
						table.remove(enemyNoteP, 1)
					end

					combo = 0
				end
			end

			if #boyfriendNote > 0 and not mirrorMode then
				if (boyfriendNote[1].y - musicPos < -600) then
					if boyfriendNote[1].type ~= "death" then
						if inst then voices:setVolume(0) end

						notMissed[noteNum] = false

						if boyfriendNote[1]:getAnimName() ~= "hold" and boyfriendNote[1]:getAnimName() ~= "end" then
							health = health - 0.095
							misses = misses + 1
						elseif boyfriendNote[1]:getAnimName() == "hold" and boyfriendNote[1]:getAnimName() == "end" then
							health = health - 0.0125
						end

						if combo >= 5 then girlfriend:animate("sad", false) end

						combo = 0
					end

					table.remove(boyfriendNote, 1)
					if hasPixelNotes then
						table.remove(boyfriendNoteP, 1)
					end
				end
			end
	
			if settings.botPlay or mirrorMode then
				if #boyfriendNote > 0 then
					if (boyfriendNote[1].y - musicPos <= -400) then
						voices:setVolume(1)

						boyfriendArrow:animate("confirm", false)
						if hasPixelNotes then
							boyfriendArrowP:animate("confirm", false)
						end

						if boyfriendNote[1]:getAnimName() == "hold" or boyfriendNote[1]:getAnimName() == "end" then
							if boyfriend.holdTimer > boyfriend.maxHoldTimer then
								boyfriend:animate(curAnim, false)
							end
							if boyfriend2 then if boyfriend2:getAnimName() == "idle" then boyfriend2:animate(curAnim, false) end end
						else
							boyfriend:animate(curAnim, false)
							if boyfriend2 then boyfriend2:animate(curAnim, false) end
						end

						boyfriend.lastHit = musicTime

						if not mirrorMode then
							if boyfriendNote[1]:getAnimName() ~= "hold" and boyfriendNote[1]:getAnimName() ~= "end" then 
								noteCounter = noteCounter + 1
								combo = combo + 1

								numbers[1]:animate(tostring(math.floor(combo / 100 % 10)), false)
								numbers[2]:animate(tostring(math.floor(combo / 10 % 10)), false)
								numbers[3]:animate(tostring(math.floor(combo % 10)), false)

								if numbersP[1] then
									numbersP[1]:animate(tostring(math.floor(combo / 100 % 10)), false)
									numbersP[2]:animate(tostring(math.floor(combo / 10 % 10)), false)
									numbersP[3]:animate(tostring(math.floor(combo % 10)), false)
								end

								for i = 1, 10 do
									if ratingTimers[i] then Timer.cancel(ratingTimers[i]) end
								end

								rating.y = 300 - 50 + (settings.downscroll and 0 or -490)
								if ratingP then
									ratingP.y = 300 - 50 + (settings.downscroll and 0 or -490)
								end
								for i = 1, 3 do
									numbers[i].y = 300 + 50 + (settings.downscroll and 0 or -490)
								end
								if numbersP[1] then
									for i = 1, 3 do
										numbersP[i].y = 300 + 50 + (settings.downscroll and 0 or -490)
									end
								end

								ratingVisibility[1] = 1
								ratingTimers[1] = Timer.tween(2, ratingVisibility, {0}, "linear")
								ratingTimers[2] = Timer.tween(2, rating, {y = 300 + (settings.downscroll and 0 or -490) - 100}, "out-elastic")

								ratingTimers[3] = Timer.tween(2, numbers[1], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
								ratingTimers[4] = Timer.tween(2, numbers[2], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
								ratingTimers[5] = Timer.tween(2, numbers[3], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")

								if ratingVisibilityP then
									ratingVisibilityP[1] = 1

									ratingTimers[6] = Timer.tween(2, ratingVisibilityP, {0}, "linear")
									ratingTimers[7] = Timer.tween(2, ratingP, {y = 300 + (settings.downscroll and 0 or -490) - 100}, "out-elastic")

									if numbersP[1] then
										ratingTimers[8] = Timer.tween(2, numbersP[1], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
										ratingTimers[9] = Timer.tween(2, numbersP[2], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
										ratingTimers[10] = Timer.tween(2, numbersP[3], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
									end
								end
								health = health + 0.095
								score = score + 350

								boyfriendSplash:animate(tostring(i) .. love.math.random(1,2), false)
								if hasPixelNotes then
									boyfriendSplashP:animate(tostring(i) .. love.math.random(1,2), false)
								end

								self:calculateRating()
							else
								health = health + 0.0125
							end
						end

						table.remove(boyfriendNote, 1)
						if hasPixelNotes then
							table.remove(boyfriendNoteP, 1)
						end
					end
				end
			end

			if input:pressed(curInput) and not mirrorMode then
				-- if settings.botPlay is true, break our the if statement
				if settings.botPlay then break end
				local success = false

				if settings.ghostTapping then
					success = true
				end

				if not mirrorMode then
					boyfriendArrow:animate("press", false)
					if hasPixelNotes then
						boyfriendArrowP:animate("press", false)
					end
				end

				if #boyfriendNote > 0 then
					for j = 1, #boyfriendNote do
						if boyfriendNote[j] and boyfriendNote[j]:getAnimName() == "on" and boyfriendNote[j].type == "normal" then
							if (boyfriendNote[j].time - musicTime <= 150) then
								local notePos
								local ratingAnim

								notMissed[noteNum] = true

								notePos = math.abs(boyfriendNote[j].time - musicTime)

								voices:setVolume(1)

								boyfriend.lastHit = musicTime

								if notePos <= 55 then -- "Sick"
									score = score + 350
									ratingAnim = "sick"

									boyfriendSplash:animate(tostring(i) .. love.math.random(1,2), false)
									if hasPixelNotes then
										boyfriendSplashP:animate(tostring(i) .. love.math.random(1,2), false)
									end
								elseif notePos <= 90 then -- "Good"
									score = score + 200
									ratingAnim = "good"
								elseif notePos <= 120 then -- "Bad"
									score = score + 100
									ratingAnim = "bad"
								else -- "Shit"
									if settings.ghostTapping then
										success = false
									end
									ratingAnim = "shit"
								end
								combo = combo + 1
								noteCounter = noteCounter + 1

								rating:animate(ratingAnim, false)
								if ratingP then
									ratingP:animate(ratingAnim, false)
								end
								numbers[1]:animate(tostring(math.floor(combo / 100 % 10)), false)
								numbers[2]:animate(tostring(math.floor(combo / 10 % 10)), false)
								numbers[3]:animate(tostring(math.floor(combo % 10)), false)

								if numbersP[1] then
									numbersP[1]:animate(tostring(math.floor(combo / 100 % 10)), false)
									numbersP[2]:animate(tostring(math.floor(combo / 10 % 10)), false)
									numbersP[3]:animate(tostring(math.floor(combo % 10)), false)
								end
								for i = 1, 10 do
									if ratingTimers[i] then Timer.cancel(ratingTimers[i]) end
								end
	
								rating.y = 300 - 50 + (settings.downscroll and 0 or -490)
								if ratingP then
									ratingP.y = 300 - 50 + (settings.downscroll and 0 or -490)
								end
								for i = 1, 3 do
									numbers[i].y = 300 + 50 + (settings.downscroll and 0 or -490)
								end
								if numbersP[1] then
									for i = 1, 3 do
										numbersP[i].y = 300 + 50 + (settings.downscroll and 0 or -490)
									end
								end

	
								ratingVisibility[1] = 1
								ratingTimers[1] = Timer.tween(2, ratingVisibility, {0}, "linear")
								ratingTimers[2] = Timer.tween(2, rating, {y = 300 + (settings.downscroll and 0 or -490) - 100}, "out-elastic")
	
								ratingTimers[3] = Timer.tween(2, numbers[1], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
								ratingTimers[4] = Timer.tween(2, numbers[2], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
								ratingTimers[5] = Timer.tween(2, numbers[3], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
	
								if numbersP[1] then
									ratingVisibilityP[1] = 1
	
									ratingTimers[6] = Timer.tween(2, ratingVisibilityP, {0}, "linear")
									ratingTimers[7] = Timer.tween(2, ratingP, {y = 300 + (settings.downscroll and 0 or -490) - 100}, "out-elastic")
	
									ratingTimers[8] = Timer.tween(2, numbersP[1], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
									ratingTimers[9] = Timer.tween(2, numbersP[2], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
									ratingTimers[10] = Timer.tween(2, numbersP[3], {y = 300 + (settings.downscroll and 0 or -490) + love.math.random(-10, 10)}, "out-elastic")
								end

								if not settings.ghostTapping or success then
									boyfriendArrow:animate("confirm", false)
									if hasPixelNotes then
										boyfriendArrowP:animate("confirm", false)
									end

									boyfriend:animate(curAnim, false)
									if boyfriend2 then boyfriend2:animate(curAnim, false) end

									if boyfriendNote[j]:getAnimName() ~= "hold" and boyfriendNote[j]:getAnimName() ~= "end" then
										health = health + 0.095
									else
										health = health + 0.0125
									end

									success = true
								end

								table.remove(boyfriendNote, j)
								if hasPixelNotes then
									table.remove(boyfriendNoteP, 1)
								end

								self:calculateRating()
							else
								break
							end
						elseif boyfriendNote[j] and boyfriendNote[j]:getAnimName() == "on" and boyfriendNote[j].type == "death" then
							if (boyfriendNote[j].time - musicTime <= 40) then
								local pos = math.abs(boyfriendNote[j].time - musicTime)
								if pos < 25 then
									health = 0
								end
							end
						end
					end
				end

				if not success then
					audio.playSound(sounds.miss[love.math.random(3)])

					notMissed[noteNum] = false

					if combo >= 5 then girlfriend:animate("sad", false) end

					boyfriend:animate("miss " .. curAnim, false)
					if boyfriend2 then boyfriend2:animate("miss " .. curAnim, false) end

					score = score - 10
					combo = 0
					health = health - 0.135
					misses = misses + 1
				end
			end

			if not mirrorMode then
				if #boyfriendNote > 0 and input:down(curInput) and ((boyfriendNote[1].y - musicPos <= -400)) and (boyfriendNote[1]:getAnimName() == "hold" or boyfriendNote[1]:getAnimName() == "end") then
					voices:setVolume(1)

					boyfriendArrow:animate("confirm", false)

					health = health + 0.0125

					if boyfriend.holdTimer > boyfriend.maxHoldTimer then
						boyfriend:animate(curAnim, false)
					end
					if boyfriend2 then if (not boyfriend2:isAnimated()) or boyfriend2:getAnimName() == "idle" then boyfriend2:animate(curAnim, false) end end

					table.remove(boyfriendNote, 1)
					if hasPixelNotes then
						table.remove(boyfriendNoteP, 1)
					end
				end

				if input:released(curInput) then
					boyfriendArrow:animate("off", false)
					if hasPixelNotes then
						boyfriendArrowP:animate("off", false)
					end
				end
			else
				if #enemyNote > 0 and input:down(curInput) and ((enemyNote[1].y - musicPos <= -400)) and (enemyNote[1]:getAnimName() == "hold" or enemyNote[1]:getAnimName() == "end") then
					voices:setVolume(1)
					local char = enemy

					enemyArrow:animate("confirm", false)

					health = health - 0.0125

					if enemyNote[1].ver == "3" then
						if numOfChar >= 3 then
							char = enemy2
						else
							char = girlfriend
						end
					elseif enemyNote[1].ver == "4" or enemyNote[1].ver == "GF Sing" then
						if numOfChar >= 4 then
							char = enemy3
						else
							char = girlfriend
						end
					elseif enemyNote[1].ver == "6" then
						char = girlfriend
					end

					if not useAltAnims then
						if char.holdTimer > char.maxHoldTimer then
							char:animate(curAnim, false)
						end
						if FORCEP2NOMATTERWHAT then
							if (not enemy2:isAnimated()) or enemy2:getAnimName() == "idle" then enemy2:animate(curAnim, false) end
						end
					else
						if char.holdTimer > char.maxHoldTimer then
							char:animate(curAnim .. " alt", false)
						end
						if FORCEP2NOMATTERWHAT then
							if (not enemy2:isAnimated()) or enemy2:getAnimName() == "idle" then enemy2:animate(curAnim .. " alt", false) end
						end
					end

					table.remove(enemyNote, 1)
					if hasPixelNotes then
						table.remove(enemyNoteP, 1)
					end
				end

				if input:released(curInput) then
					enemyArrow:animate("off", false)
					if hasPixelNotes then
						enemyArrowP:animate("off", false)
					end
				end
			end
		end

		if health > 2 then
			health = 2
		elseif health > 0.325 and health < 1.595 and (boyfriendIcon:getAnimName() == "boyfriend losing" or boyfriendIcon:getAnimName() == "boyfriend winning") then
			if changeIcons then
				if not pixel then 
					boyfriendIcon:animate("boyfriend", false)
				else
					boyfriendIcon:animate("boyfriend (pixel)", false)
				end
			end
		elseif health > 0.325 and health < 1.595 and (boyfriendIcon:getAnimName() == "protag losing" or boyfriendIcon:getAnimName() == "protag winning") then
			if changeIcons then
				boyfriendIcon:animate("protag", false)
			end
		elseif health <= 0 then -- Game over
			--if not settings.practiceMode then Gamestate.push(gameOver) end
			health = 0
		elseif health <= 0.325 and boyfriendIcon:getAnimName() == "boyfriend" then
			if changeIcons then
				if not pixel then 
					boyfriendIcon:animate("boyfriend losing", false)
				else
					boyfriendIcon:animate("boyfriend losing (pixel)", false)
				end
			end
		elseif health <= 0.325 and boyfriendIcon:getAnimName() == "protag" then
			if changeIcons then
				boyfriendIcon:animate("protag losing", false)
			end
		elseif health >= 1.595 and boyfriendIcon:getAnimName() == "boyfriend" then
			if changeIcons then
				if not pixel then 
					boyfriendIcon:animate("boyfriend winning", false)
				else
					boyfriendIcon:animate("boyfriend winning (pixel)", false)
				end
			end
		elseif health >= 1.595 and boyfriendIcon:getAnimName() == "protag" then
			if changeIcons then
				boyfriendIcon:animate("protag winning", false)
			end
		end

		enemyIcon.x = 425 - health * 500
		boyfriendIcon.x = 585 - health * 500

		if beatHandler.onBeat() then
			if enemyIconTimer then Timer.cancel(enemyIconTimer) end
			if boyfriendIconTimer then Timer.cancel(boyfriendIconTimer) end

			enemyIconTimer = Timer.tween((60 / bpm) / 16, enemyIcon, {sizeX = 1.75, sizeY = 1.75}, "out-quad", function() enemyIconTimer = Timer.tween((60 / bpm), enemyIcon, {sizeX = 1.5, sizeY = 1.5}, "out-quad") end)
			boyfriendIconTimer = Timer.tween((60 / bpm) / 16, boyfriendIcon, {sizeX = -1.75, sizeY = 1.75}, "out-quad", function() boyfriendIconTimer = Timer.tween((60 / bpm), boyfriendIcon, {sizeX = -1.5, sizeY = 1.5}, "out-quad") end)
		end
	end,

	drawRating = function(self)
		love.graphics.push()
			--love.graphics.origin()
			love.graphics.translate(0, -35)
			graphics.setColor(1, 1, 1, ratingVisibility[1])
			if pixel then
				love.graphics.translate(-16, 0)
				rating:udraw(5.25, 5.25)
				for i = 1, 3 do
					numbers[i]:udraw(5, 5)
				end
			else
				if hasPixelNotes and showPixelNotes and ((not mirrorMode and whoHasPixelNotes == "enemy") or (mirrorMode and whoHasPixelNotes == "boyfriend")) then
					rating:draw()
					for i = 1, 3 do
						numbers[i]:draw()
					end
				end
				if not showPixelNotes and ((not mirrorMode and whoHasPixelNotes == "boyfriend") or (mirrorMode and whoHasPixelNotes == "enemy")) then
					ratingP:udraw(5.25, 5.25)
					for i = 1, 3 do
						numbersP[i]:udraw(5.25, 5.25)
					end
				end
			end
			graphics.setColor(1, 1, 1)
		love.graphics.pop()
	end,

	blackBars = function(self, t)
		if t then
			-- tween in both bars
			Timer.tween(1.2, bars[1], {y = 0}, "out-sine")
			Timer.tween(1.2, bars[2], {y = 625}, "out-sine")
		else
			-- tween out both bars
			Timer.tween(1.2, bars[1], {y = -95}, "out-sine")
			Timer.tween(1.2, bars[2], {y = 815}, "out-sine")
		end
	end,

	drawUI = function(self)
		if self.blackscreen.visible then
			graphics.setColor(0, 0, 0, self.blackscreen.alpha)
			love.graphics.rectangle("fill", 0, 0, graphics.getWidth(), graphics.getHeight())
			graphics.setColor(1, 1, 1)
		end
		if inCutscene then
			self:d_draw()
			return
		end
		love.graphics.push()
				graphics.setColor(0,0,0,1)
				-- draw the bars, 50 height at bars[1].y and bars[2].y
				love.graphics.rectangle("fill", 0, bars[1].y, 1280, 95)
				love.graphics.rectangle("fill", 0, bars[2].y, 1280, 95)
				graphics.setColor(1,1,1)
			love.graphics.pop()
		if paused then 
			love.graphics.push()
				love.graphics.setFont(pauseFont)
				love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
				if paused then
					graphics.setColor(0, 0, 0, 0.8)
					love.graphics.rectangle("fill", -10000, -2000, 25000, 10000)
					graphics.setColor(1, 1, 1)
					pauseShadow:draw()
					pauseBG:draw()
					if pauseMenuSelection ~= 1 then
						uitextflarge("Resume", -305, -275, 600, "center", false)
					else
						uitextflarge("Resume", -305, -275, 600, "center", true)
					end
					if pauseMenuSelection ~= 2 then
						uitextflarge("Restart", -305, -75, 600, "center", false)
						--  -600, 400+downscrollOffset, 1200, "center"
					else
						uitextflarge("Restart", -305, -75, 600, "center", true)
					end
					if pauseMenuSelection ~= 3 then
						uitextflarge("Quit", -305, 125, 600, "center", false)
					else
						uitextflarge("Quit", -305, 125, 600, "center", true)
					end
				end
				love.graphics.setFont(font)
			love.graphics.pop()
			return 
		end
		self:drawHealthbar()
		love.graphics.push()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			if not settings.downscroll then
				love.graphics.scale(0.7, 0.7)
			else
				love.graphics.scale(0.7, -0.7)
			end
			love.graphics.scale(uiScale.zoom, uiScale.zoom)

			for i = 1, 4 do
					if (whoHasPixelNotes ~= "enemy") and whoHasPixelNotes ~= "both" then
						if enemyArrows[i]:getAnimName() == "off" then
							if not settings.middleScroll then
								graphics.setColor(0.6, 0.6, 0.6, (useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
							else
								graphics.setColor(0.6, 0.6, 0.6, (useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha) * 0.6)
							end
						end
						if not pixel then
							enemyArrows[i]:draw()
						else
							if not settings.downscroll then
								enemyArrows[i]:udraw(8, 8)
							else
								enemyArrows[i]:udraw(8, -8)
							end
						end
					end
					graphics.setColor(1, 1, 1, 1*boyfriendArrows[i].alpha)
						if whoHasPixelNotes ~= "boyfriend" and whoHasPixelNotes ~= "both" then
							if not pixel then 
								boyfriendArrows[i]:draw()
								if boyfriendSplashes[i]:isAnimated() then
									graphics.setColor(1,1,1,0.5*(useUIAlphaForNotes and uiAlpha[1] or boyfriendArrows[i].alpha))
									boyfriendSplashes[i]:draw()
								end
							else
								if not settings.downscroll then
									boyfriendArrows[i]:udraw(8, 8)
									if boyfriendSplashes[i]:isAnimated() then
										graphics.setColor(1,1,1,0.5*(useUIAlphaForNotes and uiAlpha[1] or boyfriendArrows[i].alpha))
										boyfriendSplashes[i]:udraw(8, 8)
									end
								else
									boyfriendArrows[i]:udraw(8, -8)
									if boyfriendSplashes[i]:isAnimated() then
										graphics.setColor(1,1,1,0.5*uiAlpha[1])
										boyfriendSplashes[i]:udraw(8, -8)
									end
								end
							end
						end

				graphics.setColor(1, 1, 1)

				if hasPixelNotes then
					if (whoHasPixelNotes ~= "boyfriend") and whoHasPixelNotes ~= "none" then
						if enemyArrowsP[i]:getAnimName() == "off" then
							if not settings.middleScroll then
								graphics.setColor(0.6, 0.6, 0.6,(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
							else
								graphics.setColor(0.6, 0.6, 0.6, 0.6*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
							end
						else
							graphics.setColor(1, 1, 1, uiAlpha[1])
						end

						if not settings.downscroll then
							enemyArrowsP[i]:udraw(8, 8)
						else
							enemyArrowsP[i]:udraw(8, -8)
						end
					end

					graphics.setColor(1,1,1)
					if (whoHasPixelNotes ~= "enemy") and whoHasPixelNotes ~= "none" then
						if not settings.downscroll then
							boyfriendArrowsP[i]:udraw(8, 8)
							if boyfriendSplashesP[i]:isAnimated() then
								graphics.setColor(1,1,1,0.5*uiAlpha[1])
								boyfriendSplashesP[i]:udraw(8, 8)
							end
						else
							boyfriendArrowsP[i]:udraw(8, -8)
							if boyfriendSplashesP[i]:isAnimated() then
								graphics.setColor(1,1,1,0.5*uiAlpha[1])
								boyfriendSplashesP[i]:udraw(8, -8)
							end
						end
					end

					graphics.setColor(1, 1, 1)
				end

				love.graphics.push()
					love.graphics.translate(0, -musicPos)

					love.graphics.push()
								if whoHasPixelNotes ~= "enemy" and whoHasPixelNotes ~= "both" then
									for j = #enemyNotes[i], 1, -1 do
										if enemyNotes[i][j].y - musicPos <= 560 then
											local animName = enemyNotes[i][j]:getAnimName()

											if animName == "hold" or animName == "end" then
												if settings.middleScroll then
													graphics.setColor(1, 1, 1, 0.3*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha)*enemyNotes[i][j].alpha)
												else
													graphics.setColor(1, 1, 1, 0.5*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha)*enemyNotes[i][j].alpha)
												end

											else
												if settings.middleScroll then
													graphics.setColor(1, 1, 1, 0.5*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha)*enemyNotes[i][j].alpha)
												else
													graphics.setColor(1, 1, 1, (useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha)*enemyNotes[i][j].alpha)
												end
											end

											if not pixel then
												enemyNotes[i][j]:draw()
											else
												if not settings.downscroll then
													enemyNotes[i][j]:udraw(8, 8)
												else
													if enemyNotes[i][j]:getAnimName() == "end" then
														enemyNotes[i][j]:udraw(8, 8)
													else
														enemyNotes[i][j]:udraw(8, -8)
													end
												end
											end
											graphics.setColor(1, 1, 1,uiAlpha[1])
										end
									end
								end

							if showPixelNotes then
								if whoHasPixelNotes ~= "boyfriend" and whoHasPixelNotes ~= "none" then
									for j = #enemyNotesP[i], 1, -1 do
										if enemyNotesP[i][j].y - musicPos <= 560 then
											local animName = enemyNotesP[i][j]:getAnimName()

											if animName == "hold" or animName == "end" then
												if settings.middleScroll then
													graphics.setColor(1, 1, 1, 0.3*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
												else
													graphics.setColor(1, 1, 1, 0.5*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
												end

											else
												if settings.middleScroll then
													graphics.setColor(1, 1, 1, 0.5*(useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
												else
													graphics.setColor(1, 1, 1, (useUIAlphaForNotes and uiAlpha[1] or enemyArrows[i].alpha))
												end
											end

											if not settings.downscroll then
												enemyNotesP[i][j]:udraw(8, 8)
											else
												if enemyNotesP[i][j]:getAnimName() == "end" then
													enemyNotesP[i][j]:udraw(8, 8)
												else
													enemyNotesP[i][j]:udraw(8, -8)
												end
											end
											graphics.setColor(1, 1, 1,uiAlpha[1])
										end
									end
								end
							end
					love.graphics.pop()
					love.graphics.push()
						if whoHasPixelNotes ~= "boyfriend" and whoHasPixelNotes ~= "both" then
							for j = #boyfriendNotes[i], 1, -1 do
								if boyfriendNotes[i][j].y - musicPos <= 560 then
									local animName = boyfriendNotes[i][j]:getAnimName()

									if animName == "hold" or animName == "end" then
										graphics.setColor(1, 1, 1, math.min(0.5, (500 + (boyfriendNotes[i][j].y - musicPos)) / 150) * (useUIAlphaForNotes and uiAlpha[1] or boyfriendArrows[i].alpha))
									else
										graphics.setColor(1, 1, 1, math.min(1, (500 + (boyfriendNotes[i][j].y - musicPos)) / 75) * (useUIAlphaForNotes and uiAlpha[1] or boyfriendArrows[i].alpha))
									end
									if not pixel then 
										boyfriendNotes[i][j]:draw()
									else
										if not settings.downscroll then
											boyfriendNotes[i][j]:udraw(8, 8)
										else
											if boyfriendNotes[i][j]:getAnimName() == "end" then
												boyfriendNotes[i][j]:udraw(8, 8)
											else
												boyfriendNotes[i][j]:udraw(8, -8)
											end
										end
									end
								end
							end
						end

						if showPixelNotes then
							if whoHasPixelNotes ~= "enemy" and whoHasPixelNotes ~= "none" then
								for j = #boyfriendNotesP[i], 1, -1 do
									if boyfriendNotesP[i][j].y - musicPos <= 560 then
										local animName = boyfriendNotesP[i][j]:getAnimName()
		
										if animName == "hold" or animName == "end" then
											graphics.setColor(1, 1, 1, math.min(0.5, (500 + (boyfriendNotesP[i][j].y - musicPos)) / 150) * (useUIAlphaForNotes and uiAlpha[1] or boyfriendArrows[i].alpha))
										else
											graphics.setColor(1, 1, 1, math.min(1, (500 + (boyfriendNotesP[i][j].y - musicPos)) / 75) * (useUIAlphaForNotes and uiAlpha[1] or boyfriendArrows[i].alpha))
										end
										if not settings.downscroll then
											boyfriendNotesP[i][j]:udraw(8, 8)
										else
											if boyfriendNotesP[i][j]:getAnimName() == "end" then
												boyfriendNotesP[i][j]:udraw(8, 8)
											else
												boyfriendNotesP[i][j]:udraw(8, -8)
											end
										end
									end
								end
							end
						end
					love.graphics.pop()
					graphics.setColor(1, 1, 1)
				love.graphics.pop()
			end

			graphics.setColor(1, 1, 1, countdownFade[1])
			if not settings.downscroll then
				if not pixel or pixel then 
					countdown:draw()
				else
					countdown:udraw(6.75, 6.75)
				end
			else
				if not pixel or pixel then 
					countdown:udraw(1, -1)
				else
					countdown:udraw(6.75, -6.75)
				end
			end
			graphics.setColor(1, 1, 1)
		love.graphics.pop()
	end,

	healthbarText = function(self, text, colourInline, colourOutline)
		local text = text or "???"
		local colourInline = colourInline or {1, 1, 1, 1}
		if not colourInline[4] then colourInline[4] = 1 end
		local colourOutline = colourOutline or {0, 0, 0, 1}
		if not colourOutline[4] then colourOutline[4] = 1 end
		--textshiz, -600, 400+downscrollOffset, 1200, "center"

		graphics.setColor(colourOutline[1], colourOutline[2], colourOutline[3], colourOutline[4]*uiAlpha[1])
		love.graphics.printf(text, -600-2, 400+downscrollOffset, 1200, "center")
		love.graphics.printf(text, -600+2, 400+downscrollOffset, 1200, "center")
		love.graphics.printf(text, -600, 400+downscrollOffset-2, 1200, "center")
		love.graphics.printf(text, -600, 400+downscrollOffset+2, 1200, "center")

		graphics.setColor(colourInline[1], colourInline[2], colourInline[3], colourInline[4]*uiAlpha[1])
		love.graphics.printf(text, -600, 400+downscrollOffset, 1200, "center")

		self:drawRating()
	end,

	drawHealthbar = function(self, visibility)
		local visibility = visibility or 1
		love.graphics.push()
			love.graphics.push()
				graphics.setColor(0,0,0,settings.scrollUnderlayTrans * uiAlpha[1])
				if settings.middleScroll and not settings.multiplayer then
					love.graphics.rectangle("fill", 400, -100, 90 + 170 * 2.35, 1000)
				else
					love.graphics.rectangle("fill", 755, -100, 90 + 170 * 2.35, 1000)
				end
			graphics.setColor(1,1,1,uiAlpha[1])
			love.graphics.pop()
			love.graphics.translate(lovesize.getWidth() / 2, lovesize.getHeight() / 2)
			love.graphics.scale(0.7, 0.7)
			love.graphics.scale(uiScale.zoom, uiScale.zoom)

			graphics.setColor(1, 1, 1, visibility*uiAlpha[1])
			graphics.setColor(1, 0, 0, uiAlpha[1])
			love.graphics.rectangle("fill", -500, 350+downscrollOffset, 1000, 25)
			graphics.setColor(0, 1, 0, uiAlpha[1])
			love.graphics.rectangle("fill", 500, 350+downscrollOffset, -health * 500, 25)
			graphics.setColor(0, 0, 0, uiAlpha[1])
			love.graphics.setLineWidth(10)
			love.graphics.rectangle("line", -500, 350+downscrollOffset, 1000, 25)
			love.graphics.setLineWidth(1)
			graphics.setColor(1, 1, 1, uiAlpha[1])

			boyfriendIcon:draw()
			if showEnemyIcon then
				enemyIcon:draw()
			end

			self:healthbarText("Score: " .. score .. " | Misses: " .. misses .. " | Accuracy: " .. ((math.floor(ratingPercent * 10000) / 100)) .. "%")

			if settings.botPlay then
				botplayY = botplayY + math.sin(love.timer.getTime()) * 0.15
				uitext("BOTPLAY", -85, botplayY, 0, 2, 2, 0, 0, 0, 0, botplayAlpha[1])
				graphics.setColor(1, 1, 1)
			end

			graphics.setColor(1,1,1,1)
		love.graphics.pop()
	end,

	leave = function(self)
		if inst then inst:stop() end
		voices:stop()

		playMenuMusic = true

		camera:removePoint("boyfriend")
		camera:removePoint("enemy")

		Timer.clear()

		fakeBoyfriend = nil
		hasPixelNotes = false
		whoHasPixelNotes = "none"

		enemy2 = nil
		enemy3 = nil

		love.graphics.setBackgroundColor(0, 0, 0)

		storyMode = false
	end
}
