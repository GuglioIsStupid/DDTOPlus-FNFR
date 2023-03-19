return {
    enter = function()
        stageImages = {
            scanlines = graphics.newImage(graphics.imagePath("credits/scanlines")),
            gradient = graphics.newImage(graphics.imagePath("credits/gradent")),

            windowBoxes = {
                senpai = graphics.newImage(graphics.imagePath("credits/window_bottom_senpai")),
                monika = graphics.newImage(graphics.imagePath("credits/window_bottom_monika")),
                natsuki = graphics.newImage(graphics.imagePath("credits/window_bottom_natsuki")),
                yuri = graphics.newImage(graphics.imagePath("credits/window_bottom_yuri")),
                sayori = graphics.newImage(graphics.imagePath("credits/window_bottom_sayori")),
                protag = graphics.newImage(graphics.imagePath("credits/window_bottom_protag")),
                p2 = graphics.newImage(graphics.imagePath("credits/window_bottom")),
                p1 = graphics.newImage(graphics.imagePath("credits/window_bottom_funkin")),

                windowTopMiddle = graphics.newImage(graphics.imagePath("credits/window_top")),
                windowTopLeft = graphics.newImage(graphics.imagePath("credits/window_top")),
                windowTopRight = graphics.newImage(graphics.imagePath("credits/window_top")),
            },

            cursor = graphics.newImage(graphics.imagePath("credits/Arrow")),
            cursorHold = graphics.newImage(graphics.imagePath("credits/Arrow_HOLD")),
            cg1 = graphics.newImage(graphics.imagePath("credits/DokiTakeoverLogo")),
            cg2 = graphics.newImage(graphics.imagePath("credits/CreditsShit2")),
            cg3 = graphics.newImage(graphics.imagePath("credits/thanksforplaying")),

            static = love.filesystem.load("sprites/clubroom/static.lua")()
        }

        ddtoCursor = stageImages.cursor

        ddtoCursor.x = 100
        ddtoCursor.y = 500

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
            img = stageImages.scanlines,

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

        camera.mustHit = false

        boyfriend = love.filesystem.load("sprites/boyfriend.lua")()
        enemy = boyfriend

        stageImages.cg1.alpha = 1
        stageImages.cg2.alpha = 0
        stageImages.cg3.alpha = 0

        girlfriend.x, girlfriend.y = 30, -90
        enemy.x, enemy.y = -380, -110
        boyfriend.x, boyfriend.y = 400, 125

        stageImages.windowBoxes.senpai.y = 1000
        stageImages.windowBoxes.windowTopMiddle.y = 1000

        stageImages.windowBoxes.monika.x = -400
        stageImages.windowBoxes.monika.y = 0

        stageImages.windowBoxes.natsuki.x = -400
        stageImages.windowBoxes.natsuki.y = 0

        stageImages.windowBoxes.yuri.x = -400
        stageImages.windowBoxes.yuri.y = 0

        stageImages.windowBoxes.sayori.x = -400
        stageImages.windowBoxes.sayori.y = 0

        stageImages.windowBoxes.protag.x = -400
        stageImages.windowBoxes.protag.y = 0

        stageImages.windowBoxes.p2.x = -400
        stageImages.windowBoxes.p2.y = 0

        stageImages.windowBoxes.p1.x = 400
        stageImages.windowBoxes.p1.y = 0

        stageImages.windowBoxes.windowTopLeft.x = -400
        stageImages.windowBoxes.windowTopLeft.y = 0
        
        stageImages.windowBoxes.windowTopRight.x = 400
        stageImages.windowBoxes.windowTopRight.y = 0

        stageImages.static.alpha = 0

        fisheye:send("strength", 0.3)
        uiAlpha = {0}
        curEnemy = "none"
    end,

    load = function()
        camera.y = 2000
        camera.x = 0
        camera.mustHit = false
    end,

    update = function(self, dt)
        scrollingBG:update(dt)
        scrollingBG2:update(dt)
        scanlinesBG:update(dt)
        stageImages.static:update(dt)
    end,

    draw = function()
        love.graphics.push()
            love.graphics.translate(camera.x * 1.25, camera.y * 1.25)
            love.graphics.translate(camera.ex * 1.25, camera.ey * 1.25)

            stageImages.windowBoxes.senpai:draw(1.2, 1.2)
            stageImages.windowBoxes.windowTopMiddle:draw(1.2, 1.2)

            stageImages.windowBoxes.p2:draw(1.2, 1.2)
            if curEnemy == "monika" or curEnemy == "pmonika" then 
                stageImages.windowBoxes.monika:draw(1.2, 1.2)
            elseif curEnemy == "sayori" then 
                stageImages.windowBoxes.sayori:draw(1.2, 1.2)
            elseif curEnemy == "natsuki" then
                stageImages.windowBoxes.natsuki:draw(1.2, 1.2)
            elseif curEnemy == "yuri" then
                stageImages.windowBoxes.yuri:draw(1.2, 1.2)
            elseif curEnemy == "protag" then
                stageImages.windowBoxes.protag:draw(1.2, 1.2)
            end
            stageImages.windowBoxes.p1:draw(1.2, 1.2)

            stageImages.windowBoxes.windowTopRight:draw(1.2, 1.2)
            stageImages.windowBoxes.windowTopLeft:draw(1.2, 1.2)

            love.graphics.setColor(1,1,1,enemy.alpha)
            if enemy ~= monikap then
                enemy:udraw(0.8, 0.8)
            else
                enemy:udraw(5,5)
            end
            love.graphics.setColor(1,1,1,enemy2.alpha)
            enemy2:udraw(0.8, 0.8)
            love.graphics.setColor(1,1,1,1)
            girlfriend:udraw(5,5)
            love.graphics.setColor(1,1,1,boyfriend.alpha)
			boyfriend:udraw(0.8, 0.8)
            love.graphics.setColor(1,1,1,1)

        love.graphics.pop()

        love.graphics.push()
            love.graphics.setColor(1,1,1,stageImages.cg1.alpha)
            stageImages.cg1:draw()
            love.graphics.setColor(1,1,1,1)
        love.graphics.pop()
        love.graphics.push()
            love.graphics.setColor(1,1,1,stageImages.cg2.alpha)
            stageImages.cg2:draw()
            love.graphics.setColor(1,1,1,1)
        love.graphics.pop()
        love.graphics.push()
            --love.graphics.setColor(1,1,1,stageImages.cg3.alpha)
            stageImages.cg3:udraw(1.2,1.2)
            love.graphics.setColor(1,1,1,1)
        love.graphics.pop()

        love.graphics.push()
            love.graphics.setColor(1,1,1,stageImages.static.alpha)
            stageImages.static:draw()
            love.graphics.setColor(1,1,1,1)
        love.graphics.pop()

        ddtoCursor:draw()
    end,

    leave = function()

    end
}