return {
    enter = function(self, enemyChar)
        stageImages = {
            closet = graphics.newImage(graphics.imagePath("festival/FarBack")),
            clubroom = graphics.newImage(graphics.imagePath("festival/MainBG")),
            desks = graphics.newImage(graphics.imagePath("festival/DesksFestival")),
            dokis = {
                sayori = love.filesystem.load("sprites/clubroom/sayori.lua")(),
                natsuki = love.filesystem.load("sprites/clubroom/natsuki.lua")(),
                yuri = love.filesystem.load("sprites/clubroom/yuri.lua")(),
                monika = love.filesystem.load("sprites/clubroom/monika.lua")()
            },
            vignette = graphics.newImage(graphics.imagePath("clubroom/vignette")),
            banner = graphics.newImage(graphics.imagePath("festival/FestivalBanner")),

            lights = love.filesystem.load("sprites/festival/lights.lua")(),
        }
        love.graphics.setDefaultFilter("nearest", "nearest")
        -- School images
        stageImages["Sky"] = graphics.newImage(graphics.imagePath("week6/sky")) -- sky
        stageImages["School"] = graphics.newImage(graphics.imagePath("week6/school")) -- school
        stageImages["Street"] = graphics.newImage(graphics.imagePath("week6/street")) -- street
        stageImages["Trees Back"] = graphics.newImage(graphics.imagePath("week6/trees-back")) -- trees-back
        stageImages["Trees"] = love.filesystem.load("sprites/week6/trees.lua")() -- trees
        stageImages["Petals"] = love.filesystem.load("sprites/week6/petals.lua")() -- petals

        showDokis = true
        curEnemy = enemyChar

        stageImages.blackScreenBG = {}
        stageImages.blackScreenBG.visible = true
        stageImages.blackScreenBG.alpha = 0

        stageImages.blackScreen = {}
        stageImages.blackScreen.visible = false
        stageImages.blackScreen.alpha = 0

        stageImages.staticshock = love.filesystem.load("sprites/clubroom/static.lua")()
        stageImages.staticshock.visible = false
        stageImages.staticshock.alpha = 0

        stageImages.vignette.visible = false
        stageImages.vignette.alpha = 1

        girlfriend = love.filesystem.load("sprites/characters/girlfriend/girlfriend.lua")()

        stageImages.desks.visible = true

        girlfriend.x, girlfriend.y = 30, 175
        boyfriend.x, boyfriend.y = 260, 390

        shaderCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())

        resolution = {x = 1280, y = 720}
        glitchy:send("resolution", {resolution.x, resolution.y})
        glitchyAmount = {0}

        stageImages.banner.y = -400
        stageImages.lights.y = 50
    end,

    load = function()
        showDokis = true

        if curEnemy == "sayori" then
            enemy = love.filesystem.load("sprites/characters/sayori/".. SaveData.costumes.sayori .. ".lua")()

            stageImages.dokis.yuri.x = -475
            stageImages.dokis.natsuki.x = 450

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.natsuki.y = 250

            enemy.x, enemy.y = -380, 225
        elseif curEnemy == "natsuki" then
            enemy = love.filesystem.load("sprites/characters/natsuki/" .. SaveData.costumes.natsuki .. ".lua")()

            stageImages.dokis.yuri.x = 500
            stageImages.dokis.sayori.x = -350

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.sayori.y = 220

            enemy.x, enemy.y = -380, 265
        elseif curEnemy == "yuri" then 
            enemy = love.filesystem.load("sprites/characters/yuri/" .. SaveData.costumes.yuri .. ".lua")()

            stageImages.dokis.natsuki.x = 500
            stageImages.dokis.sayori.x = -350

            stageImages.dokis.natsuki.y = 250
            stageImages.dokis.sayori.y = 220

            enemy.x, enemy.y = -380, 215
        elseif curEnemy == "monika" then
            enemy = love.filesystem.load("sprites/characters/monika/" .. SaveData.costumes.monika .. ".lua")()
            enemy2 = love.filesystem.load("sprites/characters/pixel/monika.lua")()
            boyfriend2 = love.filesystem.load("sprites/characters/pixel/boyfriend.lua")()
            girlfriend2 = love.filesystem.load("sprites/pixel/girlfriend.lua")()

            stageImages.dokis.yuri.x = 500
            stageImages.dokis.natsuki.x = 675
            stageImages.dokis.sayori.x = -475

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.natsuki.y = 250
            stageImages.dokis.sayori.y = 230

            enemy.x, enemy.y = -275, 210
            enemy2.x, enemy2.y = -340, -20

            boyfriend2.x, boyfriend2.y = 300, 190
            girlfriend2.x, girlfriend2.y = 30, -50
        elseif curEnemy == "protag" then
            enemy = love.filesystem.load("sprites/characters/mc/" .. SaveData.costumes.mc .. ".lua")()

            stageImages.dokis.yuri.x = 500
            stageImages.dokis.natsuki.x = 675
            stageImages.dokis.sayori.x = -475
            stageImages.dokis.monika.x = -350

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.natsuki.y = 250
            stageImages.dokis.sayori.y = 230
            stageImages.dokis.monika.y = 200

            enemy.x, enemy.y = -275, 210
        end

        stageImages.dokis.monika.x = 675
        stageImages.dokis.monika.y = 200
    end,

    update = function(self, dt)
        stageImages.dokis.sayori:update(dt)
        stageImages.dokis.natsuki:update(dt)
        stageImages.dokis.yuri:update(dt)
        stageImages.dokis.monika:update(dt)
        stageImages.lights:update(dt)

        camera:update(dt)

        if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 then
            stageImages.dokis.sayori:animate("anim")
            stageImages.dokis.natsuki:animate("anim")
            stageImages.dokis.yuri:animate("anim")
            stageImages.dokis.monika:animate("anim")
        end

        if song == 4 then 
            -- moniker
            glitchy:send("strength", glitchyAmount[1])
        end
    end,

    draw = function()
        love.graphics.setCanvas(shaderCanvas)
            love.graphics.clear()
            love.graphics.push()
                love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
                love.graphics.scale(camera.zoom, camera.zoom)
                if (song == 4 and curEnemy == "monika") or song ~= 4 then
                    love.graphics.push()
                        love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
                        love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

                        stageImages.closet:udraw(1.6, 1.6)
                    love.graphics.pop()
                    love.graphics.push()
                        love.graphics.translate(camera.x, camera.y)
                        love.graphics.translate(camera.ex, camera.ey)

                        stageImages.clubroom:udraw(1.6, 1.6)
                        stageImages.lights:udraw(1.6, 1.6)

                        graphics.setColor(0.4,0.4,0.4)
                        -- draw dokis here
                        if showDokis then
                            if curEnemy ~= "sayori" then
                                stageImages.dokis.sayori:udraw(0.7, 0.7)
                            end
                            if curEnemy ~= "natsuki" then
                                stageImages.dokis.natsuki:udraw(0.7, 0.7)
                            end
                            if curEnemy ~= "yuri" then
                                stageImages.dokis.yuri:udraw(0.7, 0.7)
                            end
                            if curEnemy ~= "monika" then
                                stageImages.dokis.monika:udraw(0.7, 0.7)
                            end
                        end

                        girlfriend:draw()

                        if stageImages.blackScreenBG.visible then 
                            graphics.setColor(0,0,0,stageImages.blackScreenBG.alpha)
                            love.graphics.rectangle("fill", -2000, -2000, 10000, 10000)
                            graphics.setColor(0.5,0.5,0.5,1)
                        end
                        boyfriend:draw()
                        enemy:draw()

                        graphics.setColor(1,1,1,1)
                        
                    love.graphics.pop()
                    love.graphics.push()
                        love.graphics.translate(camera.x * 1.1, camera.y * 1.1)
                        love.graphics.translate(camera.ex * 1.1, camera.ey * 1.1)

                        stageImages.desks:udraw(1.6, 1.6)
                    love.graphics.pop()
                    graphics.setColor(1,1,1,1)
                else
                    -- school stage
                    love.graphics.push()
                        love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
                        love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

                        if song ~= 3 then
                            stageImages["Sky"]:udraw()
                        end

                        stageImages["School"]:udraw()
                        stageImages["Street"]:udraw()
                        stageImages["Trees Back"]:udraw()

                        stageImages["Trees"]:udraw()
                        stageImages["Petals"]:udraw()
                        girlfriend2:udraw()
                    love.graphics.pop()
                    love.graphics.push()
                        love.graphics.translate(camera.x, camera.y)
                        love.graphics.translate(camera.ex, camera.ey)

                        enemy2:udraw()
                        boyfriend2:udraw()
                    love.graphics.pop()
                end
            love.graphics.pop()
        love.graphics.setCanvas()

        -- scale canvas to fit in lovesize window
        love.graphics.push()
            if glitchyAmount[1] ~= 0 then
                love.graphics.setShader(glitchy)
            end
            love.graphics.draw(shaderCanvas, 0, 0, 0, graphics.getWidth() / shaderCanvas:getWidth(), graphics.getHeight() / shaderCanvas:getHeight())
            love.graphics.setShader()
        love.graphics.pop()
    end,

    leave = function()
        for i, v in pairs(stageImages) do
            v = nil
        end
    end
}