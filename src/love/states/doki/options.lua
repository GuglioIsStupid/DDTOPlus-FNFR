local currentSection = ""
local sections = {
    "Gameplay",
    "Keybinds",
    "Save"
}
local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")

local options = {
    Gameplay = {
        {
            txt = "%s",
            rendered = "",
            type = "select",
            options = {"Upscroll", "Downscroll"},
            onRender = function(self, value)
                -- if true, it's downscroll
                local v = settings.downscroll
                return string.format(self.txt, self.options[v and 2 or 1])
            end,
            onHit = function(self)
                settings.downscroll = not settings.downscroll
                print("Changed downscroll to", settings.downscroll)
            end,
            desc = "Change the direction of incoming notes."
        },
        {
            txt = "%s",
            rendered = "",
            type = "select",
            options = {"Sidescroll", "Middlescroll"},
            onRender = function(self, value)
                -- if true, it's downscroll
                local v = settings.middleScroll
                return string.format(self.txt, self.options[v and 2 or 1])
            end,
            onHit = function(self)
                settings.middleScroll = not settings.middleScroll
            end,
            desc = "Put your notes in the center or to the right of the screen"
        },
        {
            txt = "%s",
            rendered = "",
            type = "select",
            options = {"No Ghost Tapping", "Ghost Tapping"},
            onRender = function(self, value)
                -- if true, it's downscroll
                local v = settings.ghostTapping
                return string.format(self.txt, self.options[v and 2 or 1])
            end,
            onHit = function(self)
                settings.ghostTapping = not settings.ghostTapping
            end,
            desc = "Determines whether or not tapping outside of incooming notes will reduce your health."
        },
        {
            txt = "Scroll Underlay %d%%",
            type = "slider", -- Not really, but you press left/right to change 5%
            rendered = "",
            onRender = function(self, value)
                local v = settings.scrollUnderlayTrans
                return string.format(self.txt, math.floor(v * 100))
            end,
            onHit = function(self, dir)
                local v = settings.scrollUnderlayTrans * 100
                -- instead of 0-1, use 0-100 temporarily due to floating point precision issues
                v = v + (dir == 1 and 5 or -5)
                if v > 100 then
                    v = 100
                elseif v < 0 then
                    v = 0
                end
                settings.scrollUnderlayTrans = v / 100
            end,
            desc = "Determines the transparency of the scroll underlay."
        },
        {
            -- 1 decimal point
            txt = "Scroll Speed %.1f",
            rendered = "",
            type = "slider",
            onRender = function(self, value)
                local v = settings.customScrollSpeed
                return string.format(self.txt, v)
            end,
            onHit = function(self, dir)
                local v = settings.customScrollSpeed * 10
                v = v + (dir == 1 and 1 or -1)
                if v > 100 then
                    v = 10
                elseif v < 1 then
                    v = 1
                end

                settings.customScrollSpeed = v / 10
            end,
            desc = "Determines the speed of the scroll. 1 = Determined by the song."
        },
    },
    Keybinds = {},
    Save = {
        {
            txt = "Self Awareness %s",
            rendered = "Self Awareness %s",
            type = "boolean",
            onHit = function()
                settings.selfAwareness = not settings.selfAwareness
            end,
            onRender = function(self)
                local v = settings.selfAwareness
                return string.format(self.rendered, v and "On" or "Off")
            end,
            desc = "..."
        },
        debug and {
            txt = "Unlock All",
            type = "boolean",
            onHit = function()
                UNLOCKED_ALL = true
                SaveData.weekUnlocked = 10
                print("Unlocked")
                for i, v in pairs(SaveData.songs) do
                    if type(v) == "boolean" then
                        SaveData.songs[i] = true
                    end
                end
            end,
            desc = "Unlocks everything that's offered in this game. Does not unlock costumes with requirements."
        } or nil,
        {
            txt = "Reset Score Data",
            secondary = "Confirm Reset Score Data",
            hitOnce = false,
            type = "callTwice",
            onHit = function()
                -- Nothing
            end,
            onHitTwice = function()
                highscore:reset()
            end,
            desc = "Reset your score save data to its defaults. This will also affect certain unlocks. (CANNOT BE REVERSED)"
            -- if theres no "onRender" function or rendered string, it will just render the txt
        },
        {
            txt = "Reset Story Data",
            secondary = "Confirm Reset Story Data",
            hitOnce = false,
            type = "callTwice",
            onHit = function()
                -- Nothing
            end,
            onHitTwice = function()
                SaveData.weekUnlocked = 1
                for i, v in pairs(SaveData.songs) do
                    if type(v) == "boolean" then
                        SaveData.songs[i] = false
                    end
                end
            end,
            desc = "Reset your story save data to its defaults. This will also affect certain unlocks. (CANNOT BE REVERSED)"
        },
        {
            txt = "Delete Save Data",
            secondary = "Confirm Delete Save Data",
            hitOnce = false,
            type = "callTwice",
            onHit = function()
                -- Nothing
            end,
            onHitTwice = function()
                -- do both
                highscore:reset()
                SaveData.weekUnlocked = 1
                for i, v in pairs(SaveData.songs) do
                    if type(v) == "boolean" then
                        SaveData.songs[i] = false
                    end
                end
            end,
            desc = "Deletes your save file entirely. (CANNOT BE REVERSED)"
        }
    }
}

