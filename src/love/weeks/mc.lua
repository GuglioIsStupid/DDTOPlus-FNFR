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
        stages["clubroom"]:enter("mc")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("senpai", false)

        spotlight = love.audio.newSource("sounds/spotlight.ogg", "static")

		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
        if song == 1 then
            stages["clubroom"]:load()
        else
            stages["ynm"]:enter()
            stages["ynm"]:load()
            stages["clubroom"]:leave()
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

		self:initUI()

        countNum = 4

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
				if s == 240 and countNum == 0 then
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
                elseif s == 520 and countNum == 2 then
                    camera.defaultZoom = 1.1
                    countNum = 3
                elseif s == 1068 and countNum == 3 then
                    camera.defaultZoom = 0.85
                    countNum = 4
                elseif s == 1122 and countNum == 4 then
                    weeks:blackBars(false)
                    Timer.tween(5, camera, {y=4250}, "linear")
                    countNum = 5
                elseif s == 1134 and countNum == 5 then
                    Timer.tween(1, uiAlpha, {0}, "in-sine")
                    for i = 1, 4 do
                        Timer.tween(1, boyfriendArrows[i], {alpha = 0}, "in-sine")
                        Timer.tween(1, enemyArrows[i], {alpha = 0}, "in-sine")
                    end
                    countNum = 6
                elseif s == 1156 and countNum == 6 then
                    dokiCardSelection = true
                    MonikaCard:animate("anim", false)
                    SayoriCard:animate("anim", false)
                    NatsukiCard:animate("anim", false)
                    YuriCard:animate("anim", false)
                    countNum = 7
                elseif s == 1246 and countNum == 7 then
                    Timer.tween(1, uiAlpha, {1}, "in-sine")
                    for i = 1, 4 do
                        Timer.tween(1, boyfriendArrows[i], {alpha = 1}, "in-sine")
                        Timer.tween(1, enemyArrows[i], {alpha = 1}, "in-sine")
                    end
                    countNum = 8
                elseif s == 1252 and countNum == 8 then
                    showEnemy = true
                    weeks:blackBars(true)
                    camera:moveToPoint(3, "center", false)
                    dokiCardSelection = false
                    camera.mustHit = false
                    countNum = 9
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
                                        end
                                        )
                                    end)
                                end)
                            end)
                        end
                        )
                    end)
                end)
                voices_Yuri:play()
                voices_Yuri:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = yuri
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
                                        end
                                        )
                                    end)
                                end)
                            end)
                        end
                        )
                    end)
                end)
                voices_Sayori:play()
                voices_Sayori:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = sayo
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
                                        end
                                        )
                                    end)
                                end)
                            end)
                        end
                        )
                    end)
                end)
                voices_Natsuki:play()
                voices_Natsuki:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = natsu
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
                                        end
                                        )
                                    end)
                                end)
                            end)
                        end
                        )
                    end)
                end)
                voices_Monika:play()
                voices_Monika:seek(voices:tell("seconds"))
                chooseDoki = false
                enemy = moni
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
	end,

	leave = function(self)
		graphics.clearCache()

		weeks:leave()
	end
}
