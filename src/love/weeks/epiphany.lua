local hasLyrics
function love.math.randomFloat(min, max)
    return love.math.random() * (max - min) + min
end
return {
    enter = function (self, from, songNum, songAppend)
		weeks:enter()
        stages["epiphany"]:enter(2)

        song = songNum
        difficulty = songAppend

        self:load()

        gameFade = {
            alpha = 0,
        }
    end,

    load = function (self)
        weeks:load()
        stages["epiphany"]:load()

        if difficulty == "-hard" then
            inst = love.audio.newSource("songs/extra/epiphany/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/extra/epiphany/Voices.ogg", "stream")
        else
            inst = love.audio.newSource("songs/extra/epiphany/Inst.ogg", "stream")
            voices = love.audio.newSource("songs/extra/epiphany/Voices_Lyrics.ogg", "stream")
        end

        camera:addPoint("enemy", 227, 98)
        camera:addPoint("boyfriend", 95, -40)

        camera:moveToPoint(1, "boyfriend")

        self:initUI()

        countNum = 0
        camera.defaultZoom = 1
    end,

    initUI = function (self)
        weeks:initUI()
        print(difficulty)
        if difficulty == "-hard" then
            weeks:generateNotes("data/extra/epiphany/epiphany.json")
            hasLyrics = false
        else
            weeks:generateNotes("data/extra/epiphany/epiphany-hard.json")
            hasLyrics = true
            lyrics.set("data/extra/epiphany/lyrics.txt")
            print("lyrics")
        end 

        if storyMode and not died then
            weeks:setupCountdown()
        else
            weeks:setupCountdown()
        end
        numOfChar = 3
        camera.mustHit = false
        useUIAlphaForNotes = false
    end,

    update = function (self, dt)
        weeks:update(dt)
        stages["epiphany"]:update(dt)

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

        if beatHandler.curStep >= 32 and hasLyrics then
            lyrics.dolyrics(dt)
        end

        if beatHandler.onBeat() then
            local s = beatHandler.curBeat

            if s == 4 and countNum == 0 then
                camera.zooming = false
                Timer.tween(beatHandler.calcSectionLength(), camera, {zoom = 0.94}, "out-sine", function() camera.defaultZoom = 0.9 ; camera.zooming = true end)
                countNum = 1
            elseif s == 72 and countNum == 1 then
                camera.zooming = false
                Timer.tween(beatHandler.calcSectionLength(), camera, {zoom = 0.8}, "out-sine", function() camera.defaultZoom = 0.8 ; camera.zooming = true end)
                countNum = 2
            elseif s == 580 and countNum == 2 then
                camera.zooming = false
                Timer.tween(beatHandler.calcSectionLength(), camera, {zoom = 1}, "out-sine", function() camera.defaultZoom = 1.1 ; camera.zooming = true end)
                countNum = 3
            elseif s == 585 and countNum == 3 then
                Timer.tween(beatHandler.calcSectionLength(), stageImages.scrollingBG, {alpha = 1}, "in-sine")
                countNum = 4
            elseif s == 648 and countNum == 4 then
                camera.zooming = false
                Timer.tween(beatHandler.calcSectionLength(), camera, {zoom = 0.9}, "out-sine", function() camera.defaultZoom = 0.9 ; camera.zooming = true end)
                Timer.tween(beatHandler.calcSectionLength(), stageImages.scrollingBG, {alpha = 0}, "out-sine")
                stageImages.popout.alpha = 1
                stageImages.popout:animate('anim', false)
                countNum = 5
            elseif s == 776 and countNum == 5 then
                enemy:animate("lastNOTE_start")
                countNum = 6
            elseif s == 784 and countNum == 6 then
                --[[
                    if saveData.songs.epiphany then
                        enemy:animate("lastNOTE_retry")
                    else
                        enemy:animate("lastNOTE_end")
                    end
                ]]
                enemy:animate("lastNOTE_end")
                countNum = 7
            elseif s == 785 and countNum == 7 then
                --saveData.songs.epiphany = true
                countNum = 8
            elseif s == 788 and countNum == 8 then
                -- fade shit
                for i = 1, 4 do
                    Timer.tween(beatHandler.calcSectionLength(0.25), enemyArrows[i], {alpha = 0})
                end
                countNum = 9
            elseif s == 790 and countNum == 9 then
                -- more fade shit
                Timer.tween(0.7, gameFade, {alpha=1})
            end
        end

        weeks:updateUI(dt)
    end,

    draw = function (self)
        love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)
            love.graphics.scale(1, 1)
            stages["epiphany"]:draw()
            love.graphics.scale(1/0.9, 1/0.9)
        love.graphics.pop()

        if inCutscene then 
            dialogue.draw()
        else
            weeks:drawUI()
        end

        if beatHandler.curStep >= 32 and hasLyrics then
            love.graphics.setColor(1,1,1,1)
            lyrics.draw()
        end
        print(beatHandler.curStep, hasLyrics)

        love.graphics.setColor(0, 0, 0, gameFade.alpha)
        love.graphics.rectangle("fill", -1000, -1000, 3000, 3000)
        love.graphics.setColor(1,1,1)
    end,

    leave = function (self)
        weeks:leave()
        stages["epiphany"]:leave()
        graphics.clearCache()
    end
}