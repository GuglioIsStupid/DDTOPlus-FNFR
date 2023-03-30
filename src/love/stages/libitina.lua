return {
    enter = function()
        stageImages = {
            
        }

        boyfriend1 = love.filesystem.load("sprites/characters/extra/libitina-a.lua")()
        boyfriend2 = love.filesystem.load("sprites/characters/extra/libitina-b.lua")()
        boyfriend3 = love.filesystem.load("sprites/characters/extra/libitina-c.lua")()

        boyfriend = boyfriend1
        enemy = girlfriend

        girlfriend.x, girlfriend.y = 30, -90
        enemy.x, enemy.y = -380, -110
        boyfriend.x, boyfriend.y = 260, 100
    end,

    load = function()

    end,

    update = function(self, dt)
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
            love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
            love.graphics.translate(camera.ex, camera.ey)
			boyfriend:draw()
            graphics.setColor(1,1,1)
            
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x * 1.1, camera.y * 1.1)
            love.graphics.translate(camera.ex * 1.1, camera.ey * 1.1)
		love.graphics.pop()
    end,

    leave = function()
        stageImages[1] = nil
        stageImages[2] = nil
        stageImages[3] = nil
    end
}