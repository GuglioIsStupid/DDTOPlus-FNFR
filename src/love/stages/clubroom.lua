return {
    enter = function(self, enemyChar)
        stageImages = {
            closet = graphics.newImage(graphics.imagePath("clubroom/DDLCfarbg")),
            clubroom = graphics.newImage(graphics.imagePath("clubroom/DDLCbg")),
            desks = graphics.newImage(graphics.imagePath("clubroom/DesksFront")),
            dokis = {
                sayori = love.filesystem.load("sprites/clubroom/sayori.lua")(),
                natsuki = love.filesystem.load("sprites/clubroom/natsuki.lua")(),
                yuri = love.filesystem.load("sprites/clubroom/yuri.lua")(),
                monika = love.filesystem.load("sprites/clubroom/monika.lua")()
            },
            vignette = graphics.newImage(graphics.imagePath("clubroom/vignette")),

            spotlight = graphics.newImage(graphics.imagePath("clubroom/NEETspotlight")),
        }
        showDokis = true
        curEnemy = enemyChar
        if enemyChar == "sayori" then
            enemy = love.filesystem.load("sprites/characters/sayori/".. SaveData.costumes.sayori .. ".lua")()

            stageImages.dokis.yuri.x = -475
            stageImages.dokis.natsuki.x = 500

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.natsuki.y = 250

            enemy.x, enemy.y = -380, 225
        elseif enemyChar == "natsuki" then
            enemy = love.filesystem.load("sprites/characters/natsuki/" .. SaveData.costumes.natsuki .. ".lua")()

            stageImages.dokis.yuri.x = -475
            stageImages.dokis.sayori.x = 500

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.sayori.y = 220

            enemy.x, enemy.y = -380, 265
        elseif enemyChar == "yuri" then 
            enemy = love.filesystem.load("sprites/characters/yuri/" .. SaveData.costumes.yuri .. ".lua")()

            stageImages.dokis.natsuki.x = -475
            stageImages.dokis.sayori.x = 500

            stageImages.dokis.natsuki.y = 250
            stageImages.dokis.sayori.y = 220

            enemy.x, enemy.y = -380, 215
        elseif enemyChar == "monika" then
            enemy = love.filesystem.load("sprites/characters/monika/" .. SaveData.costumes.monika .. ".lua")()

            stageImages.dokis.yuri.x = -550
            stageImages.dokis.natsuki.x = 500
            stageImages.dokis.sayori.x = -350

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.natsuki.y = 250
            stageImages.dokis.sayori.y = 230

            enemy.x, enemy.y = -275, 210
        elseif enemyChar == "mc" then
            enemy = love.filesystem.load("sprites/characters/mc/" .. SaveData.costumes.mc .. ".lua")()

            enemy.x, enemy.y = -380, 225
        elseif enemyChar == "zipper" then
            enemy = love.filesystem.load("sprites/characters/extra/zipper.lua")()
            girlfriend = love.filesystem.load("sprites/characters/girlfriend/speaker.lua")()
            boyfriend = love.filesystem.load("sprites/characters/sayori/".. SaveData.costumes.sayori .. ".lua")()

            enemy.x, enemy.y = -380, 225
            boyfriend.x, boyfriend.y = 380, 225
            showDokis = false
        elseif enemyChar == "catfight" then
            enemy = love.filesystem.load("sprites/characters/yuri/" .. SaveData.costumes.yuri .. ".lua")()
            boyfriend = love.filesystem.load("sprites/characters/natsuki/" .. SaveData.costumes.natsuki .. ".lua")()
            girlfriend = love.filesystem.load("sprites/characters/girlfriend/sayo.lua")()

            enemy.x, enemy.y = -380, 225
            boyfriend.x, boyfriend.y = 380, 265
            showDokis = false
        end

        stageImages.bakaOverlay = love.filesystem.load("sprites/clubroom/baka.lua")()
        stageImages.bakaOverlay.visible = false
        stageImages.bakaOverlay.alpha = 0

        stageImages.sparkleBG = graphics.newImage(graphics.imagePath("clubroom/YuriSparkleBG"))
        stageImages.sparkleBG.visible = false
        stageImages.sparkleBG.alpha = 1
        stageImages.sparkleFG = graphics.newImage(graphics.imagePath("clubroom/YuriSparkleFG"))
        stageImages.sparkleFG.visible = false
        stageImages.sparkleFG.alpha = 1
        stageImages.pinkOverlay = {}
        stageImages.pinkOverlay.visible = false
        stageImages.pinkOverlay.alpha = 0.2

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

        stageImages.desks.alpha = 0
        stageImages.spotlight.alpha = 0
        girlfriend.alpha = 1

        stageImages.desks.visible = true

        if enemyChar ~= "zipper" and enemyChar ~= "catfight" then
            girlfriend = love.filesystem.load("sprites/characters/girlfriend/girlfriend.lua")()
            boyfriend.x, boyfriend.y = 260, 390

            print("enemyChar: " .. enemyChar)
        end
        girlfriend.x, girlfriend.y = 30, 175
        
    end,

    load = function()
        showDokis = true
    end,

    update = function(self, dt)
        stageImages.dokis.sayori:update(dt)
        stageImages.dokis.natsuki:update(dt)
        stageImages.dokis.yuri:update(dt)
        stageImages.dokis.monika:update(dt)

        camera:update(dt)

        if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 then
            stageImages.dokis.sayori:animate("anim")
            stageImages.dokis.natsuki:animate("anim")
            stageImages.dokis.yuri:animate("anim")
            stageImages.dokis.monika:animate("anim")
        end
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
            love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

            stageImages.closet:udraw(1.6, 1.6)
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
            love.graphics.translate(camera.ex, camera.ey)

            stageImages.clubroom:udraw(1.6, 1.6)

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
            end

            love.graphics.setColor(1,1,1,girlfriend.alpha)
            girlfriend:draw()
            love.graphics.setColor(1,1,1,1)

            love.graphics.setColor(1,1,1,stageImages.spotlight.alpha)
            stageImages.spotlight:udraw(1.6, 1.6)
            love.graphics.setColor(1,1,1,1)

            if stageImages.blackScreenBG.visible then 
                graphics.setColor(0,0,0,stageImages.blackScreenBG.alpha)
                love.graphics.rectangle("fill", -2000, -2000, 10000, 10000)
                graphics.setColor(1,1,1,1)
            end
			boyfriend:draw()
            if not yuriGoneCrazy then
			    enemy:draw()
            else
                enemy2:draw()
            end
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x * 1.1, camera.y * 1.1)
            love.graphics.translate(camera.ex * 1.1, camera.ey * 1.1)

            love.graphics.setColor(1,1,1,stageImages.desks.alpha)
            stageImages.desks:udraw(1.6, 1.6)
            love.graphics.setColor(1,1,1,1)
		love.graphics.pop()
    end,

    leave = function()
        for i, v in pairs(stageImages) do
            v = nil
        end
    end
}