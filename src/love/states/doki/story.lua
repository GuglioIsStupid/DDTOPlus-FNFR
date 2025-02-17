beatTimer = 0
bpm = 120
beat = 0
local weekDataList = {
    {"High School Conflict", "Bara No Yume", "Your Demise", "Your Reality"},
    {"Rain Clouds", "My Confession"},
    {"My Sweets", "Baka"},
    {"Deep Breaths", "Obsession"},
    {"Reconciliation"},
    {"Crucify", "Beathoven", "It's Complicated", "Glitcher"},
    {"Hot Air Balloon", "Shrinking Violet", "Joyride", "Our Harmony"},
    {"NEET", "You and Me", "Takeover Medley"},
    {"Love N' Funkin'", "Constricted", "Catfight", "Wilted"},
}
local weekNames = {
    week1 = "Prologue: Just Monika",
    week2 = "Sayori",
    week3 = "Natsuki",
    week4 = "Yuri",
    week5 = "Monika",
    week6 = "The Festival",
    week7 = "Encore",
    week8 = "Protagonist",
    week9 = "Side Stories"
}
local icons = {}
local grpSprites = {}
local curWeek = 1
local selectSound = love.audio.newSource("sounds/menu/select.ogg", "static")
local confirmSound = love.audio.newSource("sounds/menu/confirm.ogg", "static")
local sideStories
local storyCursor
local inSubstate = false
return {
    enter = function(self)
        storyCursor = graphics.newImage(graphics.imagePath("story/cursor"))
        sideStories = love.filesystem.load("sprites/story/SideStories.lua")()
        sideStories.visible = false
        sideStories.x, sideStories.y = 180, 250
        curWeek = 1
        icons = {
            --internal file name, unlock condition, posX, posY
            -- x spacing is 220
            -- y spacing is 170
            {"Prologue", true, -150, -50},
            {"Sayori", SaveData.songs.beatPrologue, 70, -50},
            {"Natsuki", SaveData.songs.beatSayori, 290, -50},
            {"Yuri", SaveData.songs.beatNatsuki, 510, -50},
            {"Monika", SaveData.songs.beatYuri, -150, 120},
            {"Festival", SaveData.songs.beatMonika, 70, 120},
            {"Encore", SaveData.songs.beatFestival, 290, 120},
            {"Protag", SaveData.songs.beatEncore, 510, 120},
            {"sideStories", SaveData.songs.beatProtag, 0, 0}
        }
        for i = 1, #icons - 1 do
            local dirStuff = "sprites/story/" .. icons[i][1] .. "Week" .. ".lua"
            local storyIcon
            if not icons[i][2] then
                storyIcon = love.filesystem.load("sprites/story/LockedWeek.lua")()
                storyIcon.isLocked = true
            else
                storyIcon = love.filesystem.load(dirStuff)()
            end

            storyIcon.sizeX, storyIcon.sizeY = 0.5, 0.5
            storyIcon.x, storyIcon.y = icons[i][3], icons[i][4]
            storyIcon:animate("idle", true)
            table.insert(grpSprites, storyIcon)
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

        songListSpr = graphics.newImage(graphics.imagePath("story/song_list_lazy_smile"))
        songListSpr.x = -430

        storyCursor.x, storyCursor.y = -150, -50

        self:unlockedWeeks()
        graphics:fadeInWipe(0.3)
    end,

    unlockedWeeks = function(self)
        if SaveData.songs.beatPrologue then
            SaveData.weekUnlocked = 2
        end
        if SaveData.songs.beatSayori then
            SaveData.weekUnlocked = 3
        end
        if SaveData.songs.beatNatsuki then
            SaveData.weekUnlocked = 4
        end
        if SaveData.songs.beatYuri then
            SaveData.weekUnlocked = 5
        end
        if SaveData.songs.beatMonika then
            SaveData.weekUnlocked = 6
        end
        if SaveData.songs.beatFestival then
            SaveData.songs.unlockedEpiphany = true
            SaveData.weekUnlocked = 7
        end
        if SaveData.songs.beatEncore then
            SaveData.weekUnlocked = 8
        end
        if SaveData.songs.beatProtag then
            sideStories.visible = true
            SaveData.weekUnlocked = 9
        end
        if SaveData.songs.beatSide then
            SaveData.weekUnlocked = 10
        end
    end,

    changeItem = function(self, huh, wasRight)
        local prev = curWeek
        curWeek = curWeek + huh

        for i = 1, #grpSprites do
            grpSprites[i]:setFrame(0)
        end
        sideStories:setFrame(0)

        if prev ~= curWeek then
            audio.playSound(selectSound)
        end

        if not SaveData.songs.beatFestival then
            if curWeek > #icons then
                curWeek = 1
            end
            if curWeek < 1 then
                curWeek = #icons
            end

            if curWeek == 9 then
                curWeek = 1
            end
        else
            if curWeek == -4 then
                curWeek = 9
            end
            if curWeek == -3 then
                curWeek = 9
            end
            if curWeek == -2 then
                curWeek = 9
            end
            if curWeek == -1 then
                curWeek = 9
            end
            if curWeek == 0 then
                curWeek = 9
            end

            if curWeek == 10 and not wasRight then
                curWeek = 9
            elseif curWeek == 10 and wasRight then
                curWeek = 1
            end
            if curWeek == 11 then
                curWeek = 9
            end
            if curWeek == 12 then
                curWeek = 9
            end
            if curWeek == 13 then
                curWeek = 9
            end
            
            if curWeek >= 13 then
                curWeek = 1
            end
            if curWeek < 1 then
                curWeek = 12
            end
        end

        if curWeek > #icons then
            curWeek = 1
        elseif curWeek < 1 then
            curWeek = #icons
        end

        if curWeek == 9 then
            sideStories:animate("highlighted", true)
            storyCursor.visible = false
        else
            sideStories:animate("idle", true)
            storyCursor.visible = true
        end

        storyCursor.x = icons[curWeek][3]
        storyCursor.y = icons[curWeek][4]
    end,

    update = function(self, dt)
        if inSubstate then return end
        logo:update(dt)
        scrollingBG:update(dt)

        if curWeek == #icons then
            sideStories:update(dt)
        end
        for i = 1, #grpSprites do
            if i == curWeek then
                grpSprites[i]:update(dt)
            elseif grpSprites[i].isLocked then
                grpSprites[i]:update(dt)
            end
        end

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

        if input:pressed("left") then
            self:changeItem(-1)
        elseif input:pressed("right") then
            self:changeItem(1, true)
        elseif input:pressed("up") then
            self:changeItem(-4)
        elseif input:pressed("down") then
            self:changeItem(4)
        end

        if input:pressed("confirm") then
            self:gotoState()
        elseif input:pressed("back") then
            audio.playSound(selectSound)

            status.setLoading(true)
            graphics:fadeOutWipe(
                0.7,
                function()
                    Gamestate.switch(menuSelect)

                    status.setLoading(false)
                end
            )
        end
    end,

    gotoState = function(self)
        if curWeek ~= 9 then
            status.setLoading(true)
            graphics:fadeOutWipe(
                0.7,
                function()
                    songAppend = "-hard"
                    storyMode = true
                    music:stop()

                    Gamestate.switch(weekData[curWeek], 1, songAppend)

                    status.setLoading(false)
                end
            )
        else
            inSubstate = true
            -- TODO
        end
    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
            scrollingBG:draw()
            left:draw()
            logo:draw()

            songListSpr:draw()

            for i = 1, #grpSprites do
                grpSprites[i]:draw()
            end
            if sideStories.visible then
                sideStories:draw()
            end

            if storyCursor.visible then
                storyCursor:draw()
            end

            local last

            if curWeek == 9 then
                goto continue
            end
            if curWeek == 6 and not SaveData.songs.beatFestival then
                goto continue
            end
            if curWeek == 7 and not SaveData.songs.beatEncore then
                goto continue
            end
            if curWeek == 8 and not SaveData.songs.beatProtag then
                goto continue
            end
            if not icons[curWeek][2] then
                goto continue
            end

            last = love.graphics.getFont()
            love.graphics.setFont(tracklistFont)
            for i = 1, #weekDataList[curWeek] do
                if curWeek == 1 and i == #weekDataList[curWeek] and not SaveData.songs.beatPrologue then
                    goto continue
                elseif curWeek == 8 and i == #weekDataList[curWeek] then
                    goto continue
                end

                love.graphics.setColor(1, 185/255, 221/255)
                for x = -3, 3 do
                    for y = -3, 3 do
                        love.graphics.printf(weekDataList[curWeek][i], -900 + x, 75 + (i * 30) + y, 860, "center")
                    end
                end
                love.graphics.setColor(1, 1, 1)
                love.graphics.printf(weekDataList[curWeek][i], -900, 75 + (i * 30), 860, "center")

                ::continue::
            end

            ::continue::

            local weekName, posX, posY

            if curWeek == 9 then
                goto continue2
            end
            if curWeek == 6 and not SaveData.songs.beatMonika then
                goto continue2
            end
            if curWeek == 7 and not SaveData.songs.beatFestival then
                goto continue2
            end
            if curWeek == 8 and not SaveData.songs.beatEncore then
                goto continue2
            end
            if not icons[curWeek][2] then
                goto continue2
            end

            love.graphics.setFont(weekTitleFont)
            
            weekName = weekNames["week" .. curWeek]
            love.graphics.setColor(248/255, 96/255, 176/255)
            posX, posY = -300, -200
            for x = -3, 3 do
                for y = -3, 3 do
                    love.graphics.printf(weekName, posX + x, posY + y, 860, "center")
                end
            end
            love.graphics.setColor(1, 1, 1)
            love.graphics.printf(weekName, posX, posY, 860, "center")
            if last then
                love.graphics.setFont(last)
            end

            ::continue2::
        love.graphics.pop()
    end
}