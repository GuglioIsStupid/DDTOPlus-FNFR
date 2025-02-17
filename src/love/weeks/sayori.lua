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

local songList = {
	"Rain Clouds",
	"My Confession"
}

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()
        stages["clubroom"]:enter("sayori")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("sayori", false)

		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
        stages["clubroom"]:load()

		if song == 2 then
			inst = love.audio.newSource("songs/sayori/my confession/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/sayori/my confession/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("songs/sayori/rain clouds/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/sayori/rain clouds/Voices.ogg", "stream")
		end

		self:initUI()

        countNum = 0
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 2 then
			weeks:generateNotes("data/songs/my confession/my confession.json")
			if storyMode and not died then
				weeks:setupCountdown()
			else
				weeks:setupCountdown()
			end
		else
			weeks:generateNotes("data/songs/rain clouds/rain clouds.json")
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
				if s == 480 and countNum == 0 then
                    camera.zooming = false
                    --camera.x, camera.y = girlfriend.x, girlfriend.y - 185
                    Timer.tween(beatHandler.calcSectionLength(0.2), camera, {x = girlfriend.x, y = girlfriend.y - 185})
                    -- one
                    audio.playSound(sounds.countdown.three)
                    girlfriend:animate("three")
                    camTimer = Timer.tween(beatHandler.calcSectionLength(0.2), camera, {zoom = 1})
                    countNum = 1
                elseif s == 484 and countNum == 1 then 
                    -- two
                    audio.playSound(sounds.countdown.two)
                    girlfriend:animate("two")
                    camTimer = Timer.tween(beatHandler.calcSectionLength(0.2), camera, {zoom = 1.2})
                    countNum = 2
                elseif s == 488 and countNum == 2 then 
                    -- three
                    audio.playSound(sounds.countdown.one)
                    girlfriend:animate("one")
                    camTimer = Timer.tween(beatHandler.calcSectionLength(0.2), camera, {zoom = 1.4})
                    countNum = 3
                elseif s == 492 and countNum == 3 then 
                    -- go
                    audio.playSound(sounds.countdown.go)
                    girlfriend:animate("go")
                    camera.zooming = true
                    countNum = 4
                elseif s == 496 then
                    girlfriend.danced = false
                    girlfriend:animate("danceLeft")
                elseif s == 749 and countNum == 4 then
                    if SaveData.costumes.sayori == "grace" then
                        enemy:animate("nara")
                    end
                    countNum = 5
                elseif s == 752 and countNum == 5 then
                    if costumes.sayori ~= "grace" then
                        enemy:animate("nara")
                    end
                    stageImages.vignette.visible = true
                    stageImages.staticshock.alpha = 0.45
                    stageImages.staticshock.visible = true
                    camera.zooming = false
                    camTimer = Timer.tween(beatHandler.calcSectionLength(0.1), camera, {zoom = 2})
                    camera.y = camera.y + 35
                    countNum = 6
                elseif s == 768 then
                    camera.zoom = 0.85
                    stageImages.vignette.visible = false
                    stageImages.staticshock.visible = false
                elseif s == 774 then
                    camera.zooming = true
                end
			end
		end
        if beatHandler.onBeat() then
            local b = beatHandler.curBeat
            if song == 2 then

            elseif song == 1 then
                if b == 0 then
                    girlfriend.danceSpeed = not girlfriend.danceIdle and 4 or 2
                elseif b == 1 then
                    girlfriend.danceSpeed = not girlfriend.danceIdle and 2 or 1
                end
            end
        end
		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			if storyMode and song < 2 then
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
                                SaveData.songs.beatSayori = true
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

		if health >= 1.595 then
			if enemyIcon:getAnimName() == "sayori" then
				enemyIcon:animate("sayori losing")
			end
		elseif health < 0.325 then
			if enemyIcon:getAnimName() == "sayori" then
				enemyIcon:animate("sayori winning")
			end
		else
			if enemyIcon:getAnimName() == "sayori losing" or enemyIcon:getAnimName() == "sayori winning" then
				enemyIcon:animate("sayori")
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
            if stageImages.staticshock.visible then
                graphics.setColor(1,1,1,stageImages.staticshock.alpha)
                stageImages.staticshock:draw()
                graphics.setColor(1,1,1,1)
            end
            if stageImages.vignette.visible then
                graphics.setColor(1,1,1,stageImages.vignette.alpha)
                stageImages.vignette:draw()
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
