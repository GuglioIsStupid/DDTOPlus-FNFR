return {
    enter = function()
        stageImages = {
            BG = graphics.newImage(graphics.imagePath("musicroom/Music_Room")),
            FG = graphics.newImage(graphics.imagePath("musicroom/Music_Room_FG")),
            RoomLight = graphics.newImage(graphics.imagePath("musicroom/Music_RoomLight")),
            sunshine = graphics.newImage(graphics.imagePath("musicroom/SayoSunshine")),
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

        -- Other

        stageImages.encore = graphics.newImage(graphics.imagePath("musicroom/ENCOREBORDER"))
        stageImages.encore.visible = true
        stageImages.encore.alpha = 0

        boyfriend = love.filesystem.load("sprites/characters/monika/monika.lua")()
        enemy = love.filesystem.load("sprites/characters/natsuki/natsuki.lua")()

        stageImages.FG.x, stageImages.FG.y = -250, -100

        girlfriend.x, girlfriend.y = 30, -90
        enemy.x, enemy.y = -380, 100
        boyfriend.x, boyfriend.y = 260, 70
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
            -- todo
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
			enemy:draw()
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

    end
}