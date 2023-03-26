return {
    enter = function()
        stageImages = {
            creditsBG = graphics.newImage(graphics.imagePath("credits/pocBackground")),
            scanlines = graphics.newImage(graphics.imagePath("credits/scanlines")),
            gradient = graphics.newImage(graphics.imagePath("credits/gradent")),

            w1 = graphics.newImage(graphics.imagePath("wilt/p1")),
            w2 = graphics.newImage(graphics.imagePath("wilt/p2")),

            bg1 = graphics.newImage(graphics.imagePath("wilt/bg")),
            bg2 = graphics.newImage(graphics.imagePath("wilt/bg2")),
            hoii_senpai = love.filesystem.load("sprites/wilt/hoii_senpai.lua")(),
            hoii = love.filesystem.load("sprites/wilt/hoii.lua")(),
            hmph = love.filesystem.load("sprites/wilt/hmph.lua")(),
        }

        senpImg = love.graphics.newImage(graphics.imagePath("characters/SenpaiNonPixel_Assets"))

        curW = "w1"
        curBG = "bg1"

        senpai = love.filesystem.load("sprites/week6/senpai.lua")()
        senpaiAngry = love.filesystem.load("sprites/week6/senpai-angry.lua")()
        senpaiAngryNonpixel = love.filesystem.load("sprites/characters/extra/senpai-angry-nonpixel.lua")()
        senpaiNonpixel = love.filesystem.load("sprites/characters/extra/senpai-nonpixel.lua")()

        monika = love.filesystem.load("sprites/characters/monika/monika.lua")()
        monikapixel = love.filesystem.load("sprites/characters/pixel/monika.lua")()

        monika.flipX = true
        monikapixel.flipX = true

        camera.defaultZoom = 0.8
        love.graphics.setBackgroundColor(1,1,1)

        enemy = senpai
        boyfriend = monika

        girlfriend.x, girlfriend.y = 30, -90
        senpai.x, senpai.y = -380, 0
        senpaiAngry.x, senpaiAngry.y = -380, 0
        senpaiAngryNonpixel.x, senpaiAngryNonpixel.y = -380, 40
        senpaiNonpixel.x, senpaiNonpixel.y = -380, 40
        enemy.x, enemy.y = -380, 0
        monika.x, monika.y = 500, -20
        monikapixel.x, monikapixel.y = 480, 10
        boyfriend.x, boyfriend.y = 480, 10
        boyfriend.flipX = true
    

        stageImages.hoii_senpai.x = -405
        stageImages.hoii_senpai.y = -7
        stageImages.hoii_senpai.visible = false

        stageImages.hoii.x = 265
        stageImages.hoii.y = 5
        stageImages.hoii.visible = false

        stageImages.hmph.visible = false
        stageImages.hmph.x = 58
        stageImages.hmph.y = -4

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
            end
        }

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

        fisheye:send("strength", 0.3)
        uiAlpha = {0}
        camera:addPoint("center", 390, 0)

        camera:moveToPoint(0, "center", false)
        camera.mustHit = false
    end,

    load = function()
        isShitVisible = true
    end,

    update = function(self, dt)
        scrollingBG:update(dt)
        scrollingBG2:update(dt)
        scanlinesBG:update(dt)

        stageImages.hoii:update(dt)
        stageImages.hoii_senpai:update(dt)
        stageImages.hmph:update(dt)
    end,

    draw = function()
        love.graphics.push()
			love.graphics.translate(camera.x * 0.9, camera.y * 0.9)
            love.graphics.translate(camera.ex * 0.9, camera.ey * 0.9)

            if isShitVisible then
                if curBG == "bg1" then
                    stageImages.bg1:draw()
                elseif curBG == "bg2" then
                    stageImages.bg2:draw()
                end
                if curW == "w1" then
                    stageImages.w1:draw()
                elseif curW == "w2" then
                    stageImages.w2:draw()
                end
            end

		love.graphics.pop()
		love.graphics.push()
			love.graphics.translate(camera.x, camera.y)
            love.graphics.translate(camera.ex, camera.ey)
            if isShitVisible then
                if enemyIsPixel then
                    enemy:udraw(4.8, 4.8)
                    boyfriend:udraw(-0.7, 0.7)
                else
                    enemy:udraw(0.7, 0.7)
                    boyfriend:udraw(-4.8, 4.8)
                end
            end

            if stageImages.hoii.visible then
                stageImages.hoii_senpai:draw()
                stageImages.hoii:draw()
            end

            if stageImages.hmph.visible then
                stageImages.hmph:draw()
            end
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

        whoHasPixelNotes = "both"
    end
}