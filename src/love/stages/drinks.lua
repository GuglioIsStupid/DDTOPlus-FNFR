return {
    enter = function()
        stageImages = {
            bg = graphics.newImage(graphics.imagePath("va11halla/barbg")),
            -- anna
            -- dana
            bg2 = graphics.newImage(graphics.imagePath("va11halla/barbg2")),
            --barAds
            -- dorth
            -- alma
        }
        -- i hate myself
    end,

    load = function()

    end,

    update = function(self, dt)

    end,

    draw = function()
        love.graphics.push()

        love.graphics.pop()
    end,

    leave = function()

    end
}