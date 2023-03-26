function love.math.randomFloat(min, max)
    return love.math.random() * (max - min) + min
end
return {
    enter = function (self, from, songNum, songAppend)
        love.graphics.setDefaultFilter("nearest")
		weeks:enter("pixel")
        stages["drinks"]:enter()

        cg1 = graphics.newImage(graphics.imagePath("va11halla/intro1"))
        cg2 = graphics.newImage(graphics.imagePath("va11halla/intro2"))
        cg1.alpha = 0
        cg2.alpha = 0

        niconicotxt = {}
        for line in love.filesystem.lines("data/nicoText.txt") do
            table.insert(niconicotxt, line)
        end
        texts = {}

        love.graphics.setDefaultFilter("nearest", "nearest")
        CyberpunkWaifus  = love.graphics.newFont("fonts/CyberpunkWaifus.ttf", 50)
        love.graphics.setDefaultFilter("linear")

        function doEncore(v)
            if v == 4 then
                if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 then
                    niconicoLights()
                end
            end
        end

        function niconicoLights()
            local randomText = love.math.random(1, #niconicotxt)
            local txtSpr = {
                txt = niconicotxt[randomText],
                x = graphics.getWidth() + 250,
                y = love.math.random(0, 650)
            }
            Timer.tween(love.math.randomFloat(4, 12), txtSpr, {x = -2000}, "linear")
            table.insert(texts, txtSpr)
        end

        song = songNum

        self:load()
    end,

    load = function (self)
        weeks:load()
        stages["drinks"]:load()

        inst = love.audio.newSource("songs/extra/drinks on me/Inst.ogg", "stream")
        voices = love.audio.newSource("songs/extra/drinks on me/Voices.ogg", "stream")

        camera:addPoint("enemy", 227, 98)
        camera:addPoint("boyfriend", 95, -40)

        camera:moveToPoint(1, "boyfriend")

        self:initUI()

        countNum = 0
        camera.defaultZoom = 0.9
        whiteFlash = {
            alpha = 0
        }
        encoreTime = 0
        camera.zooming = false
        blackscreen = {
            alpha = 1
        }
    end,

    initUI = function (self)
        weeks:initUI("pixel")

        weeks:generateNotes("data/extra/drinks on me/drinks on me.json")

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
        useUIAlphaForNotes = false
    end,

    update = function (self, dt)
        weeks:update(dt)
        stages["drinks"]:update(dt)

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

        doEncore(encoreTime)

        if beatHandler.onStep() then
            local s = beatHandler.curStep

            if s == 2 and countNum == 0 then
                -- cg1
                Timer.tween(2.5, cg1, {alpha = 1}, "in-sine")
                countNum = 1
                print(1)
            elseif s == 50 and countNum == 1 then
                -- cg2
                Timer.tween(1.2, cg1, {alpha = 0}, "in-sine")
                countNum = 2
                print(2)
            elseif s == 62 and countNum == 2 then
                -- cg3
                Timer.tween(2.5, cg2, {alpha = 1}, "in-sine")
                countNum = 3
                print(3)
            elseif s == 100 and countNum == 3 then
                -- ui stuff reappears
                countNum = 4
                print(4)
                camera.zooming = true
            elseif s == 111 and countNum == 4 then
                -- fade in notes
                Timer.tween(1.2, blackscreen, {alpha = 0}, "in-sine")
                Timer.tween(1.2, cg2, {alpha = 0}, "in-sine")
                uiAlpha = {1}
                for i = 1, 4 do
                    --boyfriendArrows[i].alpha = 0
                    --enemyArrows[i].alpha = 0
                    Timer.tween(0.6 + (0.2 * i), boyfriendArrows[i], {alpha = 1}, "out-circ")
                    Timer.tween(0.6 + (0.2 * i), enemyArrows[i], {alpha = 1}, "out-circ")
                end
                countNum = 5
                print(5)
            elseif s == 160 and countNum == 5 then
                -- metadata fades out
                countNum = 6
                print(6)
            elseif s == 512 and countNum == 6 then
                -- flash
                stageImages.dana.visible = true
                countNum = 7
                camera.defaultZoom = 1
                whiteFlash.alpha = 1
                Timer.tween(beatHandler.calcSectionLength(0.2), whiteFlash, {alpha = 0}, "out-sine")
                print(7)
            elseif s == 752 and countNum == 7 then
                camera.defaultZoom = 1.4
                countNum = 8
                print(8)
            elseif s == 768 and countNum == 8 then
                -- no way,,,,, another flash!!!! 
                stageImages.dorth.visible = true
                stageImages.alma.visible = true
                camera.defaultZoom = 0.9
                countNum = 9
                whiteFlash.alpha = 1
                Timer.tween(beatHandler.calcSectionLength(0.2), whiteFlash, {alpha = 0}, "out-sine")
                print(9)
            elseif s == 1008 and countNum == 9 then
                print("What the fuck")
                -- awwww now they're singing together <3
                if not settings.middleScroll then
                    for i = 1, 4 do
                        Timer.tween(1.5, boyfriendArrows[i], {x = -410 + 165 * i}, "out-sine")
                        Timer.tween(1.5, enemyArrows[i], {x = -410 + 165 * i, alpha = 0}, "out-sine")
                    end
                end
                countNum = 10
                print(10)
            elseif s == 1020 and countNum == 10 then
                encoreTime = 4
                countNum = 11
                print(11)
            elseif s == 1144 and countNum == 11 then
                -- they're not singing together anymore </3
                if not settings.middleScroll then
                    for i = 1, 4 do
                        Timer.tween(1.5, boyfriendArrows[i], {x = 100 + 165 * i}, "out-sine")
                        Timer.tween(1.5, enemyArrows[i], {x = -925 + 165 * i, alpha = 1}, "out-sine")
                    end
                end
                countNum = 12
                print(12)
            elseif s == 1276 and countNum == 12 then
                encoreTime = 0
                countNum = 13
                print(13)
            elseif s == 1280 and countNum == 13 then
                -- Another flash damn
                stageImages.dana.visible = false
                stageImages.dorth.visible = false
                stageImages.alma.visible = false
                countNum = 14

                whiteFlash.alpha = 1
                Timer.tween(beatHandler.calcSectionLength(0.2), whiteFlash, {alpha = 0}, "out-sine")

                print(14)
            elseif s == 1412 and countNum == 14 then
                -- anaThingy = static or smth idfk
                stageImages.anna:animate("static", false)
                countNum = 15
                print(15)
            end
        end

        weeks:updateUI(dt)

        --[[
        if input:pressed("left") then
            if not settings.middleScroll then
                for i = 1, 4 do
                    Timer.tween(1.5, boyfriendArrows[i], {x = 100 + 165 * i}, "out-sine")
                    Timer.tween(1.5, enemyArrows[i], {x = -925 + 165 * i, alpha = 1}, "out-sine")
                end
            end
        elseif input:pressed("right") then
            if not settings.middleScroll then
                for i = 1, 4 do
                    Timer.tween(1.5, boyfriendArrows[i], {x = -410 + 165 * i}, "out-sine")
                    Timer.tween(1.5, enemyArrows[i], {x = -410 + 165 * i, alpha = 0}, "out-sine")
                end
            end
        end
        --]]
    end,

    draw = function (self)
        love.graphics.push()
			love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
			love.graphics.scale(camera.zoom, camera.zoom)
            stages["drinks"]:draw()
            love.graphics.setColor(0,0,0,blackscreen.alpha)
            love.graphics.rectangle("fill", -graphics.getWidth()/2, -graphics.getHeight()/2, graphics.getWidth(), graphics.getHeight())
        love.graphics.pop()
        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
            love.graphics.setColor(1,1,1,cg1.alpha)
            cg1:draw()
            love.graphics.setColor(1,1,1,cg2.alpha)
            cg2:draw()
            love.graphics.setColor(1,1,1)
        love.graphics.pop()

        if inCutscene then 
            dialogue.draw()
        else
            weeks:drawUI()
        end

        if whiteFlash.alpha > 0 then
            love.graphics.setColor(1, 1, 1, whiteFlash.alpha)
            love.graphics.rectangle("fill", 0, 0, graphics.getWidth(), graphics.getHeight())
            love.graphics.setColor(1, 1, 1, 1)
        end

        for i = 1, #texts do
            love.graphics.setColor(1, 1, 1)
            love.graphics.setFont(CyberpunkWaifus)
            love.graphics.print(texts[i].txt, texts[i].x, texts[i].y)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setFont(font)
        end
    end,

    leave = function (self)
        weeks:leave()
        stages["drinks"]:leave()
        graphics.clearCache()
        love.graphics.setDefaultFilter("linear")
    end
}