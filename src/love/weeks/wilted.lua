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
        stages["wilted"]:enter()
        showDokis = false

		song = songNum
		difficulty = songAppend

		boyfriendIcon:animate("natsuki", false)
        enemyIcon:animate("yuri")

		boyfriend.flipX = true
        hasPixelNotes = true
        whoHasPixelNotes = "enemy" -- can be enemy, boyfriend, or both
        enemyIsPixel = true
        showStatic = false

        function glitchEffect()
            showStatic = true
            Timer.after(0.2, function()
                showStatic = false
            end)
        end

        function wiltswap(t)
            local t = t or 0
            whiteFlash.alpha = 1
            Timer.tween(beatHandler.calcSectionLength(0.1), whiteFlash, {alpha = 0}, "out-sine")
            if t == 1 then
                -- monika becoems pixel
                enemy = senpaiNonpixel
                boyfriend = monikapixel
                boyfriend.flipX = true
                enemyIsPixel = false
                curBG = "bg2"
                whoHasPixelNotes = "boyfriend" 
            else
                -- monika becomes non pixel
                enemy = senpai
                boyfriend = monika
                boyfriend.flipX = true
                enemyIsPixel = true
                curBG = "bg1"
                whoHasPixelNotes = "enemy"
            end
        end

		musicPos = 0

        camera:addPoint("center", 0, 350)
        funCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
        funCanvas2 = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())

        whiteFlash = {
            alpha = 0
        }

        self:load()
	end,

	load = function(self)
		weeks:load()
        stages["wilted"]:load()
		inst = love.audio.newSource("songs/extra/wilted/Inst.ogg", "stream")
		voices = love.audio.newSource("songs/extra/wilted/Voices.ogg", "stream")

		self:initUI()

        countNum = 0
		showDokis = false

        isShitVisible = true

        wiltswap(0)
	end,

	initUI = function(self)
		weeks:initUI()
        hasPixelNotes = true
        showPixelNotes = true
        whoHasPixelNotes = "enemy" -- can be enemy, boyfriend, or both

		weeks:generateNotes("data/songs/wilted/wilted.json")
		if storyMode and not died then
			weeks:setupCountdown()
		else
			weeks:setupCountdown()
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["wilted"]:update(dt)

		if not countingDown and not inCutscene then
		else
			previousFrameTime = love.timer.getTime() * 1000
		end

        camera.x, camera.y = 0, 0

		if beatHandler.onStep() then
            local camTimer
            if camTimer then
                Timer.cancel(camTimer)
            end
			local s = beatHandler.curStep
			if song == 1 and not countingDown then
                if s == 16 and countNum == 0 then
                    -- whiteflash shit
                    countNum = 1
                elseif s == 512 and countNum == 1 then
                    glitchEffect()
                    countNum = 2
                elseif s == 516 and countNum == 2 then
                    glitchEffect()
                    enemy = senpaiAngry
                    countNum = 3
                elseif s == 520 and countNum == 3 then
                    glitchEffect()
                    -- change window
                    curW = "w2"
                    countNum = 4
                elseif s == 656 and countNum == 4 then
                    camera.defaultZoom = 0.8
                    wiltswap(1)
                    countNum = 5
                elseif s == 708 and countNum == 5 then
                    camera.defaultZoom = 0.7
                    countNum = 6
                elseif s == 841 and countNum == 6 then
                    enemy:animate("swap")
                    countNum = 7
                elseif s == 848 and countNum == 7 then
                    enemy = senpaiAngryNonpixel
                    countNum = 8
                elseif s == 912 and countNum == 8 then
                    --wilted shiz
                    stageImages.hoii.visible = true
                    stageImages.hoii_senpai.visible = true
                    stageImages.hoii:animate("anim", false, function()
                        stageImages.hoii.visible = false
                    end)
                    stageImages.hoii_senpai:animate("anim", false, function()
                        stageImages.hoii_senpai.visible = false
                    end)
                    countNum = 9
                elseif s == 928 and countNum == 9 then
                    wiltswap(0)
                    enemy = senpaiAngry
                    countNum = 10
                elseif s == 929 and countNum == 10 then
                    -- remove wilted shiz
                    countNum = 11
                elseif s == 1056 and countNum == 11 then
                    -- start hmmph thing
                    stageImages.hmph.visible = true
                    stageImages.hmph:animate("anim", false)
                    countNum = 12
                elseif s == 1064 and countNum == 12 then
                    -- set shit to invisible
                    isShitVisible = false
                    countNum = 13
                elseif s == 1100 and countNum == 13 then
                    -- fade to black
                    countNum = 14
                end
            end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 1 then
                
            end
        end

        --[[
		if input:pressed("left") then
            wiltswap(0)
        elseif input:pressed("right") then
            wiltswap(1)
        end
        --]]

        static:send("iTime", love.timer.getTime())

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			status.setLoading(true)

			graphics:fadeOutWipe(
				0.7,
				function()
                    highscore:save("Wilted", score, mirrorMode)
					if storyMode then
                        Gamestate.switch(menuWeek)
                        if not leftSong then
                            if not SaveData.songs.beatSide and not util.contains(SaveData.songs.sideStatus, "wilted") then
                                table.insert(SaveData.songs.sideStatus, "wilted")
                
                                if #SaveData.songs.sideStatus == 4 then
                                    SaveData.songs.beatSide = true
                                end
                            end
                        end
                    else
                        Gamestate.switch(menuFreeplay)
                    end

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
        love.graphics.setCanvas(funCanvas)
            love.graphics.clear()
            love.graphics.push()
                love.graphics.translate(camera.x * 0.1, camera.y * 0.1)
                love.graphics.translate(camera.ex * 0.1, camera.ey * 0.1)
                love.graphics.setShader(fisheye)
                    scrollingBG:draw()
                love.graphics.setShader()
                scrollingBG2:draw()
            love.graphics.pop()
        love.graphics.setCanvas()

        love.graphics.setCanvas(funCanvas2)
        love.graphics.clear()
        love.graphics.push()
            love.graphics.push()
                love.graphics.setShader(fisheye)
                love.graphics.draw(funCanvas, 0, 0, 0, 1, 1)
                love.graphics.setShader()
            love.graphics.pop()
            
            love.graphics.push()
                love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
                love.graphics.scale(camera.zoom, camera.zoom)

                stages["wilted"]:draw()

            love.graphics.pop()

            love.graphics.push()
                love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)

            love.graphics.pop()
        love.graphics.pop()
        love.graphics.setCanvas()

        love.graphics.push()
        if showStatic then love.graphics.setShader(static) end
        love.graphics.draw(funCanvas2, 0, 0, 0, graphics.getWidth() / funCanvas2:getWidth(), graphics.getHeight() / funCanvas2:getHeight())
        love.graphics.setShader()
        love.graphics.pop()

        love.graphics.setColor(1,1,1,whiteFlash.alpha)
        love.graphics.rectangle("fill", -1000, -1000, 3000, 3000)
        love.graphics.setColor(1,1,1,1)

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
