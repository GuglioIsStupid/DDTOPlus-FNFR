return {
    enter = function()
		pixel = true
		love.graphics.setDefaultFilter("nearest")
        stageImages = {
            stars = graphics.newImage(graphics.imagePath("week6/FinaleBG_1")),
            wall = graphics.newImage(graphics.imagePath("week6/FinaleBG_2")),
            FG = graphics.newImage(graphics.imagePath("week6/FinaleFG")),
            school = love.filesystem.load("sprites/week6/evil-school.lua")(),
        }
		girlfriend = love.filesystem.load("sprites/pixel/girlfriend.lua")()
		enemy = love.filesystem.load("sprites/characters/pixel/monika.lua")()
        enemy2 = love.filesystem.load("sprites/characters/pixel/bigmonika.lua")()
		enemy.colours = {255,170,111}
		fakeBoyfriend = love.filesystem.load("sprites/pixel/boyfriend-dead.lua")() -- Used for game over
        girlfriend.x, girlfriend.y = 30, -50
		boyfriend.x, boyfriend.y = 300, 190
		fakeBoyfriend.x, fakeBoyfriend.y = 300, 190
		enemy.x, enemy.y = -340, -20

        stageImages.FG.y = -150

		camera.defaultZoom = 0.85

        camera:addPoint("enemy", -enemy.x - 100, -enemy.y + 75)
        

		curEnemy = "monikaALT"
		curPlayer = "pixelboyfriend"

        enemy.altIdle = true

        enemy2.x, enemy2.y = 0, 20

        curStage = "haunted"
    end,

    load = function(self)
        
    end,

    update = function(self, dt)
        stageImages.school:update(dt)
    end,

    draw = function()
		love.graphics.push()
            if curStage == "bigroom" then
                print("bigroom")
                love.graphics.push()
                    love.graphics.translate(camera.x * 0.4, camera.y * 0.4)
                    love.graphics.translate(camera.ex * 0.4, camera.ey * 0.4)

                    stageImages.stars:udraw(2.5, 2.5)
                love.graphics.pop()
                love.graphics.push()
                    love.graphics.translate(camera.x * 0.5, camera.y * 0.5)
                    love.graphics.translate(camera.ex * 0.5, camera.ey * 0.5)

                    stageImages.wall:udraw(2.5, 2.5)
                love.graphics.pop()
                love.graphics.translate(camera.x, camera.y)
                love.graphics.translate(camera.ex, camera.ey)
                stageImages.FG:udraw(2.5, 2.5)
                enemy2:udraw(7.2,7.2)
                boyfriend:udraw(6.5,6.5)
            elseif curStage == "haunted" then 
                love.graphics.push()
                    love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
                    love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

                    stageImages.school:udraw()

                    girlfriend:udraw()
                love.graphics.pop()
                love.graphics.push()
                    love.graphics.translate(camera.x, camera.y)
                    love.graphics.translate(camera.ex, camera.ey)

                    enemy:udraw()
                    boyfriend:udraw()
                love.graphics.pop()
            end
		love.graphics.pop()
    end,

    leave = function()
        for i, v in pairs(stageImages) do
			v = nil
		end
    end
}