return {
    enter = function()
        stageImages = {
           space = {
            vx = -7,
            vy = 0,
            x = 0,
            y = 0,
            alpha = 1,
            img = graphics.newImage(graphics.imagePath("bigmonika/sky")),

            update = function(self, dt)
                self.x = self.x + self.vx * dt
                self.y = self.y + self.vy * dt
                -- at a certain point, reset the position
                if self.x < -self.img:getWidth() then
                    self.x = 0
                end
                if self.y < -self.img:getHeight() then
                    self.y = 0
                end
            end,

            draw = function(self)
                graphics.setColor(1, 1, 1, self.alpha)
                for x = -3, 3 do
                    for y = -1, 2 do
                        self.img.x = self.x + (self.img:getWidth() * (x - 1))
                        self.img.y = self.y + (self.img:getHeight() * (y))
                        self.img:draw()
                    end
                end
                graphics.setColor(1, 1, 1, 1)
            end
           },
           clouds = {
            vx = -13,
            vy = 0,
            x = 0,
            y = 0,
            alpha = 1,
            img = graphics.newImage(graphics.imagePath("bigmonika/Clouds")),

            update = function(self, dt)
                self.x = self.x + self.vx * dt
                self.y = self.y + self.vy * dt
                -- at a certain point, reset the position
                if self.x < -self.img:getWidth() then
                    self.x = 0
                end
                if self.y < -self.img:getHeight() then
                    self.y = 0
                end
            end,

            draw = function(self)
                graphics.setColor(1, 1, 1, self.alpha)
                for x = -5, 20 do
                    for y = -5, 20 do
                        self.img.x = self.x + (self.img:getWidth() * (x - 1))
                        self.img.y = self.y + (self.img:getHeight() * (y - 1))
                        self.img:draw()
                    end
                end
                graphics.setColor(1, 1, 1, 1)
            end
           },
           fancyclouds = {
            vx = -13,
            vy = 0,
            x = 0,
            y = 0,
            alpha = 1,
            img = graphics.newImage(graphics.imagePath("bigmonika/mask")),

            update = function(self, dt)
                self.x = self.x + self.vx * dt
                self.y = self.y + self.vy * dt
                -- at a certain point, reset the position
                if self.x < -self.img:getWidth() then
                    self.x = 0
                end
                if self.y < -self.img:getHeight() then
                    self.y = 0
                end
            end,

            draw = function(self)
                graphics.setColor(1, 1, 1, self.alpha)
                for x = -5, 20 do
                    for y = -5, 20 do
                        self.img.x = self.x + (self.img:getWidth() * (x - 1))
                        self.img.y = self.y + (self.img:getHeight() * (y - 1))
                        self.img:draw()
                    end
                end
                graphics.setColor(1, 1, 1, 1)
            end
           },
            bg = graphics.newImage(graphics.imagePath("bigmonika/BG")),
            windowLight = graphics.newImage(graphics.imagePath("bigmonika/WindowLight")),
            lightsontopofall = graphics.newImage(graphics.imagePath("bigmonika/lights")),
            fg = graphics.newImage(graphics.imagePath("bigmonika/FG")),

            scrollingBG = {
                vx = -25,
                vy = -25,
                x = 0,
                y = 0,
                alpha = 0,
                img = graphics.newImage(graphics.imagePath("scrollingBG")),
        
                update = function(self, dt)
                    self.x = self.x + self.vx * dt
                    self.y = self.y + self.vy * dt
                    -- at a certain point, reset the position
                    if self.x < -self.img:getWidth() then
                        self.x = 0
                    end
                    if self.y < -self.img:getHeight() then
                        self.y = 0
                    end
                end,
        
                draw = function(self)
                    graphics.setColor(1, 1, 1, self.alpha)
                    for x = -5, 20 do
                        for y = -5, 20 do
                            self.img.x = self.x + (self.img:getWidth() * (x - 1))
                            self.img.y = self.y + (self.img:getHeight() * (y - 1))
                            self.img:draw()
                        end
                    end
                    graphics.setColor(1, 1, 1, 1)
                end
            },

            popout = love.filesystem.load("sprites/epiphany/popout.lua")(),
        }

        enemy = love.filesystem.load("sprites/characters/monika/bigmonika.lua")()

        girlfriend.x, girlfriend.y = 30, -90
        enemy.x, enemy.y = 0, -30

        stageImages.fg.x = -75

        stageImages.popout.alpha = 0
        stageImages.popout.x, stageImages.popout.y = -35, 176
    end,

    load = function()

    end,

    update = function(self, dt)
        stageImages.space:update(dt)
        stageImages.clouds:update(dt)
        stageImages.fancyclouds:update(dt)
        stageImages.scrollingBG:update(dt)
        stageImages.popout:update(dt)
        camera.x, camera.y = 25, 0
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(camera.x * 0.1, camera.y * 0.1)
            stageImages.space:draw()
            stageImages.clouds:draw()
            stageImages.fancyclouds:draw()
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
            stageImages.bg:draw()
            love.graphics.setColor(1, 1, 1, 0.8)
            -- change alpha based off brightness
            love.graphics.setBlendMode("add")
            graphics.setColor(1,1,1,.5)
            stageImages.windowLight:draw()
            love.graphics.setBlendMode("alpha")
            stageImages.lightsontopofall:draw()
            love.graphics.setColor(1, 1, 1, 1)
            stageImages.scrollingBG:draw()
            stageImages.fg:draw()
			enemy:udraw(0.85, 0.85)
            graphics.setColor(1, 1, 1, stageImages.popout.alpha)
            stageImages.popout:draw()
            graphics.setColor(1, 1, 1, 1)
            
		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x * 1.1, camera.y * 1.1)

		love.graphics.pop()
    end,

    leave = function()
        stageImages[1] = nil
        stageImages[2] = nil
        stageImages[3] = nil
    end
}