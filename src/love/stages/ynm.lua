return {
    enter = function()
        stageImages = {
            bg = graphics.newImage(graphics.imagePath("ynm/bg")),
            bg2 = graphics.newImage(graphics.imagePath("ynm/bg2")),
            bg3 = graphics.newImage(graphics.imagePath("ynm/bg3")),
            skybox = graphics.newImage(graphics.imagePath("ynm/skybox")),
        }

        boyfriend = love.filesystem.load("sprites/characters/mc/mc.lua")()
        enemy = boyfriend

        boyfriend.flipX = true

        girlfriend.x, girlfriend.y = 30, -90
        enemy.x, enemy.y = -380, -110
        boyfriend.x, boyfriend.y = 260, -160

        local posX, posY = 0, -795 

        stageImages.skybox.x, stageImages.skybox.y = posX, posY + 275
        stageImages.bg3.x, stageImages.bg3.y = posX, posY + 275
        stageImages.bg2.x, stageImages.bg2.y = posX, posY + 170
        stageImages.bg.x, stageImages.bg.y = posX, posY + 115
        camera.mustHit = false
        camera:addPoint("center", 0, 300)
    end,

    load = function()
        camera.x, camera.y = 0, 300
        --set back to 4250
    end,

    update = function(self, dt)
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(camera.x * 0.2, camera.y * 0.2)
            love.graphics.translate(camera.ex * 0.2, camera.ey * 0.2)
            stageImages.skybox:udraw(1.2, 1.2)
		love.graphics.pop()
        love.graphics.push()
            love.graphics.translate(camera.x * 0.5, camera.y * 0.5)
            love.graphics.translate(camera.ex * 0.5, camera.ey * 0.5)
            stageImages.bg3:udraw(1.2, 1.2)
        love.graphics.pop()
        love.graphics.push()
            love.graphics.translate(camera.x * 0.8, camera.y * 0.8)
            love.graphics.translate(camera.ex * 0.8, camera.ey * 0.8)
            stageImages.bg2:udraw(1.2, 1.2)
        love.graphics.pop()
        love.graphics.push()
            love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
            love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)
            stageImages.bg:udraw(1.2, 1.2)
        love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
            love.graphics.translate(camera.ex, camera.ey)
            if showEnemy then
			    enemy:draw()
            end
			boyfriend:draw()
            graphics.setColor(1,1,1)
            
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x * 1.1, camera.y * 1.1)
            love.graphics.translate(camera.ex * 1.1, camera.ey * 1.1)

		love.graphics.pop()
    end,

    leave = function()

    end
}