local scrollingBG, choose, natsuki, yuri, choosen
return {
    enter = function(self)
        choose = graphics.newImage(graphics.imagePath("misc/selecttext"))
        natsuki = graphics.newImage(graphics.imagePath("misc/catfightNat"))
        yuri = graphics.newImage(graphics.imagePath("misc/catfightYuri"))
        scrollingBG = {
            vx = -25,
            vy = -25,
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
        

        yuri.x = -300
        natsuki.x = 300
        yuri.y = 25
        natsuki.y = 25

        yuri.sizeX, yuri.sizeY = 0.6, 0.6
        natsuki.sizeX, natsuki.sizeY = 0.6, 0.6

        choose.y = -295
        choose.sizeX, choose.sizeY = 0.7, 0.7

        choosen = 2

        graphics:fadeInWipe(0.7)
    end,    

    update = function(self, dt)
        scrollingBG:update(dt)

        if input:pressed("left") then
            choosen = 1
            --audio.playSound(selectSound)
        elseif input:pressed("right") then
            choosen = 2
            --audio.playSound(selectSound)

        elseif input:pressed("confirm") then
            status.setLoading(true)
    
            graphics:fadeOutWipe(
                0.7,
                function()
    
                    storyMode = false
    
                    music:stop()
    
                    Gamestate.switch(catfight, 1, "", choosen)
    
                    status.setLoading(false)
                    end
                )
        end
    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)

            love.graphics.setColor(1,1,1,1)
            scrollingBG:draw()
            choose:draw()
            if choosen ~= 2 then
                love.graphics.setColor(0.5,0.5,0.5,1)
            end
            natsuki:draw()
            if choosen ~= 1 then
                love.graphics.setColor(0.5,0.5,0.5,1)
            else
                love.graphics.setColor(1,1,1,1)
            end
            yuri:draw()
            love.graphics.setColor(1,1,1,1)
        love.graphics.pop()
    end,

    leave = function(self)

    end
}