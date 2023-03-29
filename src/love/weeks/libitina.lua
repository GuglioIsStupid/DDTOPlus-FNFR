function love.math.randomFloat(min, max)
    return love.math.random() * (max - min) + min
end
return {
    enter = function (self, from, songNum, songAppend)
        love.graphics.setDefaultFilter("nearest")
		weeks:enter()
        stages["libitina"]:enter()

        song = songNum

        self:load()
    end,

    load = function (self)
        weeks:load()
        stages["libitina"]:load()

        inst = love.audio.newSource("songs/extra/libitina/Inst.ogg", "stream")
        voices = love.audio.newSource("songs/extra/libitina/Voices.ogg", "stream")

        camera:addPoint("enemy", 227, 98)
        camera:addPoint("boyfriend", 95, -40)

        camera:moveToPoint(1, "boyfriend")

        self:initUI()

        countNum = 0
        camera.defaultZoom = 0.9
    end,

    initUI = function (self)
        weeks:initUI()

        weeks:generateNotes("data/extra/libitina/libitina.json")

        if storyMode and not died then
            weeks:setupCountdown()
        else
            weeks:setupCountdown()
        end
        numOfChar = 3
    end,

    update = function (self, dt)
        weeks:update(dt)
        stages["libitina"]:update(dt)

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

        if beatHandler.onStep() then
            local s = beatHandler.curStep
        end

        weeks:updateUI(dt)
    end,

    draw = function (self)
        love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)
            stages["libitina"]:draw()
        love.graphics.pop()

        if inCutscene then 
            dialogue.draw()
        else
            weeks:drawUI()
        end
    end,

    leave = function (self)
        weeks:leave()
        stages["libitina"]:leave()
        graphics.clearCache()
        love.graphics.setDefaultFilter("linear")
    end
}