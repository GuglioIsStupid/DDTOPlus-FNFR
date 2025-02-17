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

dokiLights = {
    {149/255, 224/255, 250/255},
    {187/255,255/255,144/255},
    {255/255,159/255,217/255},
    {227/255,140/255,238/255}
}
curDokiLight = 1 -- so it doesn't gfucking die
pastDokiLight = 6

local songList = {
    "Hot Air Balloon",
    "Shrinking Violet",
    "Joyride",
    "Our Harmony"
}

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()
        stages["musicroom"]:enter("yuri")

        border = "encore"

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 1

		enemyIcon:animate("natsuki", false)
        boyfriendIcon:animate("monika", false)

        whiteflash = {alpha=0}

		self:load()

        function doEncore(v)
            if v == 1 or v == 2 then
                if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 then
                    curDokiLight = math.randomI(1, 4, pastDokiLight)
                    pastDokiLight = curDokiLight

                    border = "encore"

                    if encoreTime == 2 then
                        border = "sunshine"
                    end

                    if tweenTimer then
                        Timer.cancel(tweenTimer)
                    end

                    if border == "encore" then
                        stageImages.encore.alpha = 1
                        stageImages.sunshine.alpha = 0
                    else
                        stageImages.encore.alpha = 0
                        stageImages.sunshine.alpha = 1
                    end
                    tweenTimer = Timer.after(0.5, function()
                        if border == "encore" then
                            Timer.tween(1, stageImages.encore, {alpha = 0}, "linear")
                        else
                            Timer.tween(1, stageImages.sunshine, {alpha = 0}, "linear")
                        end
                    end)
                end
            elseif v == 3 then
                if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 and stickerSprites ~= nil then

                end
            elseif v == 4 then
                if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 then

                end
            end
        end

		musicPos = 0
	end,

	load = function(self)
        if song == 1 then
            inst = love.audio.newSource("songs/encore/hot air balloon/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/encore/hot air balloon/Voices.ogg", "stream")
            curEnemy = "yuri"
        elseif song == 2 then
            inst = love.audio.newSource("songs/encore/shrinking violet/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/encore/shrinking violet/Voices.ogg", "stream")
            curEnemy = "natsuki"
            enemyIcon:animate("yuri")
        elseif song == 3 then
            inst = love.audio.newSource("songs/encore/joyride/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/encore/joyride/Voices.ogg", "stream")
            curEnemy = "sayori"
            enemyIcon:animate("sayori")
        elseif song == 4 then
            inst = love.audio.newSource("songs/encore/our harmony/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/encore/our harmony/Voices.ogg", "stream")
            curEnemy = "monika"
            enemyIcon:animate("our harmony")
            hasPixelNotes = true
        end

        stages["musicroom"]:load()
        weeks:load()

		self:initUI()

        countNum = 0
        encoreTime = 0
        FORCEP2NOMATTERWHAT = false
	end,

	initUI = function(self)
		weeks:initUI()

        if song == 1 then
            weeks:generateNotes("data/songs/hot air balloon/hot air balloon.json")
        elseif song == 2 then
            weeks:generateNotes("data/songs/shrinking violet/shrinking violet.json")
        elseif song == 3 then
            weeks:generateNotes("data/songs/joyride/joyride.json")
        elseif song == 4 then
            weeks:generateNotes("data/songs/our harmony/our harmony.json")
            lyrics.set("data/songs/our harmony/lyrics.txt")
        end
		
		if storyMode and not died then
			weeks:setupCountdown()
		else
			weeks:setupCountdown()
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
        stages["musicroom"]:update(dt)

        doEncore(encoreTime)

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
				if s == 1024 and countNum == 0 then
                    camera.defaultZoom = 1.35
                    stageImages.bakaOverlay.visible = true
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.bakaOverlay, {alpha = 1}, "in-sine")
                    countNum = 1
                elseif s == 1280 and countNum == 1 then
                    camera.defaultZoom = 1
                    Timer.tween(beatHandler.calcSectionLength(2), stageImages.bakaOverlay, {alpha = 0}, "out-sine", function()
                        stageImages.bakaOverlay.visible = false
                    end)
                    countNum = 2
                end
            elseif song == 2 then
                if s == 784 and countNum == 0 then
                    camera.defaultZoom = 1.3
                    stageImages.sparkleBG.visible = true
                    stageImages.sparkleFG.visible = true
                    stageImages.pinkOverlay.visible = true
                    countNum = 1
                elseif s == 1024 and countNum == 1 then
                    camera.defaultZoom = 1
                    countNum = 2
                elseif s == 1040 and countNum == 2 then
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.sparkleBG, {alpha = 0}, "out-sine", function()
                        stageImages.sparkleBG.visible = false
                    end)
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.sparkleFG, {alpha = 0}, "out-sine", function()
                        stageImages.sparkleFG.visible = false
                    end)
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.pinkOverlay, {alpha = 0}, "out-sine", function()
                        stageImages.pinkOverlay.visible = false
                    end)
                end
            elseif song == 3 then
                if s == 126 and countNum == 0 then
                    encoreTime = 2
                    camera.defaultZoom = 1.3
                    camera:moveToPoint(1.25, "enemy")
                    countNum = 1
                elseif s == 254 and countNum == 1 then
                    camera.defaultZoom = 1.6
                    camera:moveToPoint(1.25, "enemy")
                    encoreTime = 0
                    countNum = 2
                elseif (s == 270 and countNum == 2) or (s == 780 and countNum == 5) then
                    encoreTime = 2
                    camera.defaultZoom = 1
                    countNum = 3
                elseif s == 512 and countNum == 3 then
                    encoreTime = 0
                    countNum = 4
                elseif s == 768 and countNum == 4 then
                    camera.defaultZoom = 1.6
                    camera:moveToPoint(1.25, "enemy")
                    countNum = 5
                elseif s == 1024 and countNum == 3 then
                    encoreTime = 0
                    countNum = 6
                end
            elseif song == 4 then
                if s == 2420 and countNum == 0 then
                    Timer.tween(2, uiAlpha, {0}, "in-sine")
                    Timer.tween(2, whiteflash, {alpha = 1}, "in-sine")
                    countNum = 1
                elseif s == 2432 and countNum == 1 then
                    for i = 1, 4 do
                        Timer.after(0.5, function()
                            Timer.tween(1, boyfriendArrows[i], {offsetY = -10, alpha = 0}, "out-circ")
                            Timer.tween(1, enemyArrows[i], {offsetY = -10, alpha=0}, "in-circ")
                        end)
                    end
                    countNum = 2
                elseif s == 2448 and countNum == 2 then
                    stageImages.cg1.alpha = 1
                    voices:setVolume(1)
                    Timer.tween(5, stageImages.cg1, {sizeX = 0.67, sizeY = 0.67}, "in-sine")
                    camera.zooming = false
                    countNum = 3
                elseif s == 2456 and countNum == 3 then
                    Timer.tween(2, whiteflash, {alpha = 0}, "in-sine")
                    countNum = 4
                elseif s == 2568 and countNum == 4 then
                    Timer.tween(0.57, whiteflash, {alpha = 1}, "in-sine")
                    countNum = 5
                elseif s == 2578 and countNum == 5 then
                    stageImages.cg1.alpha = 0
                    stageImages.cg2.alpha = 1
                    Timer.tween(1, whiteflash, {alpha = 0}, "in-sine")
                    Timer.tween(9, stageImages.cg2, {x = -100}, "in-sine")
                    countNum = 6
                elseif s == 2674 and countNum == 6 then
                    Timer.tween(1, whiteflash, {alpha = 1}, "in-sine")
                    countNum = 7
                elseif s == 2694 and countNum == 7 then
                    stageImages.cg2.alpha = 0
                    stageImages.cg2group.alpha = 1
                    Timer.tween(17 + (1 * stageImages.cg2group.bg.ID), stageImages.cg2group.bg, {x=-250/2}, "in-sine")
                    Timer.tween(17 + (1 * stageImages.cg2group.sayo.ID), stageImages.cg2group.sayo, {x=-250/2}, "in-sine")
                    Timer.tween(17 + (1 * stageImages.cg2group.yuri.ID), stageImages.cg2group.yuri, {x=-250/2}, "in-sine")
                    Timer.tween(17 + (1 * stageImages.cg2group.natsu.ID), stageImages.cg2group.natsu, {x=-250/2}, "in-sine")
                    Timer.tween(17 + (1 * stageImages.cg2group.moni.ID), stageImages.cg2group.moni, {x=-250/2}, "in-sine")
                    Timer.tween(1, whiteflash, {alpha = 0}, "in-sine")
                    countNum = 8
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
			if storyMode and song < 4 then
                highscore:save(songList[song], score, mirrorMode)
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics:fadeOutWipe(
					0.7,
					function()
                        highscore:save(songList[song], score, mirrorMode)
						if storyMode then
                            Gamestate.switch(menuWeek)
                            if not leftSong then
                                SaveData.songs.beatEncore = true
                            end
                        else
                            Gamestate.switch(menuFreeplay)
                        end

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

        if beatHandler.curStep >= 2456 then
            lyrics.dolyrics(dt)
        end

        if health >= 1.595 then
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri losing")
            elseif enemyIcon:getAnimName() == "natsuki" then
                enemyIcon:animate("natsuki losing")
            elseif enemyIcon:getAnimName() == "sayori" then
                enemyIcon:animate("sayori losing")
            elseif enemyIcon:getAnimName() == "our harmony" then
                enemyIcon:animate("our harmony losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri winning")
            elseif enemyIcon:getAnimName() == "natsuki" then
                enemyIcon:animate("natsuki winning")
            elseif enemyIcon:getAnimName() == "sayori" then
                enemyIcon:animate("sayori winning")
            elseif enemyIcon:getAnimName() == "our harmony" then
                enemyIcon:animate("our harmony winning")
			end
		else
			if enemyIcon:getAnimName() == "yuri losing" or enemyIcon:getAnimName() == "monika winning" then
				enemyIcon:animate("yuri")
            elseif enemyIcon:getAnimName() == "natsuki losing" or enemyIcon:getAnimName() == "sayori winning" then
                enemyIcon:animate("natsuki")
            elseif enemyIcon:getAnimName() == "sayori losing" or enemyIcon:getAnimName() == "natsuki winning" then
                enemyIcon:animate("sayori")
            elseif enemyIcon:getAnimName() == "our harmony losing" or enemyIcon:getAnimName() == "our harmony winning" then
                enemyIcon:animate("our harmony")
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

            if stageImages.bakaOverlay.visible then
                graphics.setColor(1,1,1,stageImages.bakaOverlay.alpha)
                stageImages.bakaOverlay:draw()
                graphics.setColor(1,1,1)
            end
    
            if stageImages.sunshine.visible then
                graphics.setColor(dokiLights[curDokiLight][1],dokiLights[curDokiLight][2],dokiLights[curDokiLight][3],stageImages.sunshine.alpha)
                stageImages.sunshine:draw()
                graphics.setColor(1,1,1)
            end

            graphics.setColor(1,1,1,stageImages.cg1.alpha)
            stageImages.cg1:draw()
            graphics.setColor(1,1,1)

            graphics.setColor(1,1,1,stageImages.cg2.alpha)
            stageImages.cg2:draw()
            graphics.setColor(1,1,1)

            graphics.setColor(1,1,1,stageImages.cg2group.alpha)
            stageImages.cg2group:draw()
            graphics.setColor(1,1,1)

            love.graphics.setColor(1,1,1,whiteflash.alpha)
            love.graphics.rectangle("fill", -2000, -2000, 10000, 10000)
            love.graphics.setColor(1,1,1,1)
        love.graphics.pop()

		if inCutscene then 
			dialogue.draw()
		else
			weeks:drawUI()
		end

        if beatHandler.curStep >= 2456 then
            love.graphics.setColor(1,1,1,1)
            lyrics.draw()
        end
	end,

	leave = function(self)
		graphics.clearCache()
        status.setNoResize(false)
		weeks:leave()
	end
}
