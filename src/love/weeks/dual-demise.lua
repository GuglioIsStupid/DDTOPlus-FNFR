return {
    enter = function (self, from, songNum, songAppend)
        love.graphics.setDefaultFilter("nearest")
		weeks:enter("pixel")
        stages["bigroom"]:enter(2)

        song = songNum

        self:load()
    end,

    load = function (self)
        weeks:load()
        stages["bigroom"]:load()

        inst = love.audio.newSource("songs/extra/dual demise/Inst.ogg", "stream")
        voices = love.audio.newSource("songs/extra/dual demise/Voices.ogg", "stream")

        camera:addPoint("enemy", 227, 98)
        camera:addPoint("boyfriend", 95, -40)

        camera:moveToPoint(1, "boyfriend")

        self:initUI()

        countNum = 0
        camera.defaultZoom = 0.9
    end,

    initUI = function (self)
        weeks:initUI("pixel")

        weeks:generateNotes("data/songs/dual demise/dual demise.json")

        if storyMode and not died then
            weeks:setupCountdown()
        else
            weeks:setupCountdown()
        end
        numOfChar = 3
    end,

    update = function (self, dt)
        weeks:update(dt)
        stages["bigroom"]:update(dt)

        if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) and not paused and not inCutscene then
			status.setLoading(true)

			graphics:fadeOutWipe(
				0.7,
				function()
                    highscore:save("Dual Demise", score, mirrorMode)
					if storyMode then
                        Gamestate.switch(menuWeek)
                    else
                        Gamestate.switch(menuFreeplay)
                    end

					status.setLoading(false)
				end
			)
		end

        if beatHandler.onStep() then
            local s = beatHandler.curStep
        end

        weeks:updateUI(dt)
    end,

    draw = function (self)
        love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)
            stages["bigroom"]:draw()
        love.graphics.pop()

        if inCutscene then 
            dialogue.draw()
        else
            weeks:drawUI()
        end
    end,

    leave = function (self)
        weeks:leave()
        stages["bigroom"]:leave()
        graphics.clearCache()
        love.graphics.setDefaultFilter("linear")
    end
}