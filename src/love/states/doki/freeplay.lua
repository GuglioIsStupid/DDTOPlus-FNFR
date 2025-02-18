local singleDiff = {
    "your reality",
    "you and me",
    "takeover medley",
    "libitina",
    "erb"
}
local multiDiff = {
    "epiphany",
    "baka",
    "shrinking violet",
    "love n funkin"
}
local allBeat = false
local pageFlipped = false
local flipSound = love.audio.newSource("sounds/flip_page.ogg", "static")
local curPage = 1
local songs = {}
local grpSongs = {}
local bg
local selectedSong = 1
local previewSong, modifiers, costumeSelect
local stupidIcon
images = {
    icons = love.graphics.newImage(graphics.imagePath("icons"))
}

local function lerp(a, b, t)
    return a + (b - a) * t
end

local function fpsBasedLerp(a, b, t, dt)
    return a + (b - a) * (t * dt)
end

local curScore = 0

return {
    enter = function(self)
        curScore = 0
        if not music:isPlaying() then
			music:play()
		end
        selectedSong = 1
        songs = {}
        grpSongs = {}
        if pageFlipped then
            audio.playSound(flipSound)
        end

        local initSongList = util.coolTextFile("data/freeplay/Page" .. curPage .. ".txt")

        for i = 1, #initSongList do
            local data = util.split(initSongList[i], ":")
            print(data[1], data[2], data[3], data[4], data[5])
            local meta = {
                title = data[1],
                icon = data[2],
                week = data[3],
                songNum = tonumber(data[4]),
                weekIndex = tonumber(data[5])
            }
            if meta.title:lower() == "erb" then
                goto continue
            end
            if meta.title:lower() == "drinks on me" and not SaveData.songs.beatVA11HallA then
                goto continue
            end

            if (tonumber(meta.week) <= SaveData.weekUnlocked) or (tonumber(meta.week) == 1) then
                table.insert(songs, meta)
            end
            ::continue::
        end

        for i = 1, #songs do
            local songName = songs[i].title
            local metadata = json.decode(love.filesystem.read("data/songs/" .. songName:lower() .. "/meta.json"))
            songName = metadata.song.name
            local songText = {
                txt = songName,
                x = -200,
                y = -296 + (i * 47.5),
                icon = songs[i].icon
            }
            table.insert(grpSongs, songText)
        end

        bg = graphics.newImage(graphics.imagePath("freeplay/freeplayBook" .. curPage))
        local isNX = love.system.getOS() == "NX"
        previewSong = graphics.newImage(graphics.imagePath("freeplay/preview" .. (isNX and "_NX" or "")))
        modifiers = graphics.newImage(graphics.imagePath("freeplay/modifiers" .. (isNX and "_NX" or "")))
        costumeSelect = graphics.newImage(graphics.imagePath("freeplay/costume" .. (isNX and "_NX" or "")))

        previewSong.x, previewSong.y = 475, -300
        previewSong.sizeX, previewSong.sizeY = 0.6, 0.6

        modifiers.x, modifiers.y = 475, -185
        modifiers.sizeX, modifiers.sizeY = 0.6, 0.6

        costumeSelect.x, costumeSelect.y = 475, -50
        costumeSelect.sizeX, costumeSelect.sizeY = 0.6, 0.6

        stupidIcon = love.filesystem.load("sprites/icons.lua")()
        stupidIcon.orientation = math.rad(30)
        stupidIcon.sizeX, stupidIcon.sizeY = 1.6, 1.6
        
        stupidIcon.x, stupidIcon.y = 470, 255

        local currentSong = grpSongs[selectedSong]
        stupidIcon:animate(currentSong.icon)

        graphics:fadeInWipe(0.3)
    end,

    changePageHotkey = function(self, page, directPage)
        directPage = directPage == nil and true or directPage

        pageFlipped = true
        curSelected = 1
        local ok

        if directPage then
            curPage = page
            if not SaveData.songs.beatMonika then
                curPage = 1
            end
        else
            ok = self:changePage(page)
        end

        if ok then
            Gamestate.switch(self)
        end
    end,

    changePage = function(self, huh)
        curPage = curPage + huh

        if not SaveData.songs.beatProtag then
            curPage = 1
            return false
        elseif not SaveData.songs.unlockedEpiphany then
            if curPage >= 4 then
                curPage = 1
            end
            if curPage <= 0 then
                curPage = 3
            end
        elseif not SaveData.songs.beatLibitina then
            if curPage >= 5 then
                curPage = 1
            end
            if curPage <= 0 then
                curPage = 4
            end
        else
            if curPage >= 6 then
                curPage = 1
            end
            if curPage <= 0 then
                curPage = 5
            end
        end

        return true
    end,

    update = function(self)
        local song = songs[selectedSong]
        local newSongTitle = song.title
        newSongTitle = newSongTitle:gsub(" %(.-%)", "")
        curScore = fpsBasedLerp(curScore, highscore:getHighestScore(newSongTitle), 10, love.timer.getDelta())
        if input:pressed("confirm") then
            status.setLoading(true)
            graphics:fadeOutWipe(
                0.7,
                function()
                    songAppend = "-hard"
                    storyMode = false
                    music:stop()

                    local song = songs[selectedSong]
                    print(song.weekIndex, weekData[song.weekIndex])
                    weeks.SET_WEEK_NUMBER = song.week
                    Gamestate.switch(weekData[song.weekIndex], song.songNum, songAppend)

                    status.setLoading(false)
                end
            )
        elseif input:pressed("back") then
            status.setLoading(true)
            graphics:fadeOutWipe(
                0.7,
                function()
                    Gamestate.switch(menuSelect)

                    status.setLoading(false)
                end
            )
        end

        if input:pressed("up") then
            selectedSong = selectedSong - 1
            if selectedSong < 1 then
                selectedSong = #grpSongs
            end

            local song = grpSongs[selectedSong]
            stupidIcon:animate(song.icon)
        elseif input:pressed("down") then
            selectedSong = selectedSong + 1
            if selectedSong > #grpSongs then
                selectedSong = 1
            end

            local song = grpSongs[selectedSong]
            stupidIcon:animate(song.icon)
        end

        if input:pressed("left") then
           self:changePageHotkey(-1, false)
        elseif input:pressed("right") then
            self:changePageHotkey(1, false)
        end
    end,

    keypressed = function(self, k)
        if k == "1" then
            self:changePageHotkey(1)
        elseif k == "2" then
            self:changePageHotkey(2)
        elseif k == "3" then
            self:changePageHotkey(3)
        end
    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)

            bg:draw()

            local lastFont = love.graphics.getFont()
            love.graphics.setFont(freeplayFont)
            for i = 1, #grpSongs do
                local song = grpSongs[i]
                if i == selectedSong then
                    love.graphics.setColor(1, 0.5, 0.95)
                    for x = -1, 1 do
                        for y = -1, 1 do
                            love.graphics.print(song.txt, song.x + x, song.y + y)
                        end
                    end
                end
                love.graphics.setColor(0, 0, 0)
                love.graphics.print(song.txt, song.x, song.y)
            end
            love.graphics.setColor(1, 1, 1)
            for x = -1, 1 do
                for y = -1, 1 do
                    love.graphics.print("Personal Best: " .. math.floor(curScore), -200 + x, -300 + y)
                end
            end
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Personal Best: " .. math.floor(curScore), -200, -300)
            love.graphics.setFont(lastFont)
            love.graphics.setColor(1, 1, 1)

            previewSong:draw()
            modifiers:draw()
            costumeSelect:draw()

            stupidIcon:draw()
        love.graphics.pop()
    end
}