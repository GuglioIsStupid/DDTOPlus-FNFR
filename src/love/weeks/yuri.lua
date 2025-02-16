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
        stages["clubroom"]:enter("yuri")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("yuri", false)

        exhale = love.audio.newSource("sounds/exhale.ogg", "static")
        shutoff = love.audio.newSource("sounds/Lights_Shut_off.ogg", "static")

		self:load()

        yuriGoneCrazy = false

		musicPos = 0

        function yuriGoCrazy()
            yuriGoneCrazy = true

            camera.defaultZoom = 1.5
            camera.zooming = true
            
            stageImages.desks.visible = false
            stageImages.blackScreenBG.alpha = 0.8

            boyfriend.x = enemy.x + 250

            stageImages.vignette.visible = true
            stageImages.vignette.alpha = 0.6
            camera:addPoint("boyfriend", -boyfriend.x + 100, -boyfriend.y + 75)
            camera:moveToPoint(0.1, "enemy")
        end
	end,

	load = function(self)
		weeks:load()
        stages["clubroom"]:load()

		if song == 1 then
			inst = love.audio.newSource("songs/yuri/deep breaths/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/yuri/deep breaths/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/yuri/obsession/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/yuri/obsession/Voices.ogg", "stream")
		end

		self:initUI()

        countNum = 0
        yuriGoneCrazy = false
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 1 then
			weeks:generateNotes("data/songs/deep breaths/deep breaths.json")
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		else
			weeks:generateNotes("data/songs/obsession/obsession.json")

            enemy2 = love.filesystem.load("sprites/characters/yuri/" .. SaveData.costumes.yuri .. "crazy.lua")()
            enemy2.x, enemy2.y = enemy2.x - 400, enemy.y + 105
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end

            showDokis = false
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["clubroom"]:update(dt)

		if not countingDown and not inCutscene then
		else
			previousFrameTime = love.timer.getTime() * 1000
		end

        stageImages.sparkleBG.offsetX = stageImages.sparkleBG.offsetX - 16 * dt
        if stageImages.sparkleBG.offsetX < -stageImages.sparkleBG:getWidth()/2 then
            stageImages.sparkleBG.offsetX = 0
        end

        stageImages.staticshock:update(dt)

		if beatHandler.onStep() then
            local camTimer
            if camTimer then
                Timer.cancel(camTimer)
            end
			local s = beatHandler.curStep
			if song == 1 then
				if s == 139 and countNum == 0 then
                    enemy:animate("breath")
                    countNum = 1
                elseif s == 148 and countNum == 1 then
                    love.audio.play(exhale)
                end
			elseif song == 2 then
				if s == 486 and countNum == 0 then 
                    camera.zooming = false
                    stageImages.staticshock.visible = true
                    Timer.tween(beatHandler.stepCrochet / 14, camera, {zoom = 1.5})
                    Timer.tween(beatHandler.stepCrochet / 14, stageImages.staticshock, {alpha = 1}, "linear", function() 
                        stageImages.staticshock.alpha = 0.1 
                        stageImages.blackScreen.visible = true
                        stageImages.blackScreen.alpha = 1
                        shutoff:setVolume(0.5)
                        love.audio.play(shutoff)
                    end)
                    countNum = 1
                elseif s == 562 and countNum == 1 then
                    countNum = 2
                elseif s == 570 and countNum == 2 then
                    yuriGoCrazy()
                    countNum = 3
                elseif s == 610 and countNum == 3 then
                    Timer.tween(beatHandler.calcSectionLength(0.75), stageImages.blackScreen, {alpha = 0}, "out-sine")
                    countNum = 4
                elseif s == 1134 and countNum == 4 then
                    stageImages.blackScreen.visible = true
                    stageImages.blackScreen.alpha = 1
                end
			end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 1 then
                if b == 98 then
                    stageImages.sparkleBG.visible = true
                    stageImages.sparkleFG.visible = true
                    stageImages.pinkOverlay.visible = true
                elseif b == 194 then
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.sparkleBG, {alpha = 0}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.sparkleFG, {alpha = 0}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.pinkOverlay, {alpha = 0}, "out-sine")
                elseif b == 244 then
                    stageImages.sparkleBG.alpha = 1
                    stageImages.sparkleFG.alpha = 1
                    stageImages.pinkOverlay.alpha = 0.2
                elseif b == 282 then
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.sparkleBG, {alpha = 0}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.sparkleFG, {alpha = 0}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.pinkOverlay, {alpha = 0}, "out-sine")
                end
            elseif song == 2 then
                
            end
        end
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			if storyMode and song < 2 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

                SaveData.songs.beatYuri = true

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
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri losing")
            elseif enemyIcon:getAnimName() == "yuri insane" then
                enemyIcon:animate("yuri insane losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri winning")
            elseif enemyIcon:getAnimName() == "yuri insane" then
                enemyIcon:animate("yuri insane winning")
			end
		else
			if enemyIcon:getAnimName() == "yuri losing" or enemyIcon:getAnimName() == "yuri winning" then
				enemyIcon:animate("yuri")
            elseif enemyIcon:getAnimName() == "yuri winning" or enemyIcon:getAnimName() == "yuri insane losing" then
                enemyIcon:animate("yuri insane")
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
            for i = -1, 1 do
                love.graphics.push()
                    if stageImages.sparkleBG.visible then 
                        stageImages.sparkleBG.x = (i) * stageImages.sparkleBG:getWidth()/2
                        graphics.setColor(1,1,1,stageImages.sparkleBG.alpha)
                        stageImages.sparkleBG:draw()
                        graphics.setColor(1,1,1,1)
                    end
                love.graphics.pop()
            end
            if stageImages.sparkleFG.visible then 
                graphics.setColor(1,1,1,stageImages.sparkleFG.alpha)
                stageImages.sparkleFG:draw()
                graphics.setColor(1,1,1,1)
            end
            if stageImages.pinkOverlay.visible then 
                graphics.setColor(242/255,129/255,242/255,stageImages.pinkOverlay.alpha)
                love.graphics.rectangle("fill", -2000, -2000, 10000, 10000)
                graphics.setColor(1,1,1,1)
            end

            if stageImages.vignette.visible then 
                graphics.setColor(0,0,0,stageImages.vignette.alpha)
                stageImages.vignette:draw()
                graphics.setColor(1,1,1,1)
            end

            if stageImages.staticshock.visible then
                graphics.setColor(1,1,1,stageImages.staticshock.alpha)
                stageImages.staticshock:draw()
                graphics.setColor(1,1,1,1)
            end

        love.graphics.pop()

		if inCutscene then 
			dialogue.draw()
		else
			weeks:drawUI()
		end

        if stageImages.blackScreen.visible then
            graphics.setColor(0,0,0,stageImages.blackScreen.alpha)
            love.graphics.rectangle("fill", -2000, -2000, 10000, 10000)
            graphics.setColor(1,1,1,1)
        end
	end,

	leave = function(self)
		graphics.clearCache()
        yuriGoneCrazy = false
		weeks:leave()
	end
}