local curSection = 1
local curSetting = 1
return {
    enter = function(self)
        if not music:isPlaying() then
            music:play()
        end
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

        left = graphics.newImage(graphics.imagePath("menu/Credits_LeftSide"))
        left.x = -425

        logo = love.filesystem.load("sprites/menu/logo2.lua")()
        logo.sizeX, logo.sizeY = 0.525, 0.525
        logo.x, logo.y = -395, -210
    end,

    update = function(self, dt)
        scrollingBG:update(dt)
        logo:update(dt)

        beatTimer = beatTimer + dt * 1000
        if beatTimer >= 60000 / bpm then
            beatTimer = 0
            beat = beat + 1
            beatHit = true
        else
            beatHit = false
        end

        if input:pressed("down") then
            if currentSection == "" then
                curSection = curSection + 1
                if curSection > #sections then
                    curSection = 1
                end
            else
                curSetting = curSetting + 1
                if curSetting > #options[currentSection] then
                    curSetting = 1
                end
            end
        elseif input:pressed("up") then
            if currentSection == "" then
                curSection = curSection - 1
                if curSection < 1 then
                    curSection = #sections
                end
            else
                curSetting = curSetting - 1
                if curSetting < 1 then
                    curSetting = #options[currentSection]
                end
            end
        end

        if input:pressed("confirm") then
            confirmSound:play()
            if currentSection == "" then
                if curSection == 2 then
                    Gamestate.switch(settingsKeybinds)
                else
                    currentSection = sections[curSection]
                end
            else
                local setting = options[currentSection][curSetting]
                if setting.type == "boolean" or setting.type == "select" then
                    setting:onHit()
                elseif setting.type == "callTwice" then
                    if setting.hitOnce then
                        setting:onHitTwice()
                        setting.hitOnce = false
                    else
                        setting:onHit()
                        setting.hitOnce = true
                    end
                end
            end
        end

        if currentSection ~= "" then
            if input:pressed("left") then
                selectSound:play()
                local setting = options[currentSection][curSetting]
                if setting.type == "slider" then
                    setting:onHit(-1)
                end
            elseif input:pressed("right") then
                selectSound:play()
                local setting = options[currentSection][curSetting]
                if setting.type == "slider" then
                    setting:onHit(1)
                end
            end
        end

        if input:pressed("back") then
            selectSound:play()
            if currentSection == "" then
                Gamestate.switch(menuSelect)
            else
                currentSection = ""
            end
        end

        if beatHit then
            logo:animate("anim")
        end
    end,

    borderText = function(self, txt, x, y, size, font, bCol, inCol)
        local last = love.graphics.getFont()
        love.graphics.setFont(font)
        love.graphics.setColor(bCol)
        for i = -size, size do
            for j = -size, size do
                love.graphics.print(txt, x + i, y + j)
            end
        end
        love.graphics.setColor(inCol)
        love.graphics.print(txt, x, y)
        love.graphics.setFont(last)
    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
            scrollingBG:draw()
            left:draw()
            logo:draw()
            if currentSection == "" then
                for i = 1, #sections do
                    local col = {1, 124/255, 1}
                    if i == curSection then
                        col = {1, 205/255, 1}
                    end
                    self:borderText(sections[i], -180, -300 + (i - 1) * 50, 2, optionsFont, col, {1, 1, 1})
                end

                love.graphics.setColor(0, 0, 0, 0.4)
                love.graphics.rectangle("fill", -graphics.getWidth()/2, graphics.getHeight()/2 - 25, graphics.getWidth(), 50)
                self:borderText("Please select a category.", -635, graphics.getHeight()/2 - 22, 1, optionDescFont, {0, 0, 0}, {1, 1, 1})
            else
                local section = options[currentSection]
                for i = 1, #section do
                    local col = {1, 124/255, 1}
                    if i == curSetting then
                        col = {1, 205/255, 1}
                    end
                    local opt = section[i]
                    --[[ local txt = opt:onRender() ]]
                    local txt = opt.txt
                    if opt.onRender then
                        txt = opt:onRender()
                    end
                    if opt.hitOnce then
                        txt = opt.secondary
                    end
                    self:borderText(txt, -180, -300 + (i - 1) * 50, 2, optionsFont, col, {1, 1, 1})
                end

                love.graphics.setColor(0, 0, 0, 0.4)
                love.graphics.rectangle("fill", -graphics.getWidth()/2, graphics.getHeight()/2 - 25, graphics.getWidth(), 50)
                self:borderText(section[curSetting].desc, -635, graphics.getHeight()/2 - 22, 1, optionDescFont, {0, 0, 0}, {1, 1, 1})
            end
        love.graphics.pop()
    end
}