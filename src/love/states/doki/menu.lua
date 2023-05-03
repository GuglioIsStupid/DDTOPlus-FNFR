local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

return {
    enter = function(self)
        if not music:isPlaying() then
            music:play()
        end
        scrollingBG = {
            vx = -5,
            vy = -5,
            x = 0,
            y = 0,
            alpha = 1,
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
            end
        }

        graphics.setFade(0)
        graphics.fadeIn(0.3)

        scrollingBG2 = {
            vx = -50,
            vy = 0,
            x = 0,
            y = 0,
            alpha = 1,
            img = graphics.newImage(graphics.imagePath("credits/pocBackground")),
    
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
            end
        }

        scanlinesBG = {
            xx = 0,
            xy = 20,
            x = 0,
            y = 0,
            alpha = 1,
            img = graphics.newImage(graphics.imagePath("credits/scanlines")),

            update = function(self, dt)
                self.x = self.x + self.xx * dt
                self.y = self.y + self.xy * dt
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
                    for y = -3, 3 do
                        self.img.x = self.x + (self.img:getWidth() * (x - 1))
                        self.img.y = self.y + (self.img:getHeight() * (y))
                        self.img:draw()
                    end
                end
            end
        }
        gradient = graphics.newImage(graphics.imagePath("credits/gradent"))

        logo = love.filesystem.load("sprites/menu/logo.lua")()
        logo.x, logo.y = -300, -50
        logo.sizeX, logo.sizeY = 0.8, 0.8
        girlfriendTitle = love.filesystem.load("sprites/menu/girlfriend-title.lua")()
        girlfriendTitle.x, girlfriendTitle.y = 225, 20

        bpm = 120
        beatHit = false
        beat = 0
        beatTimer = 0
        flash = 0
    end,

    update = function(self, dt)
        scrollingBG:update(dt)
        scrollingBG2:update(dt)
        scanlinesBG:update(dt)
        logo:update(dt)
        girlfriendTitle:update(dt)

        beatTimer = beatTimer + dt * 1000
        if beatTimer >= 60000 / bpm then
            beatTimer = 0
            beat = beat + 1
            beatHit = true
        else
            beatHit = false
        end

        if beatHit then
            if girlfriendTitle:getAnimName() == "danceLeft" then
                girlfriendTitle:animate("danceRight")
            else
                girlfriendTitle:animate("danceLeft")
            end
            logo:animate("anim")
        end

        if not graphics.isFading() then
            if input:pressed("confirm") then
                audio.playSound(confirmSound)
                flash = 0.8
                Timer.after(1.5,function()
                    graphics:fadeOutWipe(0.5, function()
                        Gamestate.switch(menuSelect)
                    end)
                end)
            end
        end

        if flash > 0 then
            flash = util.lerp(flash, 0, dt)
        end
    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
            scrollingBG:draw()
            scrollingBG2:draw()
            graphics.setColor(1, 1, 1, 1)
            gradient:draw()
            scanlinesBG:draw()
            
            girlfriendTitle:draw()
            logo:draw()
        love.graphics.pop()

        love.graphics.setColor(1, 1, 1, flash)
        love.graphics.rectangle("fill", 0, 0, graphics.getWidth(), graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
    end,

    leave = function(self)

    end
}