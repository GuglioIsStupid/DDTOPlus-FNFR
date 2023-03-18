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
        else
            stages["ynm"]:enter()
            stages["ynm"]:load()
            stages["clubroom"]:leave()

            changeIcons = true
            enemyIcon:animate("none")
            showEnemyIcon = false
            boyfriendIcon:animate("protag")
        end

		if song == 1 then
			inst = love.audio.newSource("songs/mc/neet/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/mc/neet/Voices.ogg", "stream")
		else
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
		else
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
        else
            stages["ynm"]:update(dt)
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
			end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 2 then
                
            elseif song == 1 then
               
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
            end
        elseif health < 0.325 then
            if enemyIcon:getAnimName() == "protag" then
                enemyIcon:animate("protag winning")
            end
        elseif health > 1.595 then
            if enemyIcon:getAnimName() == "protag" then
                enemyIcon:animate("protag losing")
            end
        end
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)

            if song == 1 then
                stages["clubroom"]:draw()
            else
                stages["ynm"]:draw()
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
