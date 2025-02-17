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

local canvas, font

local difficulty

local dialogueFiles = {
	{
		start = "data/dialogue/high school conflict/IntroDialogue.json",
		finish = "data/dialogue/high school conflict/EndDialogue.json"
	},
	{
		start = "data/dialogue/bara no yume/IntroDialogue.json",
		finish = "data/dialogue/bara no yume/EndDialogue.json"
	},
	{
		start = "data/dialogue/your demise/IntroDialogue.json",
		finish = "data/dialogue/your demise/EndDialogue.json"
	}
}

local songList = {
	"High School Conflict",
	"Bara no Yume",
	"Your Demise",
	"Your Reality"
}

return {
	enter = function(self, from, songNum, songAppend)
		love.graphics.setDefaultFilter("nearest")
		weeks:enter("pixel")
		stages["school"]:enter()

		song = songNum
		difficulty = songAppend

		camera.zoom = 0.85

		fakeBoyfriend = love.filesystem.load("sprites/pixel/boyfriend-dead.lua")()

		fakeBoyfriend.x, fakeBoyfriend.y = 300, 190

		boyfriendIcon:animate("boyfriend (pixel)", false)
		enemyIcon:animate("monika pixel", false)

		pixelFont = love.graphics.newFont("fonts/pixel.fnt")

		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
		if song == 4 then
			stages["school"]:enter()
			stages["school"]:load()
			stages["bigroom"]:leave()

			enemy = love.filesystem.load("sprites/characters/pixel/monika.lua")()
			boyfriend = love.filesystem.load("sprites/week6/senpai.lua")()

			enemy.x, enemy.y = -340, -20
			boyfriend.x, boyfriend.y = 340, -20
		elseif song == 3 then
			school = love.filesystem.load("sprites/week6/evil-school.lua")()
			enemy = love.filesystem.load("sprites/week6/spirit.lua")()
			stages["school"]:leave()
			enemyIcon:animate("demise", false)
			stages["bigroom"]:enter()
			stages["bigroom"]:load()
		elseif song == 2 then
			enemy = love.filesystem.load("sprites/week6/senpai-angry.lua")()
			enemyIcon:animate("duet")
			stages["school"]:load()
		else
			enemy = love.filesystem.load("sprites/characters/pixel/monika.lua")()
			stages["school"]:load()
		end

		if song == 4 then
			inst = love.audio.newSource("songs/monika-pixel/your reality/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/monika-pixel/your reality/Voices.ogg", "stream")

			FORCEP2NOMATTERWHAT = false
		elseif song == 3 then
			inst = love.audio.newSource("songs/monika-pixel/your demise/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/monika-pixel/your demise/Voices.ogg", "stream")

			FORCEP2NOMATTERWHAT = true
		elseif song == 2 then
			inst = love.audio.newSource("songs/monika-pixel/bara no yume/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/monika-pixel/bara no yume/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/monika-pixel/high school conflict/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/monika-pixel/high school conflict/Voices.ogg", "stream")
		end
		enemy.x, enemy.y = -340, -20

		blackScreenAlpha = {1}

		function evilswap(num)
			if num == 0 or num == 2 then
				curStage = "bigroom"
				boyfriend.x, boyfriend.y = 345, 240
				camera:addPoint("enemy", -enemy2.x, -enemy2.y + 75)
				camera:addPoint("boyfriend", -boyfriend.x + 100, -boyfriend.y + 75)
			elseif num == 1 then
				boyfriend.x, boyfriend.y = 300, 190
				curStage = "haunted"
				camera:addPoint("enemy", -enemy.x - 100, -enemy.y + 75)
				camera:addPoint("boyfriend", -boyfriend.x + 100, -boyfriend.y + 75)
			end
		end

		self:initUI()
	end,

	initUI = function(self)
		weeks:initUI("pixel")

		if song == 4 then
			weeks:generateNotes("data/songs/your reality/your reality.json")
			weeks:setupCountdown()
		elseif song == 3 then
			weeks:generateNotes("data/songs/your demise/your demise.json")
			if storyMode and not died then
				--[[ weeks:setupDialogue(dialogueFiles[song].start)
				weeks.dialogueSequenceCallback = function()
					weeks:setupCountdown()
				end ]]
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		elseif song == 2 then
			weeks:generateNotes("data/songs/bara no yume/bara no yume.json")
			if storyMode and not died then
				--[[ weeks:setupDialogue(dialogueFiles[song].start)
				weeks.dialogueSequenceCallback = function()
					weeks:setupCountdown()
				end ]]
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		else
			weeks:generateNotes("data/songs/high school conflict/high school conflict.json")
			if storyMode and not died then
				--[[ weeks:setupDialogue(dialogueFiles[song].start)
				weeks.dialogueSequenceCallback = function()
					weeks:setupCountdown()
				end ]]
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		if song ~= 3 then
			stages["school"]:update(dt)
		else
			stages["bigroom"]:update(dt)
		end

		if not countingDown and not inCutscene then
		else
			previousFrameTime = love.timer.getTime() * 1000
		end

		if beatHandler.onStep() then
			local s = beatHandler.curStep
			if song == 3 then
				if s == 1 then
					Timer.tween(3, blackScreenAlpha, {0}, "out-sine")
				elseif s == 264 then
					blackScreenAlpha = {1}
				elseif s == 328 then
					blackScreenAlpha = {0}
				elseif s == 585 then
					camera.defaultZoom = 1.15
					evilswap(2)
				elseif s == 616 then
					camera.defaultZoom = 0.85
				elseif s == 648 then
					camera.defaultZoom = 1.15
				elseif s == 680 then
					camera.defaultZoom = 0.85
				elseif s == 712 then
					camera.defaultZoom = 1.15
				elseif s == 744 then
					camera.defaultZoom = 0.85
				elseif s == 776 then
					camera.defaultZoom = 1.15
				elseif s == 808 then 
					camera.defaultZoom = 0.85
				elseif s == 840 then
					evilswap(0)
				elseif s == 1602 then
					camera.defaultZoom = 1.15
				elseif s == 1640 then
					camera.defaultZoom = 0.85
					evilswap(1)
				elseif s == 1864 then
					Timer.tween(3, blackScreenAlpha, {1}, "out-sine")
				end
			elseif song == 2 then
				if s == 1360 then 
					glitchySchool(1)
				elseif s == 1368 then
					glitchySchool(0)
				end
			end
		end
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			if storyMode and song < 3 then
				--inCutscene = true
				--[[ weeks:setupDialogue(dialogueFiles[song].finish, {
					isEndDialogue = true
				})
				inCutscene = true
				weeks.dialogueSequenceCallback = function()
					song = song + 1

					self:load()
				end ]]
				highscore:save(songList[song], score, mirrorMode)
				song = song + 1

				self:load()
			else
				if storyMode then
					--[[ weeks:setupDialogue(dialogueFiles[song].finish, {
						isEndDialogue = true
					})
					inCutscene = true
					weeks.dialogueSequenceCallback = function()
						status.setLoading(true)

						SaveData.songs.beatPrologue = true

						graphics:fadeOutWipe(
							0.7,
							function()
								Gamestate.switch(menu)

								status.setLoading(false)
							end
						)
					end ]]
					status.setLoading(true)

					highscore:save(songList[song], score, mirrorMode)
					graphics:fadeOutWipe(
						0.7,
						function()
							if storyMode then
								Gamestate.switch(menuWeek)
								if not leftSong then
									SaveData.songs.beatPrologue = true
								end
							else
								Gamestate.switch(menuFreeplay)
							end

							status.setLoading(false)
						end
					)
				else
					status.setLoading(true)
					highscore:save(songList[song], score, mirrorMode)

					graphics:fadeOutWipe(
						0.7,
						function()
							Gamestate.switch(menu)

							status.setLoading(false)
						end
					)
				end
			end
		end

		if inCutscene then
			if input:pressed("confirm") then
				weeks:d_next()
			end
		end

		if health >= 1.595 then
			if enemyIcon:getAnimName() == "monika pixel" then
				enemyIcon:animate("monika pixel losing")
			elseif enemyIcon:getAnimName() == "duet" then
				enemyIcon:animate("duet losing")
			elseif enemyIcon:getAnimName() == "demise" then 
				enemyIcon:animate("demise losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "monika pixel" then
				enemyIcon:animate("monika pixel winning")
			elseif enemyIcon:getAnimName() == "duet" then
				enemyIcon:animate("duet winning")
			elseif enemyIcon:getAnimName() == "demise" then	
				enemyIcon:animate("demise winning")
			end
		else
			if enemyIcon:getAnimName() == "monika pixel losing" or enemyIcon:getAnimName() == "monika pixel winning" then
				enemyIcon:animate("monika pixel")
			elseif enemyIcon:getAnimName() == "duet losing" or enemyIcon:getAnimName() == "duet winning" then
				enemyIcon:animate("duet")
			elseif enemyIcon:getAnimName() == "demise losing" or enemyIcon:getAnimName() == "demise winning" then
				enemyIcon:animate("demise")
			end
		end
		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)

			if song ~= 3 then
				stages["school"]:draw()
			else
				stages["bigroom"]:draw()
				love.graphics.setColor(0,0,0,blackScreenAlpha[1])
				love.graphics.rectangle("fill", -2000, -2000, 10000, 10000)
				love.graphics.setColor(1,1,1,1)
			end
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)
		sky = nil
		school = nil
		street = nil

		graphics.clearCache()

		weeks:leave()
		stages["school"]:leave()
		stages["bigroom"]:leave()

		love.graphics.setDefaultFilter("linear")
	end
}
