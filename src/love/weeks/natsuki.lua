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
        stages["clubroom"]:enter("natsuki")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("natsuki", false)

		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
        stages["clubroom"]:load()

		if song == 1 then
			inst = love.audio.newSource("songs/natsuki/my sweets/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/natsuki/my sweets/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/natsuki/baka/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/natsuki/baka/Voices.ogg", "stream")
		end

		self:initUI()

        countNum = 0
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 1 then
			weeks:generateNotes("data/natsuki/my sweets/my sweets.json")
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		else
			weeks:generateNotes("data/natsuki/baka/baka.json")
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["clubroom"]:update(dt)

        stageImages.bakaOverlay:update(dt)

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
				
			elseif song == 2 then
				
			end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 2 then
                if b == 16 and countNum == 0 then
                    stageImages.bakaOverlay.visible = true
                    Timer.tween(beatHandler.calcSectionLength(2), stageImages.bakaOverlay, {alpha = 1}, "in-sine")
                    countNum = 1
                elseif b == 32 then
                    camera:shake(0.002, beatHandler.calcSectionLength(2))
                    stageImages.bakaOverlay:animate("party rock is", true)
                    camera.defaultZoom = 1.2
                elseif b == 40 then
                    
                elseif b == 48 then
                    camera.defaultZoom = 0.85
                elseif b == 112 or b == 264 then
                    Timer.tween(beatHandler.calcSectionLength(2), stageImages.bakaOverlay, {alpha = 0}, "out-sine")
                elseif b == 144 then
                    stageImages.bakaOverlay:animate("normal", true)
                    Timer.tween(beatHandler.calcSectionLength(2), stageImages.bakaOverlay, {alpha = 1}, "in-sine")
                elseif b == 176 then
                    stageImages.bakaOverlay:animate("party rock is", true)
                end
            elseif song == 1 then
                if b == 260 then 
                    enemy:animate("hmmph")
                end
            end
        end
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			if storyMode and song < 2 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics:fadeOutWipe(
					0.7,
					function()
						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		if inCutscene then
			dialogue.doDialogue(dt)

			if input:pressed("confirm") then
				dialogue.next()
			end
		end

		if health >= 1.595 then
			if enemyIcon:getAnimName() == "natsuki" then
				enemyIcon:animate("natsuki losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "natsuki" then
				enemyIcon:animate("natsuki winning")
			end
		else
			if enemyIcon:getAnimName() == "natsuki losing" or enemyIcon:getAnimName() == "natsuki winning" then
				enemyIcon:animate("natsuki")
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
            if stageImages.bakaOverlay.visible then 
                graphics.setColor(1,1,1,stageImages.bakaOverlay.alpha)
                stageImages.bakaOverlay:draw()
                graphics.setColor(1,1,1,1)
            end
        love.graphics.pop()

		if inCutscene then 
			dialogue.draw()
		else
			weeks:drawUI()
		end
	end,

	leave = function(self)
		graphics.clearCache()

		weeks:leave()
	end
}
