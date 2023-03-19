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

local typeWriterText

local canvas, font

local difficulty

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()
        stages["clubroom"]:enter("mc")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("protag", false)

        spotlight = love.audio.newSource("sounds/spotlight.ogg", "static")

		self:load()

		musicPos = 0

        typeWriterText = {
            font = love.graphics.newFont("fonts/Journal.TTF", 84),
            alpha = 1,
            text = "",
            textLength = 0,
            currentText = "",
            currentTextLength = 0,
            timer = 0,
            done = false,

            setText = function(self, text)
                self.text = text
                self.textLength = text:len()
                self.currentText = ""
                self.currentTextLength = 0
                self.currentTextLength = 0
                self.timer = 0
                self.done = false
            end,

            update = function(self, dt)
                if self.currentTextLength < self.textLength then
                    self.timer = self.timer + dt

                    -- add if its not done
                    if self.timer > 0.025 and not self.done then
                        self.timer = 0
                        self.currentTextLength = self.currentTextLength + 1
                        self.currentText = self.text:sub(1, self.currentTextLength)
                    end

                    --  check if its done
                    if self.currentTextLength == self.textLength then
                        self.done = true
                    end
                end
            end,

            draw = function(self, x, y, r, sx, sy, ox, oy, kx, ky)
                love.graphics.setFont(self.font)
                love.graphics.setColor(0, 0, 0, self.alpha)
                love.graphics.printf(self.currentText, x+1, y, 1280, "left")
                love.graphics.printf(self.currentText, x-1, y, 1280, "left")
                love.graphics.printf(self.currentText, x, y+1, 1280, "left")
                love.graphics.printf(self.currentText, x, y-1, 1280, "left")
                love.graphics.setColor(1, 1, 1, self.alpha)
                love.graphics.printf(self.currentText, x, y, 1280, "left")
                love.graphics.setColor(1, 1, 1, 1)
            end,

            show = true
        }
	end,

	load = function(self)
		weeks:load()
        if song == 1 then
            stages["clubroom"]:load()

            changeIcons = true
        elseif song == 2 then
            stages["ynm"]:enter()
            stages["ynm"]:load()
            stages["clubroom"]:leave()

            changeIcons = true
            enemyIcon:animate("none")
            showEnemyIcon = false
            boyfriendIcon:animate("protag")
        else
            stages["ynm"]:leave()
            stages["medley"]:enter()
            stages["medley"]:load()

            changeIcons = true
        end

		if song == 1 then
			inst = love.audio.newSource("songs/mc/neet/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/mc/neet/Voices.ogg", "stream")
        elseif song == 2 then
			inst = love.audio.newSource("songs/mc/you and me/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/mc/you and me/Voices.ogg", "stream")

            MonikaCard = love.filesystem.load("sprites/ynm/monika.lua")()
            SayoriCard = love.filesystem.load("sprites/ynm/sayori.lua")()
            NatsukiCard = love.filesystem.load("sprites/ynm/natsuki.lua")()
            YuriCard = love.filesystem.load("sprites/ynm/yuri.lua")()

            NatsukiCard.visible = true
            SayoriCard.visible = true
            MonikaCard.visible = true
            YuriCard.visible = true

            voices_Monika = love.audio.newSource("songs/mc/you and me/Voices_Monika.ogg", "stream")
            voices_Natsuki = love.audio.newSource("songs/mc/you and me/Voices_Natsuki.ogg", "stream")
            voices_Sayori = love.audio.newSource("songs/mc/you and me/Voices_Sayori.ogg", "stream")
            voices_Yuri = love.audio.newSource("songs/mc/you and me/Voices_Yuri.ogg", "stream")

            moni = love.filesystem.load("sprites/characters/monika/monika.lua")()
            natsu = love.filesystem.load("sprites/characters/natsuki/natsuki.lua")()
            sayo = love.filesystem.load("sprites/characters/sayori/sayori.lua")()
            yuri = love.filesystem.load("sprites/characters/yuri/yuri.lua")()

            YuriCard.x = -425
            SayoriCard.x = -140
            NatsukiCard.x = 435
            MonikaCard.x = 150

            moni.x = -300
            moni.y = -160

            sayo.x = -300
            sayo.y = -160

            natsu.x = -300
            natsu.y = -160

            yuri.x = -300
            yuri.y = -160
        else
            inst = love.audio.newSource("songs/mc/takeover medley/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/mc/takeover medley/Voices.ogg", "stream")

            monikap = love.filesystem.load("sprites/characters/pixel/monika.lua")()
            monika = love.filesystem.load("sprites/characters/monika/monika.lua")()
            natsuki = love.filesystem.load("sprites/characters/natsuki/natsuki.lua")()
            sayori = love.filesystem.load("sprites/characters/sayori/sayori.lua")()
            yuri = love.filesystem.load("sprites/characters/yuri/yuri.lua")()
            enemy2 = love.filesystem.load("sprites/characters/yuri/yuricrazy.lua")()
            protag = love.filesystem.load("sprites/characters/mc/mc.lua")()
            girlfriend = love.filesystem.load("sprites/week6/senpai.lua")()
            girlfreindangry = love.filesystem.load("sprites/week6/senpai-angry.lua")()

            monika.x = -400
            monikap.x = -400
            natsuki.x = -400
            sayori.x = -400
            yuri.x = -400
            protag.x = -400

            girlfriend.x = 0
            girlfriend.y = 1000

            enemy = boyfriend
            enemy.alpha = 1
            enemy2.alpha = 0
            boyfriend.alpha = 1
            enemy2.x, enemy2.y = -400, 0
		end

        function prepareCharSwap()
            ddtoCursor = stageImages.cursorHold
            ddtoCursor.x = 100
            ddtoCursor.y = 500

            Timer.tween(beatHandler.calcSectionLength(0.6), ddtoCursor, {x = -180, y = 0}, "out-sine", function()
                ddtoCursor = stageImages.cursor
                ddtoCursor.x = -180
                ddtoCursor.y = 0
                Timer.after(0.85, function()
                    Timer.tween(beatHandler.calcSectionLength(0.6), ddtoCursor, {x = -230, y = -600}, "out-sine")
                end)
            end)
        end

        function creditsCharSwap(char, unhide)
            curEnemy = char

            if char == "monikap" then enemyIcon:animate("monika pixel")
            else enemyIcon:animate(char) end
            if curEnemy == "pmonika" then
                enemy = monikap
            elseif curEnemy == "monika" then
                enemy = monika
            elseif curEnemy == "natsuki" then
                enemy = natsuki
            elseif curEnemy == "sayori" then
                enemy = sayori
            elseif curEnemy == "yuri" then
                enemy = yuri
            elseif curEnemy == "protag" then
                enemy = protag
            end
            enemy.alpha = 1
        end

        enemyIcon:animate("protag")

		self:initUI()

        countNum = 0

        camera:addPoint("center", 0, 350)

        showDokis = false
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 1 then
			weeks:generateNotes("data/mc/neet/neet.json")
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		elseif song == 2 then
			weeks:generateNotes("data/mc/you and me/you and me.json")
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end

            uiAlpha = {0}
            for i = 1, 4 do
                boyfriendArrows[i].alpha = 0
                enemyArrows[i].alpha = 0
            end
        else
            weeks:generateNotes("data/mc/takeover medley/takeover medley.json")

            if storyMode and not died then
                weeks:setupCountdown()
            else
                weeks:setupCountdown()
            end
            numOfChar = 3

            camera.mustHit = false

            uiAlpha = {0}
            for i = 1, 4 do
                boyfriendArrows[i].alpha = 0
                enemyArrows[i].alpha = 0
            end

            funCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
		end

        dokiCardSelection = false
        chooseDoki = true
        showEnemy = false

        choosen = ""
	end,

	update = function(self, dt)
		weeks:update(dt)
        if dokiCardSelection then
            MonikaCard:update(dt)
            SayoriCard:update(dt)
            NatsukiCard:update(dt)
            YuriCard:update(dt)
        end
        if song == 1 then
            stages["clubroom"]:update(dt)
        elseif song == 2 then
            stages["ynm"]:update(dt)
        elseif song == 3 then
            stages["medley"]:update(dt)
        end
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
                if s == 384 and countNum == 0 then
                    girlfriend.alpha = 0
                    stageImages.desks.alpha = 0
                    stageImages.spotlight.alpha = 1
                    love.audio.play(spotlight)
                    camera:moveToPoint(1, "center", false)
                    camera.defaultZoom = 0.75
                    countNum = 1
                elseif s == 512 and countNum == 1 then
                    girlfriend.alpha = 1
                    stageImages.desks.alpha = 1
                    stageImages.spotlight.alpha = 0
                    camera:moveToPoint(1, "enemy", false)
                    camera.defaultZoom = 0.85
                    countNum = 2
                end
			elseif song == 2 then
				if s == 14 and not countingDown then
                    typeWriterText:setText("A few days passed since Boyfriend and Girlfriend's\nlast visit to the club.")
                elseif s == 84 then
                    typeWriterText:setText("The Literature Club returned to its original 5 members.")
                elseif s == 141 then
                    typeWriterText:setText("The days continued as normal, with club meetings\nfilled with stories, sweets, and singing.")
                elseif s == 208 then
                    typeWriterText:setText("Things were going well, especially for a certain someone- ")
                elseif s == 240 and countNum == 0 then
                    Timer.tween(0.5, uiAlpha, {1}, "in-sine")
                    for i = 1, 4 do
                        Timer.tween(0.5, boyfriendArrows[i], {alpha = 1}, "in-sine")
                        Timer.tween(0.5, enemyArrows[i], {alpha = 1}, "in-sine")
                    end
                    weeks:blackBars(true)
                    countNum = 1
                elseif s == 248 and countNum == 1 then
                    camera:moveToPoint(3, "center", false)
                    camera.mustHit = false
                    countNum = 2
                elseif s == 252 and countNum == 2 then
                    Timer.tween(0.5, typeWriterText, {alpha = 0}, "in-sine")
                    countNum = 3
                elseif s == 520 and countNum == 3 then
                    camera.defaultZoom = 1.1
                    countNum = 4
                elseif s == 784 and countNum == 4 then
                    -- doki bg on
                    Timer.tween(beatHandler.calcSectionLength(0.5), scrollingBG, {alpha = 1}, "in-sine", function() camera.defaultZoom = 1.1 end)
                    countNum = 5
                elseif s == 1068 and countNum == 5 then
                    camera.defaultZoom = 0.85
                    -- doki bf off
                    Timer.tween(beatHandler.calcSectionLength(0.5), scrollingBG, {alpha = 0}, "in-sine", function() camera.defaultZoom = 1.1 end)
                    countNum = 6
                elseif s == 1122 and countNum == 6 then
                    weeks:blackBars(false)
                    Timer.tween(5, camera, {y=4250}, "linear")
                    countNum = 7
                    showEnemyIcon = true
                elseif s == 1134 and countNum == 7 then
                    Timer.tween(1, uiAlpha, {0}, "in-sine")
                    for i = 1, 4 do
                        Timer.tween(1, boyfriendArrows[i], {alpha = 0}, "in-sine")
                        Timer.tween(1, enemyArrows[i], {alpha = 0}, "in-sine")
                    end
                    countNum = 8
                elseif s == 1156 and countNum == 8 then
                    dokiCardSelection = true
                    MonikaCard:animate("anim", false)
                    SayoriCard:animate("anim", false)
                    NatsukiCard:animate("anim", false)
                    YuriCard:animate("anim", false)
                    countNum = 9
                elseif s == 1246 and countNum == 9 then
                    Timer.tween(1, uiAlpha, {1}, "in-sine")
                    for i = 1, 4 do
                        Timer.tween(1, boyfriendArrows[i], {alpha = 1}, "in-sine")
                        Timer.tween(1, enemyArrows[i], {alpha = 1}, "in-sine")
                    end
                    countNum = 10
                elseif s == 1252 and countNum == 10 then
                    showEnemy = true
                    weeks:blackBars(true)
                    camera:moveToPoint(3, "center", false)
                    dokiCardSelection = false
                    camera.mustHit = false
                    countNum = 11
                elseif s == 1776 and countNum == 11 then
                    camera.defaultZoom = 1
                    countNum = 12
                elseif s == 1904 and countNum == 12 then
                    -- doki bg on
                    Timer.tween(4, scrollingBG, {alpha = 1}, "in-sine")
                    camera.defaultZoom = 0.9
                    countNum = 13
                elseif s == 2160 and countNum == 13 then
                    weeks:blackBars(false)
                    -- doki bg off
                    Timer.tween(3, scrollingBG, {alpha = 0}, "in-sine")
                    countNum = 14
                elseif s == 2638 and countNum == 14 then
                    Timer.tween(5, camera, {y=4250}, "linear")
                    Timer.tween(2, uiAlpha, {0}, "out-sine")
                    for i = 1, 4 do
                        Timer.tween(2, boyfriendArrows[i], {alpha = 0}, "out-sine")
                        Timer.tween(2, enemyArrows[i], {alpha = 0}, "out-sine")
                    end
                    countNum = 15
                end
            elseif song == 3 then
                -- 66 | 450 | 834 | 1218 | 1606 | 1866, for prepareCharSwap
                if s == 1 and not countingDown and countNum == 0 then
                    -- white flash
                    countNum = 1
                elseif s == 20 and countNum == 1 then
                    -- show song info
                    countNum = 2
                elseif s == 48 and countNum == 2 then
                    Timer.tween(1, stageImages.cg1, {alpha = 0}, "out-sine")
                    Timer.tween(2, camera, {y=0}, "out-sine")
                    countNum = 3
                elseif s == 54 and countNum == 3 then
                    Timer.tween(2, uiAlpha, {1}, "out-sine")
                    for i = 1, 4 do
                        Timer.tween(0.5, boyfriendArrows[i], {alpha = 1}, "in-sine")
                        Timer.tween(0.5, enemyArrows[i], {alpha = 1}, "in-sine")
                    end
                    countNum = 4
                elseif s == 66 and countNum == 4 then
                    prepareCharSwap()
                    countNum = 5
                elseif s == 76 and countNum == 5 then
                    -- swap char
                    creditsCharSwap("pmonika")
                    countNum = 6
                elseif s == 239 and countNum == 6 then
                    -- dear god, senpai is here
                    camera.defaultZoom = 0.65
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.senpai, {y = 75}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.p1, {x = 500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.monika, {x = -500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.p2, {x = -500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.windowTopRight, {x = 500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.windowTopLeft, {x = -500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.windowTopMiddle, {y = 75}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), enemy, {x = -500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), boyfriend, {x = 500}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), girlfriend, {y = 75}, "out-sine")

                    countNum = 7
                elseif s == 336 and countNum == 7 then
                    girlfriend = girlfreindangry
                    girlfriend.y = 75
                    countNum = 8
                elseif s == 440 and countNum == 8 then
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.senpai, {y = 1000}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.p1, {x = 400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.monika, {x = -400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.p2, {x = -400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.windowTopRight, {x = 400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.windowTopLeft, {x = -400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), stageImages.windowBoxes.windowTopMiddle, {y = 1000}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), enemy, {x = -400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), boyfriend, {x = 400}, "out-sine")
                    Timer.tween(beatHandler.calcSectionLength(), girlfriend, {y = 1000}, "out-sine")
                    camera.defaultZoom = 0.85
                    countNum = 9
                elseif s == 450 and countNum == 9 then
                    prepareCharSwap()
                    countNum = 10
                elseif s == 460 and countNum == 10 then
                    -- swap char
                    creditsCharSwap("sayori")
                    countNum = 11
                elseif s == 834 and countNum == 11 then
                    prepareCharSwap()
                    countNum = 12
                elseif s == 844 and countNum == 12 then
                    -- swap char
                    creditsCharSwap("natsuki")
                    countNum = 13
                elseif s == 1218 and countNum == 13 then
                    prepareCharSwap()
                    countNum = 14
                elseif s == 1228 and countNum == 14 then
                    -- swap char
                    creditsCharSwap("yuri")
                    countNum = 15
                elseif s == 1392 and countNum == 15 then
                    -- stupid ass yuri shit
                    FORCEP2NOMATTERWHAT = true
                    Timer.tween(beatHandler.calcSectionLength(5), stageImages.static, {alpha = 0.65}, "out-sine")
                    Timer.tween(5, enemy, {alpha = 0}, "out-sine")
                    Timer.tween(5, enemy2, {alpha = 1}, "out-sine")
                    countNum = 16
                elseif s == 1488 and countNum == 16 then
                    -- end stupid ass yuri shit
                    FORCEP2NOMATTERWHAT = false
                    stageImages.static.alpha = 0
                    enemy.alpha = 1
                    enemy2.alpha = 0
                    countNum = 17 
                elseif s ==  1606 and countNum == 17 then
                    prepareCharSwap()
                    countNum = 18
                elseif s == 1616 and countNum == 18 then
                    -- swap char
                    creditsCharSwap("protag")
                    countNum = 19
                elseif s == 1866 and countNum == 19 then
                    prepareCharSwap()
                    countNum = 20
                elseif s == 1876 and countNum == 20 then
                    -- swap char
                    creditsCharSwap("monika")
                    countNum = 21
                elseif s == 2240 and countNum == 21 then
                    Timer.tween(5, uiAlpha, {0}, "out-sine")
                    for i = 1, 4 do
                        Timer.tween(5, boyfriendArrows[i], {alpha = 1}, "out-sine")
                        Timer.tween(5, enemyArrows[i], {alpha = 1}, "out-sine")
                    end
                    Timer.tween(5, camera, {y = 2000}, "out-sine")

                    countNum = 22
                elseif s == 2264 and countNum == 22 then
                    camera.zooming = false
                    countNum = 23
                elseif s == 2280 and countNum == 23 then
                    Timer.tween(0.5, stageImages.cg2, {alpha = 1}, "out-sine")
                    countNum = 24
                elseif s == 2322 and countNum == 24 then
                    Timer.tween(1, stageImages.cg2, {alpha = 0}, "out-sine")
                    countNum = 25
                elseif s == 2330 and countNum == 25 then
                    Timer.tween(0.5, stageImages.cg1, {alpha = 1}, "out-sine")
                    countNum = 26
                elseif s == 2358 and countNum == 26 then
                    Timer.tween(0.5, stageImages.cg3, {alpha = 1}, "out-sine")
                    countNum = 28
                end
			end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 2 then
                
            elseif song == 1 then
               
            end
        end
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			if storyMode and song < 3 then
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

        if not dokiCardSelection then
		    weeks:updateUI(dt)
        elseif dokiCardSelection and chooseDoki then
            if input:pressed("gameLeft") then
                -- Yuri
                choosen = "yuri"
                weeks:generateNotes("data/mc/you and me/you and me-yuri.json")
                Timer.tween(1, SayoriCard, {y = 600})
                Timer.tween(1, NatsukiCard, {y = 600})
                Timer.tween(1, MonikaCard, {y = 600})
                Timer.after(0.05, function()
                    YuriCard.visible = false
                    Timer.after(0.1, function()
                        YuriCard.visible = true
                        Timer.after(0.1, function()
                            YuriCard.visible = false
                            Timer.after(0.1, function()
                                YuriCard.visible = true
                                Timer.after(0.1, function()
                                    YuriCard.visible = false
                                    Timer.after(0.1, function()
                                        YuriCard.visible = true
                                        Timer.after(0.1, function()
                                            YuriCard.visible = false
                                            Timer.after(0.1, function()
                                                YuriCard.visible = true
                                                Timer.after(0.1, function()
                                                    YuriCard.visible = false
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end)
                end)
                voices_Yuri:play()
                voices_Yuri:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = yuri
                enemyIcon:animate("yuri winning")
            elseif input:pressed("gameDown") then
                -- Sayori
                choosen = "sayori"
                weeks:generateNotes("data/mc/you and me/you and me-sayori.json")
                Timer.tween(1, YuriCard, {y = 600})
                Timer.tween(1, NatsukiCard, {y = 600})
                Timer.tween(1, MonikaCard, {y = 600})
                Timer.after(0.05, function()
                    SayoriCard.visible = false
                    Timer.after(0.1, function()
                        SayoriCard.visible = true
                        Timer.after(0.1, function()
                            SayoriCard.visible = false
                            Timer.after(0.1, function()
                                SayoriCard.visible = true
                                Timer.after(0.1, function()
                                    SayoriCard.visible = false
                                    Timer.after(0.1, function()
                                        SayoriCard.visible = true
                                        Timer.after(0.1, function()
                                            SayoriCard.visible = false
                                            Timer.after(0.1, function()
                                                SayoriCard.visible = true
                                                Timer.after(0.1, function()
                                                    SayoriCard.visible = false
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end)
                end)
                voices_Sayori:play()
                voices_Sayori:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = sayo
                enemyIcon:animate("sayori winning")
            elseif input:pressed("gameRight") then
                -- Natsuki
                choosen = "natsuki"
                weeks:generateNotes("data/mc/you and me/you and me-natsuki.json")
                Timer.tween(1, SayoriCard, {y = 600})
                Timer.tween(1, MonikaCard, {y = 600})
                Timer.tween(1, YuriCard, {y = 600})
                Timer.after(0.1, function()
                    NatsukiCard.visible = false
                    Timer.after(0.1, function()
                        NatsukiCard.visible = true
                        Timer.after(0.1, function()
                            NatsukiCard.visible = false
                            Timer.after(0.1, function()
                                NatsukiCard.visible = true
                                Timer.after(0.1, function()
                                    NatsukiCard.visible = false
                                    Timer.after(0.1, function()
                                        NatsukiCard.visible = true
                                        Timer.after(0.1, function()
                                            NatsukiCard.visible = false
                                            Timer.after(0.1, function()
                                                NatsukiCard.visible = true
                                                Timer.after(0.1, function()
                                                    NatsukiCard.visible = false
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end)
                end)
                voices_Natsuki:play()
                voices_Natsuki:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = natsu
                enemyIcon:animate("natsuki winning")
            elseif input:pressed("gameUp") then
                -- Monika
                choosen = "monika"
                weeks:generateNotes("data/mc/you and me/you and me-monika.json")
                Timer.tween(1, SayoriCard, {y = 600})
                Timer.tween(1, NatsukiCard, {y = 600})
                Timer.tween(1, YuriCard, {y = 600})
                Timer.after(0.1, function()
                    MonikaCard.visible = false
                    Timer.after(0.1, function()
                        MonikaCard.visible = true
                        Timer.after(0.1, function()
                            MonikaCard.visible = false
                            Timer.after(0.1, function()
                                MonikaCard.visible = true
                                Timer.after(0.1, function()
                                    MonikaCard.visible = false
                                    Timer.after(0.1, function()
                                        MonikaCard.visible = true
                                        Timer.after(0.1, function()
                                            MonikaCard.visible = false
                                            Timer.after(0.1, function()
                                                MonikaCard.visible = true
                                                Timer.after(0.1, function()
                                                    MonikaCard.visible = false
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            end)
                        end)
                    end)
                end)
                voices_Monika:play()
                voices_Monika:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = moni
                enemyIcon:animate("monika winning")
            end
        end

        typeWriterText:update(dt)

        if health > 0.325 and health < 1.595 then
            if enemyIcon:getAnimName() == "protag losing" or enemyIcon:getAnimName() == "protag winning" then
                enemyIcon:animate("protag")
            elseif enemyIcon:getAnimName() == "yuri losing" or enemyIcon:getAnimName() == "yuri winning" then
                enemyIcon:animate("yuri")
            elseif enemyIcon:getAnimName() == "sayori losing" or enemyIcon:getAnimName() == "sayori winning" then
                enemyIcon:animate("sayori")
            elseif enemyIcon:getAnimName() == "natsuki losing" or enemyIcon:getAnimName() == "natsuki winning" then
                enemyIcon:animate("natsuki")
            elseif enemyIcon:getAnimName() == "monika losing" or enemyIcon:getAnimName() == "monika winning" then
                enemyIcon:animate("monika")
            elseif enemyIcon:getAnimName() == "monika pixel losing" or enemyIcon:getAnimName() == "monika pixel winning" then
                enemyIcon:animate("monika pixel")
            end
        elseif health < 0.325 then
            if enemyIcon:getAnimName() == "protag" then
                enemyIcon:animate("protag winning")
            elseif enemyIcon:getAnimName() == "yuri" then
                enemyIcon:animate("yuri winning")
            elseif enemyIcon:getAnimName() == "sayori" then
                enemyIcon:animate("sayori winning")
            elseif enemyIcon:getAnimName() == "natsuki" then
                enemyIcon:animate("natsuki winning")
            elseif enemyIcon:getAnimName() == "monika" then
                enemyIcon:animate("monika winning")
            elseif enemyIcon:getAnimName() == "monika pixel" then
                enemyIcon:animate("monika pixel winning")
            end
        elseif health > 1.595 then
            if enemyIcon:getAnimName() == "protag" then
                enemyIcon:animate("protag losing")
            elseif enemyIcon:getAnimName() == "yuri" then
                enemyIcon:animate("yuri losing")
            elseif enemyIcon:getAnimName() == "sayori" then
                enemyIcon:animate("sayori losing")
            elseif enemyIcon:getAnimName() == "natsuki" then
                enemyIcon:animate("natsuki losing")
            elseif enemyIcon:getAnimName() == "monika" then
                enemyIcon:animate("monika losing")
            elseif enemyIcon:getAnimName() == "monika pixel" then
                enemyIcon:animate("monika pixel losing")
            end
        end
	end,

	draw = function(self)
		love.graphics.push()
            if song == 3 then
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

                love.graphics.push()
                    love.graphics.setShader(fisheye)
                    love.graphics.draw(funCanvas, 0, 0, 0, 1, 1)
                    love.graphics.setShader()
                love.graphics.pop()
            end
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)

            if song == 1 then
                stages["clubroom"]:draw()
            elseif song == 2 then
                love.graphics.push()
                    stageImages.scanlines:udraw(1.25, 1.25)
                love.graphics.pop()
                love.graphics.push()
                    love.graphics.translate(camera.x * 0.1, camera.y * 0.1)
                    love.graphics.translate(camera.ex * 0.1, camera.ey * 0.1)
                    stageImages.gradient:udraw(1.25,1.25)
                love.graphics.pop()
                stages["ynm"]:draw()
            else
                stages["medley"]:draw()
            end
		love.graphics.pop()

        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)

            if dokiCardSelection then
                if MonikaCard.visible then
                    MonikaCard:draw()
                end
                if SayoriCard.visible then
                    SayoriCard:draw()
                end
                if NatsukiCard.visible then
                    NatsukiCard:draw()
                end
                if YuriCard.visible then
                    YuriCard:draw()
                end
            end
        love.graphics.pop()

		if inCutscene then 
			dialogue.draw()
		else
			weeks:drawUI()
		end
        typeWriterText:draw(100, graphics.getHeight()/2-100)
	end,

	leave = function(self)
		graphics.clearCache()
        changeIcons = true
		weeks:leave()
	end
}
