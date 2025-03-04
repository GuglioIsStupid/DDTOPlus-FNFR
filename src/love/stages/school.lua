return {
    enter = function()
		pixel = true
		love.graphics.setDefaultFilter("nearest")
        stageImages = {
            ["Sky"] = graphics.newImage(graphics.imagePath("week6/sky")), -- sky
			["School"] = graphics.newImage(graphics.imagePath("week6/school")), -- school
			["Evil School"] = love.filesystem.load("sprites/week6/evil-school.lua")(), -- evil school
			["Street"] = graphics.newImage(graphics.imagePath("week6/street")), -- street
			["Trees Back"] = graphics.newImage(graphics.imagePath("week6/trees-back")), -- trees-back
			["Trees"] = love.filesystem.load("sprites/week6/trees.lua")(), -- trees
			["Petals"] = love.filesystem.load("sprites/week6/petals.lua")(), -- petals
			["Freaks"] = love.filesystem.load("sprites/week6/freaks.lua")() -- freaks
        }
		girlfriend = love.filesystem.load("sprites/pixel/girlfriend.lua")()
		enemy = love.filesystem.load("sprites/characters/pixel/monika.lua")()
		enemy.colours = {255,170,111}
		fakeBoyfriend = love.filesystem.load("sprites/pixel/boyfriend-dead.lua")() -- Used for game over
        girlfriend.x, girlfriend.y = 30, -50
		boyfriend.x, boyfriend.y = 300, 190
		fakeBoyfriend.x, fakeBoyfriend.y = 300, 190
		enemy.x, enemy.y = -340, -20

		camera.defaultZoom = 0.85

		curEnemy = "monika"
		curPlayer = "pixelboyfriend"

		function glitchySchool(swap)
			if swap == 0 then
				evilV = false
			else
				evilV = true
			end
		end
    end,

    load = function(self)
        if song == 3 then
            enemy = love.filesystem.load("sprites/week6/spirit.lua")()
            stageImages["School"] = love.filesystem.load("sprites/week6/evil-school.lua")()
			enemy.x, enemy.y = -340, -20
			curEnemy = "spirit"
        elseif song == 2 then
            enemy = love.filesystem.load("sprites/characters/pixel/duet.lua")()
			enemy.colours = {255,170,111}
			curEnemy = "duet"
            stageImages["Freaks"]:animate("dissuaded", true)
			enemy.x, enemy.y = -340, -20
        end
    end,

    update = function(self, dt)
        if song ~= 3 then
			stageImages["Trees"]:update(dt)
			stageImages["Petals"]:update(dt)
			stageImages["Freaks"]:update(dt)
		else
			stageImages["School"]:update(dt)
		end
    end,

    draw = function()
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
			if song == 2 then
				stageImages["Freaks"]:udraw()
			end
			if evilV then 
				stageImages["Evil School"]:udraw()
			end
			girlfriend:udraw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
			love.graphics.translate(camera.ex, camera.ey)

			enemy:udraw()
			boyfriend:udraw()
		love.graphics.pop()
    end,

    leave = function()
        for i, v in pairs(stageImages) do
			v = nil
		end
    end
}