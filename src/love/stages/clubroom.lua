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
            }
        }
        curEnemy = enemyChar
        if enemyChar == "sayori" then
            enemy = love.filesystem.load("sprites/characters/sayori/sayori.lua")()

            stageImages.dokis.yuri.x = -475
            stageImages.dokis.natsuki.x = 500

            stageImages.dokis.yuri.y = 200
            stageImages.dokis.natsuki.y = 250
        else
        end
        girlfriend = love.filesystem.load("sprites/characters/girlfriend/girlfriend.lua")()

        girlfriend.x, girlfriend.y = 30, 175
        enemy.x, enemy.y = -380, 225
        boyfriend.x, boyfriend.y = 260, 390
    end,

    load = function()

    end,

    update = function(self, dt)
        stageImages.dokis.sayori:update(dt)
        stageImages.dokis.natsuki:update(dt)
        stageImages.dokis.yuri:update(dt)
        stageImages.dokis.monika:update(dt)

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

            girlfriend:draw()

            -- draw dokis here
            if curEnemy ~= "sayori" then
                stageImages.dokis.sayori:udraw(0.7, 0.7)
            end
            if curEnemy ~= "natsuki" then
                stageImages.dokis.natsuki:udraw(0.7, 0.7)
            end
            if curEnemy ~= "yuri" then
                stageImages.dokis.yuri:udraw(0.7, 0.7)
            end

			enemy:draw()
			boyfriend:draw()
            
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x * 1.1, camera.y * 1.1)
            love.graphics.translate(camera.ex * 1.1, camera.ey * 1.1)

            stageImages.desks:udraw(1.6, 1.6)
		love.graphics.pop()
    end,

    leave = function()

    end
}