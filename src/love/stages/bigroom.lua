local num
return {
    enter = function(self, l)
		pixel = true
		love.graphics.setDefaultFilter("nearest")
        stageImages = {
            stars = graphics.newImage(graphics.imagePath("week6/FinaleBG_1")),
            wall = graphics.newImage(graphics.imagePath("week6/FinaleBG_2")),
            FG = graphics.newImage(graphics.imagePath("week6/FinaleFG")),
            school = love.filesystem.load("sprites/week6/evil-school.lua")(),
            ["Petals"] = love.filesystem.load("sprites/week6/petals.lua")()
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
        
        num = l or 1

		curEnemy = "monikaALT"
		curPlayer = "pixelboyfriend"

        enemy.altIdle = true

        enemy2.x, enemy2.y = 0, 20

        curStage = "haunted"

        if num == 2 then
            enemy = love.filesystem.load("sprites/characters/pixel/bigmonika.lua")()
            enemy2 = love.filesystem.load("sprites/week6/spirit.lua")()

            enemy.x, enemy.y = -100, 20
            enemy2.x, enemy2.y = -520, 30

            camera:addPoint("enemy", -enemy.x + 50, -enemy.y + 25)

            curStage = "bigroom"
        end

        stageImages.Petals.visible = false
    end,

    load = function(self)
        
    end,

    update = function(self, dt)
        stageImages.school:update(dt)
        stageImages.Petals:update(dt)
    end,

    treeleavesVisible = function(self, bool)
        stageImages.Petals.visible = bool
    end,

    draw = function()
		love.graphics.push()
            if curStage == "bigroom" then
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
                if num == 2 then
                    enemy:udraw(7.2,7.2)
                    enemy2:udraw(6.9,6.9)
                else
                    enemy2:udraw(7.2,7.2)
                end
                boyfriend:udraw(6.5,6.5)
            elseif curStage == "haunted" then 
                love.graphics.push()
                    love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
                    love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

                    stageImages.school:udraw()
                    if stageImages.Petals.visible then
                        stageImages.Petals:udraw()
                    end

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