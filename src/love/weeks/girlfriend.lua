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
        stages["musicroom"]:enter("gf")

		song = songNum
		difficulty = songAppend

		enemyIcon:animate("sayori", false)

		poemVideo = love.graphics.newVideo("videos/lnf.ogv")
		poemVideoAlpha = 0

		stageImages.sideWindow = graphics.newImage(graphics.imagePath("SideWindow"))
		stageImages.sideWindow.y = stageImages.sideWindow:getHeight() / 2 + 275
		stageImages.sideWindow.x = stageImages.sideWindow:getWidth() / 2
		flashLol = {
			alpha = 0,
			color = {1, 1, 1}
		}
		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
        stages["musicroom"]:load()

		inst = love.audio.newSource("songs/extra/love n funkin/Inst.ogg", "stream")
		voices = love.audio.newSource("songs/extra/love n funkin/Voices.ogg", "stream")

		self:initUI()

        countNum = 0
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes("data/extra/love n funkin/love n funkin.json")
		if storyMode and not died then
			weeks:setupCountdown()
		else
			weeks:setupCountdown()
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["musicroom"]:update(dt)

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
				if s == 383 and countNum == 0 then
					poemVideo:play()
					countNum = 1
				elseif s == 384 and countNum == 1 then
					-- dumb video shit
					poemVideoAlpha = 1
					camera.zooming = false
					countNum = 2
					enemy.x, enemy.y = -200, 600
					enemy2.x, enemy2.y = -200, 600
					enemy3.x, enemy3.y = 125, 600
					girlfriend.x, girlfriend.y = -1000, 600
					flashLol.alpha = 1
					Timer.tween(0.5, flashLol, {alpha = 0}, "in-out-sine")
				elseif s == 504 and countNum == 2 then
					Timer.tween(beatHandler.calcSectionLength(0.25), enemy3, {x = -200}, "in-out-sine")
					countNum = 3
				elseif s == 508 and countNum == 3 then
					Timer.tween(beatHandler.calcSectionLength(0.25), girlfriend, {x = 200}, "in-out-sine")
					countNum = 4
				elseif s == 640 and countNum == 4 then
					poemVideoAlpha = 0
					poemVideo:pause()
					flashLol.alpha = 1
					Timer.tween(0.5, flashLol, {alpha = 0}, "in-out-sine")

					enemy.x, enemy.y = charPos.enemy.x, charPos.enemy.y
					enemy2.x, enemy2.y = charPos.enemy2.x, charPos.enemy2.y
					enemy3.x, enemy3.y = charPos.enemy3.x, charPos.enemy3.y
					girlfriend.x, girlfriend.y = charPos.girlfriend.x, charPos.girlfriend.y
					countNum = 5
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

            stages["musicroom"]:draw()
		love.graphics.pop()

        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
        love.graphics.pop()

		if poemVideo:isPlaying() then
			-- draw and scale poemVideo to 1280x720
			love.graphics.setColor(1,1,1,poemVideoAlpha)
			love.graphics.draw(poemVideo, 0, 0, 0, graphics.getWidth()/1280, graphics.getHeight()/720)
			stageImages.sideWindow:udraw(1, 1)

			if gf == "gf" then
                girlfriend:udraw(0.75, 0.75)
            end
            if song == 4 or gf == "gf" then
                enemy3:udraw(0.75, 0.75)
            end
			enemy:udraw(0.75, 0.75)
            if song == 4 or gf == "gf" then
                enemy2:udraw(0.75, 0.75)
            end
			love.graphics.setColor(1,1,1,1)
		end

		love.graphics.setColor(flashLol.color[1], flashLol.color[2], flashLol.color[3], flashLol.alpha)
		love.graphics.rectangle("fill", -1000, -1000, 10000, 10000)
		love.graphics.setColor(1,1,1,1)

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
