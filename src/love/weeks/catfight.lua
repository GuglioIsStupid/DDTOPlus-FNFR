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
	enter = function(self, from, songNum, songAppend, choosen)
		weeks:enter()
        stages["clubroom"]:enter("catfight")
        showDokis = false

		song = songNum
		difficulty = songAppend

		boyfriendIcon:animate("natsuki", false)
        enemyIcon:animate("yuri")

		boyfriend.flipX = true

		self:load()

		musicPos = 0

        if choosen == 2 then
            mirrorMode = false
        elseif choosen == 1 then
            mirrorMode = true
        end 

        camera:addPoint("center", 0, 350)
	end,

	load = function(self)
		weeks:load()
        stages["clubroom"]:load()
		inst = love.audio.newSource("songs/extra/catfight/Inst.ogg", "stream")
		voices = love.audio.newSource("songs/extra/catfight/Voices.ogg", "stream")

		self:initUI()

        countNum = 0
		showDokis = false
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes("data/extra/catfight/catfight.json")
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
				if s == 608 and countNum == 0 then
                    camera.defaultZoom = 0.8
                    countNum = 1
                elseif s == 624 and countNum == 1 then
                    camera.defaultZoom = 0.85
                    countNum = 2
                elseif s == 640 and countNum == 2 then
                    camera.defaultZoom = 0.9
                    countNum = 3

				--[[
                elseif s == 1120 and countNum == 3 then
                    camera.defaultZoom = 0.95
                    countNum = 4
				
                elseif s == 1136 and countNum == 4 then
                    camera.defaultZoom = 1
                    countNum = 5
                elseif s == 1150 and countNum == 5 then
                    countNum = 6
                    camera.mustHit = false
                    camera.zooming = false
                    camera:moveToMain(0.25, girlfriend.x, girlfriend.y + 75)
                elseif s == 1169 and countNum == 6 then
                    camera.defaultZoom = 1.05
                    countNum = 7
                    girlfriend:animate("scared")
                    camera.mustHit = true
                    camera.zooming = true
                elseif s == 1195 and countNum == 7 then
                    girlfriend:animate("sayoLeft")
                    girlfriend.danced = false
                    countNum = 8
                elseif s == 1568 and countNum == 8 then
                    camera.defaultZoom = 1.1
                    countNum = 9
                elseif s == 1696 and countNum == 9 then
                    camera.defaultZoom = 1.15
                    countNum = 10
                elseif s == 1712 and countNum == 10 then
                    camera.defaultZoom = 1.2
                    countNum = 11
				--]]
					-- im too dumb to make beat handling proper, so it can't handle bpm changes
					-- rest of the events are done via musicTime
				end
            end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 1 then
                
            end
        end

		if musicTime >= 111180 and countNum == 3 then
			camera.mustHit = false
			camera.zooming = false
			camera:moveToMain(0.25, girlfriend.x, girlfriend.y -150)
			Timer.tween(0.45, camera, {zoom=1.55}, "out-sine")
			girlfriend:animate("popout")
			girlfriend.danceIdle = true

			countNum = 4
		elseif musicTime >= 113310 and countNum == 4 then
			girlfriend:animate("scared", false, function() girlfriend:animate("danceLeft") girlfriend.danced = false end)
			camera.mustHit = true
			camera.zooming = true

			countNum = 5
		end


		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			status.setLoading(true)

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
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri winning")
			end
		else
			if enemyIcon:getAnimName() == "yuri losing" or enemyIcon:getAnimName() == "yuri winning" then
				enemyIcon:animate("yuri")
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
