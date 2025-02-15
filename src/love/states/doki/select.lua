return {
    enter = function(self)
        scrollingBG = {
            vx = -35,
            vy = -35,
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

        menuChars = {}
        -- get all files in sprites/menu/chars
        for i, f in ipairs(love.filesystem.getDirectoryItems("sprites/menu/chars")) do
            -- if the file is a lua
            table.insert(menuChars, f)
        end

        -- choose a random character
        char = menuChars[love.math.random(#menuChars)]

        char = love.filesystem.load("sprites/menu/chars/" .. char)()

        left = graphics.newImage(graphics.imagePath("menu/Credits_LeftSide"))
        left.x = -450

        logo = love.filesystem.load("sprites/menu/logo2.lua")()
        logo.sizeX, logo.sizeY = 0.525, 0.525
        logo.x, logo.y = -415, -210

        graphics:fadeInWipe(0.3)
        curOption = "story"

        storyPos = {
            x = -570, y = 10
        }
        freeplayPos = {
            x = -570, y = 60
        }
        optionsPos = {
            x = -570, y = 110
        }
        exitPos = {
            x = -570, y = 160
        } -- 600

        Timer.tween(0.75, storyPos, {x = -600}, "in-bounce")
        Timer.tween(0.75, freeplayPos, {x = -600}, "in-bounce")
        Timer.tween(1, optionsPos, {x = -600}, "in-bounce")
        Timer.tween(1.25, exitPos, {x = -600}, "in-bounce")
        Timer.tween(0.7, left, {x = -425}, "in-bounce")
        Timer.tween(0.7, logo, {x = -395}, "in-bounce")

        bpm = 120
        beatHit = false
        beat = 0
        beatTimer = 0
    end,

    update = function(self, dt)
        scrollingBG:update(dt)
        char:update(dt)
        logo:update(dt)

        beatTimer = beatTimer + dt * 1000
        if beatTimer >= 60000 / bpm then
            beatTimer = 0
            beat = beat + 1
            beatHit = true
        else
            beatHit = false
        end

        if beatHit then
            logo:animate("anim")
        end

        if input:pressed("up") then
            if curOption == "story" then
                curOption = "exit"
            elseif curOption == "freeplay" then
                curOption = "story"
            elseif curOption == "options" then
                curOption = "freeplay"
            elseif curOption == "exit" then
                curOption = "options"
            end
        elseif input:pressed("down") then
            if curOption == "story" then
                curOption = "freeplay"
            elseif curOption == "freeplay" then
                curOption = "options"
            elseif curOption == "options" then
                curOption = "exit"
            elseif curOption == "exit" then
                curOption = "story"
            end
        end

        if input:pressed("confirm") then
            if curOption == "story" then
                graphics:fadeOutWipe(0.5, function() Gamestate.switch(menuWeek) end)
            elseif curOption == "freeplay" then
                graphics:fadeOutWipe(0.5, function() Gamestate.switch(menuFreeplay) end)
            elseif curOption == "options" then
                graphics:fadeOutWipe(0.5, function() Gamestate.switch(menuSettings) end)
            elseif curOption == "exit" then
                graphics.fadeOut(0.5, function() love.event.quit() end)
            end
        elseif input:pressed("back") then
            graphics:fadeOutWipe(0.5, function() Gamestate.switch(menu) end)
        end
    end,

    keypressed = function(self, key)
    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
            scrollingBG:draw()
            love.graphics.push()
                love.graphics.scale(0.8, 0.8)
                love.graphics.translate(200, 50)
                char:draw()
            love.graphics.pop()
            left:draw()
            logo:draw()
            local lastFont = love.graphics.getFont()
            love.graphics.setFont(riffic)
            borderedText2("Story Mode", storyPos.x, storyPos.y, 0, 1.25, 1.25, (curOption ~= "story" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "story" and {1,245/255,245/255} or {1,1,1}))
            borderedText2("Freeplay", freeplayPos.x, freeplayPos.y, 0, 1.25, 1.25, (curOption ~= "freeplay" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "freeplay" and {1,245/255,245/255} or {1,1,1}))
            borderedText2("Options", optionsPos.x, optionsPos.y, 0, 1.25, 1.25, (curOption ~= "options" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "options" and {1,245/255,245/255} or {1,1,1}))
            borderedText2("Exit Game", exitPos.x, exitPos.y, 0, 1.25, 1.25, (curOption ~= "exit" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "exit" and {1,245/255,245/255} or {1,1,1}))
            love.graphics.setFont(lastFont)
        love.graphics.pop()
    end,

    leave = function(self)
        
    end
}