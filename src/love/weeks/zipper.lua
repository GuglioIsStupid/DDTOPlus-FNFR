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

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()
        stages["clubroom"]:enter("zipper")
        showDokis = false

		song = songNum
		difficulty = songAppend

		boyfriendIcon:animate("sayori", false)

		boyfriend.flipX = true

		stageImages.zippergoo = graphics.newImage(graphics.imagePath("zippergoo"))

		stageImages.zippergoo.sizeX = 0.666
		stageImages.zippergoo.sizeY = 0.666

		stageImages.zippergoo.visible = false
		stageImages.zippergoo.alpha = 0

		stageImages.vignette.alpha = 0

		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
        stages["clubroom"]:load()
		inst = love.audio.newSource("songs/extra/constricted/Inst.ogg", "stream")
		voices = love.audio.newSource("songs/extra/constricted/Voices.ogg", "stream")

		self:initUI()

        countNum = 0
		showDokis = false
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes("data/songs/constricted/constricted.json")
		if storyMode and not died then
			weeks:setupCountdown()
		else
			weeks:setupCountdown()
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["clubroom"]:update(dt)

		if not countingDown and not inCutscene then
		else
			previousFrameTime = love.timer.getTime() * 1000
		end

		if beatHandler.onStep() then
            local camTimer
            if camTimer then
                Timer.cancel(camTimer)
            end
			local s = beatHandler.curStep
			if song == 1 then
				if s == 624 and countNum == 0 then
					Timer.tween(beatHandler.calcSectionLength(0.1), stageImages.zippergoo, {alpha = 1}, "out-sine")
					stageImages.zippergoo.visible = true
					stageImages.vignette.visible = true
					camera.zooming = false
					camera.mustHit = false
					stageImages.vignette.alpha = 0.2

					Timer.tween(beatHandler.calcSectionLength(), camera, {zoom = 1.5}, "out-sine")

					countNum = 1
				elseif s == 639 and countNum == 1 then -- 640 is too late
					camera.zooming = true
					camera.mustHit = true
					countNum = 2
				elseif s == 1024 and countNum == 2 then
					Timer.tween(beatHandler.calcSectionLength(2), stageImages.zippergoo, {alpha = 0}, "out-sine")
					Timer.tween(beatHandler.calcSectionLength(2), stageImages.vignette, {alpha = 0}, "out-sine")

					countNum = 3
				end
            end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 1 then
                
            end
        end
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			status.setLoading(true)

			if not SaveData.songs.beatSide and not util.contains(SaveData.songs.sideStatus, "constricted") then
				table.insert(SaveData.songs.sideStatus, "constricted")

				if #SaveData.songs.sideStatus == 4 then
					SaveData.songs.beatSide = true
				end
			end

			graphics:fadeOutWipe(
				0.7,
				function()
					Gamestate.switch(menu)

					status.setLoading(false)
				end
			)
		end

		if inCutscene then
			dialogue.doDialogue(dt)

			if input:pressed("confirm") then
				dialogue.next()
			end
		end

		if health >= 1.595 then
			if enemyIcon:getAnimName() == "monika" then
				enemyIcon:animate("monika losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "monika" then
				enemyIcon:animate("monika winning")
			end
		else
			if enemyIcon:getAnimName() == "monika losing" or enemyIcon:getAnimName() == "monika winning" then
				enemyIcon:animate("monika")
			end
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)

            stages["clubroom"]:draw()

			
		love.graphics.pop()

        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.setColor(1,1,1,stageImages.vignette.alpha)
			stageImages.vignette:draw()
			love.graphics.setColor(1,1,1,stageImages.zippergoo.alpha)
			stageImages.zippergoo:draw()
			love.graphics.setColor(1,1,1,1)
        love.graphics.pop()

		if inCutscene then 
			dialogue.draw()
		else
			weeks:drawUI()
		end
	end,

	leave = function(self)
		graphics.clearCache()
        showDokis = true
		weeks:leave()
	end
}
