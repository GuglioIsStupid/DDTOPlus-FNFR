return {
    enter = function()
        stageImages = {
            BG = graphics.newImage(graphics.imagePath("musicroom/Music_Room")),
            FG = graphics.newImage(graphics.imagePath("musicroom/Music_Room_FG")),
            RoomLight = graphics.newImage(graphics.imagePath("musicroom/Music_RoomLight")),
            sunshine = graphics.newImage(graphics.imagePath("musicroom/SayoSunshine")),

            cg1 = graphics.newImage(graphics.imagePath("CG/cg1")),
            cg2 = graphics.newImage(graphics.imagePath("CG/cg2")),
            light = graphics.newImage(graphics.imagePath("CG/cg2Light")),

            cg2group = {
                bg = graphics.newImage(graphics.imagePath("CG/cg2BG")),
                moni = graphics.newImage(graphics.imagePath("CG/cg2Moni")),
                natsu = graphics.newImage(graphics.imagePath("CG/cg2Natsu")),
                sayo = graphics.newImage(graphics.imagePath("CG/cg2Sayo")),
                yuri = graphics.newImage(graphics.imagePath("CG/cg2Yuri")),

                alpha = 0,

                draw = function()
                    graphics.setColor(1,1,1,stageImages.cg2group.alpha)
                    stageImages.cg2group.bg:draw()
                    
                    stageImages.cg2group.yuri:draw()
                    stageImages.cg2group.sayo:draw()
                    stageImages.cg2group.natsu:draw()
                    stageImages.cg2group.moni:draw()
                    stageImages.light:draw()
                    graphics.setColor(1,1,1,1)
                end,
            }
        }

        -- Natsuki stuff
        stageImages.bakaOverlay = love.filesystem.load("sprites/clubroom/baka.lua")()
        stageImages.bakaOverlay.visible = false
        stageImages.bakaOverlay.alpha = 0

        -- Sayori Stuff
        stageImages.sunshine.visible = true
        stageImages.sunshine.alpha = 0
        stageImages.sunshine.color = {1,1,1}

        -- Yuri Stuff
        stageImages.sparkleBG = graphics.newImage(graphics.imagePath("clubroom/YuriSparkleBG"))
        stageImages.sparkleBG.visible = false
        stageImages.sparkleBG.alpha = 1

        stageImages.sparkleFG = graphics.newImage(graphics.imagePath("clubroom/YuriSparkleFG"))
        stageImages.sparkleFG.visible = false
        stageImages.sparkleFG.alpha = 1

        stageImages.pinkOverlay = {}
        stageImages.pinkOverlay.visible = false
        stageImages.pinkOverlay.alpha = 0.2

        -- CG
        stageImages.cg1.alpha = 0
        stageImages.cg2.alpha = 0
        stageImages.cg2group.alpha = 0

        stageImages.cg2group.bg.ID = 4
        stageImages.cg2group.yuri.ID = 3
        stageImages.cg2group.sayo.ID = 2
        stageImages.cg2group.natsu.ID = 1
        stageImages.cg2group.moni.ID = 0

        -- Other

        stageImages.encore = graphics.newImage(graphics.imagePath("musicroom/ENCOREBORDER"))
        stageImages.encore.visible = true
        stageImages.encore.alpha = 0

        boyfriend = love.filesystem.load("sprites/characters/monika/monika.lua")()
        enemy = love.filesystem.load("sprites/characters/natsuki/natsuki.lua")()
        girlfriend = love.filesystem.load("sprites/characters/girlfriend/speaker.lua")()

        boyfriend.flipX = true

        stageImages.FG.x, stageImages.FG.y = -250, -100

        girlfriend.x, girlfriend.y = 30, 145
        enemy.x, enemy.y = -380, 100
        boyfriend.x, boyfriend.y = 320, 70
    end,

    load = function()
        if song == 1 then
            enemy = love.filesystem.load("sprites/characters/natsuki/natsuki.lua")()
            enemy.x, enemy.y = -380, 100
        elseif song == 2 then
            enemy = love.filesystem.load("sprites/characters/yuri/yuri.lua")()
            enemy.x, enemy.y = -380, 80
        elseif song == 3 then
            enemy = love.filesystem.load("sprites/characters/sayori/sayori.lua")()
            enemy.x, enemy.y = -380, 80
        else
            enemy = love.filesystem.load("sprites/characters/sayori/sayori.lua")()
            enemy2 = love.filesystem.load("sprites/characters/natsuki/natsuki.lua")()
            enemy3 = love.filesystem.load("sprites/characters/yuri/yuri.lua")()

            enemy.x, enemy.y = -380, 100
            enemy2.x, enemy2.y = -600, 100
            enemy3.x, enemy3.y = -175, 100

            numOfChar = 4
        end
    end,

    update = function(self, dt)
        stageImages.bakaOverlay:update(dt)

        stageImages.sparkleBG.offsetX = stageImages.sparkleBG.offsetX - 16 * dt
        if stageImages.sparkleBG.offsetX < -stageImages.sparkleBG:getWidth()/2 then
            stageImages.sparkleBG.offsetX = 0
        end
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
            love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

            stageImages.BG:udraw(1.5, 1.5)
            girlfriend:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
            love.graphics.translate(camera.ex, camera.ey)
            for i = -1, 1 do
                love.graphics.push()
                    if stageImages.sparkleBG.visible then 
                        stageImages.sparkleBG.x = (i) * stageImages.sparkleBG:getWidth()/2
                        graphics.setColor(1,1,1,stageImages.sparkleBG.alpha)
                        stageImages.sparkleBG:draw()
                        graphics.setColor(1,1,1,1)
                    end
                love.graphics.pop()
            end
            if song == 4 then
                enemy3:draw()
            end
			enemy:draw()
            if song == 4 then
                enemy2:draw()
            end
			boyfriend:draw()
            graphics.setColor(1,1,1)
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x * 1.2, camera.y * 1)
            love.graphics.translate(camera.ex * 1.2, camera.ey * 1)
            stageImages.FG:udraw(1.5, 1.5)
		love.graphics.pop()
        love.graphics.push()
            love.graphics.translate(camera.x * 1.1, camera.y * 0.9)
            love.graphics.translate(camera.ex * 1.1, camera.ey * 0.9)
            stageImages.RoomLight:udraw(1.5, 1.5)
        love.graphics.pop()
    end,

    leave = function()
        numOfChar = 2
    end
}