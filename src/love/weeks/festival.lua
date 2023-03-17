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
        stages["clubroom-festival"]:enter("yuri")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("senpai", false)

        function gopixel(v)
            curEnemy = "pmonika"
            camera:addPoint("boyfriend", -boyfriend2.x + 100, -boyfriend2.y + 75)
            camera:addPoint("enemy", -enemy2.x - 100, -enemy2.y + 75)

            if v == 1 then
                camera:moveToPoint(0.1, "boyfriend")
            else
                camera:moveToPoint(0.1, "enemy")
            end
        end

        function becomefumo(v)
            curEnemy = "monika"
            camera:addPoint("boyfriend", -boyfriend.x + 100, -boyfriend.y + 75)
            camera:addPoint("enemy", -enemy.x - 100, -enemy.y + 75)

            if v == 1 then
                camera:moveToPoint(0.1, "boyfriend")
            else
                camera:moveToPoint(0.1, "enemy")
            end
        end

		self:load()

		musicPos = 0
	end,

	load = function(self)
        if song == 1 then
            inst = love.audio.newSource("songs/festival/crucify (yuri mix)/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/festival/crucify (yuri mix)/Voices.ogg", "stream")
            curEnemy = "yuri"
        elseif song == 2 then
            inst = love.audio.newSource("songs/festival/beathoven (natsuki mix)/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/festival/beathoven (natsuki mix)/Voices.ogg", "stream")
            curEnemy = "natsuki"
        elseif song == 3 then
            inst = love.audio.newSource("songs/festival/it's complicated (sayori mix)/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/festival/it's complicated (sayori mix)/Voices.ogg", "stream")
            curEnemy = "sayori"
        elseif song == 4 then
            inst = love.audio.newSource("songs/festival/glitcher (monika mix)/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/festival/glitcher (monika mix)/Voices.ogg", "stream")
            curEnemy = "monika"
        end

        stages["clubroom-festival"]:load()
        weeks:load()

		self:initUI()

        countNum = 0
	end,

	initUI = function(self)
		weeks:initUI()

        if song == 1 then
            weeks:generateNotes("data/festival/crucify (yuri mix)/crucify (yuri mix).json")
        elseif song == 2 then
            weeks:generateNotes("data/festival/beathoven (natsuki mix)/monikas theme.json")
        elseif song == 3 then
            weeks:generateNotes("data/festival/it's complicated (sayori mix)/it's complicated (sayori mix).json")
        elseif song == 4 then
            weeks:generateNotes("data/festival/glitcher (monika mix)/glitcher (monika mix).json")
        end
		
		if storyMode and not died then
			weeks:setupCountdown()
		else
			weeks:setupCountdown()
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["clubroom-festival"]:update(dt)

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
				if s == 128 then
                    
                elseif s == 224 then 

                end
            elseif song == 2 then
                if s == 192 then

                elseif s == 304 then

                end
            elseif song == 3 then
                if s == 260 then

                elseif s == 384 then

                end
            elseif song == 4 then
                if s == 64 and countNum == 0 then
                    countNum = 1
                elseif s == 192 and countNum == 1 then
                    countNum = 2
                elseif s == 566 or s == 816 or s == 1072 or s == 1328 then -- start glitch
                    -- Pixel glitch shader
                    glitchyAmount = {0}
                    Timer.tween(beatHandler.calcSectionLength(), glitchyAmount, {2.7}, "out-quad")
                elseif s == 576 or s == 1088 then -- end glitch to pixel
                    gopixel()
                    glitchyAmount = {2.7}
                    Timer.tween(beatHandler.calcSectionLength(0.7), glitchyAmount, {0}, "out-quad", function() glitchyAmount = {0} end)
                elseif s == 832 or s == 1343 then
                    -- end glitch to normal
                    becomefumo()
                    glitchyAmount = {2.7}
                    Timer.tween(beatHandler.calcSectionLength(0.7), glitchyAmount, {0}, "out-quad", function() glitchyAmount = {0} end)
                elseif s == 1360 or s == 1392 then
                    gopixel()
                    countNum = 5
                elseif s == 1424 or s == 1456 then 
                    gopixel(1)
                elseif s == 1376 or s == 1408 then
                    becomefumo()
                elseif s == 1440 or s == 1472 then
                    becomefumo(1)
                end
			end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 1 then
				
            elseif song == 2 then
                
            elseif song == 3 then

            elseif song == 4 then

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

		weeks:updateUI(dt)
	end,

    keypressed = function(self, key)
        if key == "p" then 
            print("???")
            if curEnemy == "monika" then
                gopixel()
            else
                becomefumo()
            end
        end
    end,

	draw = function(self)
		love.graphics.push()
            stages["clubroom-festival"]:draw()
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

		weeks:leave()
	end
}
