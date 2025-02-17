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
        stages["clubroom"]:enter("monika")

		song = songNum
		difficulty = songAppend

		camera.defaultZoom = 0.85

		enemyIcon:animate("monika", false)

		self:load()

		musicPos = 0
	end,

	load = function(self)
		weeks:load()
        stages["clubroom"]:load()

		inst = love.audio.newSource("songs/monika/reconciliation/Inst.ogg", "stream")
		voices = love.audio.newSource("songs/monika/reconciliation/Voices.ogg", "stream")

		self:initUI()

        countNum = 0
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes("data/songs/reconciliation/reconciliation.json")
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

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			status.setLoading(true)

			graphics:fadeOutWipe(
				0.7,
				function()
					highscore:save("Reconciliation", score, mirrorMode)
					if storyMode then
						Gamestate.switch(menuWeek)
						if not leftSong then
							SaveData.songs.beatMonika = true
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

		weeks:leave()
	end
}
