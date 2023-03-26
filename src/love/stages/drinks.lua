return {
    enter = function()
        love.graphics.setDefaultFilter("nearest")
        stageImages = {
            bg = graphics.newImage(graphics.imagePath("va11halla/barbg")),
            anna = love.filesystem.load("sprites/va11halla/anna.lua")(),
            dana = love.filesystem.load("sprites/va11halla/dana.lua")(),
            bg2 = graphics.newImage(graphics.imagePath("va11halla/barbg2")),
            barAds = love.filesystem.load("sprites/va11halla/barAds.lua")(),
            dorth = love.filesystem.load("sprites/va11halla/dorth.lua")(),
            alma = love.filesystem.load("sprites/va11halla/alma.lua")(),
        }
        -- i hate myself

        enemy = love.filesystem.load("sprites/characters/extra/jill_smoke.lua")()
        boyfriend = love.filesystem.load("sprites/characters/boyfriend/boyfriendbar.lua")()
        girlfriend = love.filesystem.load("sprites/characters/girlfriend/girlfriendbar.lua")()

        -- gonna be honest this is the first time i whipped out the stage editor lollll
        stageImages.anna.x, stageImages.anna.y = -456, -297
        stageImages.anna.visible = false
        stageImages.alma.x, stageImages.alma.y = 502, -64
        stageImages.alma.visible = false
        stageImages.dana.x, stageImages.dana.y = 43, -247
        stageImages.dana.visible = false
        stageImages.barAds.x, stageImages.barAds.y = 497, -336
        stageImages.barAds.visible = false
        stageImages.bg2.x, stageImages.bg2.y = 0, -37
        stageImages.dorth.x, stageImages.dorth.y = -713, -33
        stageImages.dorth.visible = false

        enemy.x, enemy.y = -443, -259
        boyfriend.x, boyfriend.y = 125, 220
        girlfriend.x, girlfriend.y = -194, 65
    end,

    load = function()

    end,

    update = function(self, dt)
        stageImages.anna:update(dt)
        stageImages.dana:update(dt)
        stageImages.alma:update(dt)
        stageImages.barAds:update(dt)
        stageImages.dorth:update(dt)

        if beatHandler.onBeat() and beatHandler.curBeat % 2 == 0 then
            stageImages.anna:animate("anim", false)
            stageImages.dana:animate("anim", false)
            stageImages.alma:animate("anim", false)
        end

        stageImages.dorth:beat(beatHandler.curBeat)
    end,

    draw = function()
        love.graphics.push()
            love.graphics.translate(camera.x, camera.y)

            stageImages.bg:udraw(6, 6)
            if stageImages.anna.visible then
                stageImages.anna:udraw(6, 6)
            end
            if stageImages.dana.visible then
                stageImages.dana:udraw(6, 6)
            end
            stageImages.bg2:udraw(6, 6)
            stageImages.barAds:udraw(6, 6)
            enemy:udraw(6, 6)
            if stageImages.dorth.visible then
                stageImages.dorth:udraw(6, 6)
            end
            if stageImages.alma.visible then
                stageImages.alma:udraw(6, 6)
            end

            girlfriend:udraw(6, 6)
            boyfriend:udraw(6, 6)
        love.graphics.pop()
    end,

    leave = function()
        love.graphics.setDefaultFilter("linear")
    end
}