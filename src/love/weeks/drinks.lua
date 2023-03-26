return {
    enter = function (self, from, songNum, songAppend)
        love.graphics.setDefaultFilter("nearest")
		weeks:enter("pixel")
        stages["drinks"]:enter()

        song = songNum
    end,

    load = function (self)
        weeks:load()
        stages["drinks"]:load()

        inst = love.audio.newSource("songs/extra/drinks on me/Inst.ogg", "stream")
        voices = love.audio.newSource("songs/extra/drinks on me/Voices.ogg", "stream")
    end,

    initUI = function (self)
        weeks:initUI("pixel")

        weeks:generateNotes("data/extra/drinks on me/drinks on me.json")

        if storyMode and not died then
            weeks:setupCountdown()
        else
            weeks:setupCountdown()
        end
    end,

    update = function (self, dt)
        weeks:update(dt)
        stages["drinks"]:update(dt)
    end,

    draw = function (self)
        love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)
            stages["drinks"]:draw()
        love.graphics.pop()

        if inCutscene then 
            dialogue.draw()
        else
            weeks:drawUI()
        end
    end,

    leave = function (self)
        weeks:leave()
        stages["drinks"]:leave()
        graphics.clearCache()
        love.graphics.setDefaultFilter("linear")
    end
}