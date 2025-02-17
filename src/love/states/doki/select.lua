local char
local firstStart = true
local optionShit = {}
local addVally = false
local shaker
local shakerPressX, shakerPressY, shakerPressEndX, shakerPressEndY = 1115, 551, 1207, 703

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

        local twenty = {"dokitogether", "yuri", "natsuki", "sayori", "pixelmonika", "senpai"}
        local ten = {"sunnat", "yuritabi", "minusmonikapixel", "yuriken", "sayominus", "cyrixstatic", "zipori", "nathaachama"}
        local two = {"fumo"}
        
        if SaveData.songs.beatFestival then
            table.insert(twenty, "protag")
        end

        if SaveData.songs.beatMonika then
            table.insert(ten, "deeppoems")
            table.insert(ten, "akimonika")
            table.insert(ten, "indiehorror")
        end

        if SaveData.costumeUnlock.unlockAntipathyCostume then
            table.insert(ten, "nathank")
        end

        if util.getModSave(nil, "ShadowMario", "VS Impostor") then
            table.insert(ten, "sayomungus")
        end

        local rand = math.random()
        if rand < 0.6 then
            char = twenty[love.math.random(#twenty)]
        elseif rand > 0.6 and rand < 0.98 then
            char = ten[love.math.random(#ten)]
        else
            char = two[love.math.random(#two)]
        end

        if not love.filesystem.getInfo("sprites/menu/chars/" .. char .. ".lua") then
            char = "dokitogether"
        end
        char = love.filesystem.load("sprites/menu/chars/" .. char .. ".lua")()

        left = graphics.newImage(graphics.imagePath("menu/Credits_LeftSide"))
        left.x = -650

        logo = love.filesystem.load("sprites/menu/logo2.lua")()
        logo.sizeX, logo.sizeY = 0.525, 0.525
        logo.x, logo.y = -615, -210

        graphics:fadeInWipe(0.3)
        curOption = "Story"

        optionShit = {
            {
                "Story",
                pos = {x = -770, y = 0}
            },
            {
                "Freeplay",
                pos = {x = -770, y = 0}
            },
            {
                "Gallery",
                pos = {x = -770, y = 0}
            },
            {
                "Credits",
                pos = {x = -770, y = 0}
            },
            {
                "Options",
                pos = {x = -770, y = 0}
            },
            {
                "Exit Game",
                pos = {x = -770, y = 0}
            }
        }
        -- each option is seperateed by 50 px started at 30
        local function removeFromName(name)
            for i = 1, #optionShit do
                if optionShit[i][1] == name then
                    table.remove(optionShit, i)
                    break
                end
            end
        end
        if not SaveData.songs.beatPrologue then
            --removeFromName("Freeplay")
        end
        if not SaveData.songs.beatProtag then
            removeFromName("Credits")
        end
        if not SaveData.songs.beatSide then
            removeFromName("Gallery")
        end

        for i = 1, #optionShit do
            optionShit[i].pos.y = 30 + (i - 1) * 50
        end

        if firstStart then
            for i = 1, #optionShit do
                Timer.tween(1.2 + i * 0.2, optionShit[i].pos, {x = -600}, "out-elastic")
            end
            Timer.tween(1.2, left, {x = -425}, "out-elastic")
            Timer.tween(1.2, logo, {x = -395}, "out-elastic")
        else
            for i = 1, #optionShit do
                optionShit[i].pos.x = -600
            end
            left.x = -425
            logo.x = -395
        end

        if (not SaveData.songs.beatVA11HallA and SaveData.songs.beatSide) or debug then
            addVally = true
        end

        firstStart = false

        bpm = 120
        beatHit = false
        beat = 0
        beatTimer = 0

        if addVally then
            shaker = love.filesystem.load("sprites/menu/shaker.lua")()
            shaker.x = 525
            shaker.y = 275
            shaker:animate("anim", false)
        end
    end,

    update = function(self, dt)
        if shaker then
            shaker:update(dt)
        end
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
            if shaker then
                shaker:animate("anim")
            end
        end

        if input:pressed("up") then
            local curIndex = 0
            for i = 1, #optionShit do
                if optionShit[i][1] == curOption then
                    curIndex = i
                    break
                end
            end
            if curIndex == 1 then
                curIndex = #optionShit
            else
                curIndex = curIndex - 1
            end
            curOption = optionShit[curIndex][1]
        elseif input:pressed("down") then
            local curIndex = 0
            for i = 1, #optionShit do
                if optionShit[i][1] == curOption then
                    curIndex = i
                    break
                end
            end
            if curIndex == #optionShit then
                curIndex = 1
            else
                curIndex = curIndex + 1
            end
            curOption = optionShit[curIndex][1]
        end

        if input:pressed("confirm") then
            if curOption == "Story" then
                graphics:fadeOutWipe(0.5, function() Gamestate.switch(menuWeek) end)
            elseif curOption == "Freeplay" then
                graphics:fadeOutWipe(0.5, function() Gamestate.switch(menuFreeplay) end)
            elseif curOption == "Options" then
                graphics:fadeOutWipe(0.5, function() Gamestate.switch(menuSettings) end)
            elseif curOption == "Exit Game" then
                graphics.fadeOut(0.5, function() love.event.quit() end)
            end
        elseif input:pressed("back") then
            graphics:fadeOutWipe(0.5, function() Gamestate.switch(menu) end)
        end
    end,

    keypressed = function(self, key)
    end,

    mousepressed = function(self, x, y, button)
        x, y = lovesize.pos(x, y)
        if button == 1 then
            if x > shakerPressX and x < shakerPressEndX and y > shakerPressY and y < shakerPressEndY then
                status.setLoading(true)
                graphics:fadeOutWipe(
                    0.7,
                    function()
                        songAppend = "-hard"
                        storyMode = true
                        music:stop()

                        weeks.SET_WEEK_NUMBER = 13
                        Gamestate.switch(weekData[13], 1, songAppend)

                        status.setLoading(false)
                    end
                )
            end
        end
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
            --[[ borderedText2("Story Mode", storyPos.x, storyPos.y, 0, 1, 1, (curOption ~= "story" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "story" and {1,245/255,245/255} or {1,1,1}))
            borderedText2("Freeplay", freeplayPos.x, freeplayPos.y, 0, 1, 1, (curOption ~= "freeplay" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "freeplay" and {1,245/255,245/255} or {1,1,1}))
            borderedText2("Options", optionsPos.x, optionsPos.y, 0, 1, 1, (curOption ~= "options" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "options" and {1,245/255,245/255} or {1,1,1}))
            borderedText2("Exit Game", exitPos.x, exitPos.y, 0, 1, 1, (curOption ~= "exit" and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= "exit" and {1,245/255,245/255} or {1,1,1})) ]]
            for i = 1, #optionShit do
                borderedText2(optionShit[i][1], optionShit[i].pos.x, optionShit[i].pos.y, 0, 1, 1, (curOption ~= optionShit[i][1] and {1,134/255,215/255} or {1,200/255,215/255}), (curOption ~= optionShit[i][1] and {1,245/255,245/255} or {1,1,1}))
            end
            love.graphics.setFont(lastFont)

            if shaker then
                shaker:draw()
            end
        love.graphics.pop()
    end,

    leave = function(self)
        shaker = nil
    end
}