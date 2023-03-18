local lyrics = {}

lyrics.output = ""
lyrics.timer = 0
lyrics.progress = 1
lyrics.cur = 1

lyrics.list = {}

function lyrics.set(dia)
    -- check if dia is a file or a table
    lyrics.isFile = type(dia) == "string" and true or false
    lyrics.list = lyrics.isFile and {} or dia
    lyrics.cur = 1
    lyrics.timer = 0
    lyrics.progress = 1
    lyrics.output = ""
    lyrics.isDone = false

    if lyrics.isFile then
        for line in love.filesystem.lines(dia) do
            -- text is given like 
            --[[
2456::All this time
2468::I would wait for a chance to be with you
2520::Sing a tune
2534::With me and let's reach for the clouds, in a balloon
2566::The sky knows no bounds
2578::Your hand in mine
2594::Fates intertwined
2610::Through the dark, my voice will be your light
2642::Take the lead, your melody is all I need
2672::Have no fear, let the world feel Our Harmony
2712::
            ]]
            -- use match to get the step and the text
            local split = {line:match("([^:]+)::(.+)")}
            -- add the line to the list
            -- first one is step, second one is text
            table.insert(lyrics.list, {tonumber(split[1]) or 0, split[2] or ""})
        end
    end

    lyrics.output = lyrics.list[lyrics.cur][2] or ""
end

function lyrics.dolyrics(dt)
    if not lyrics.isDone then
        if beatHandler.onStep() then
            local s = beatHandler.curStep
            if s == (lyrics.list[lyrics.cur][1] or 0) then
                -- set the output to the current line
                lyrics.output = lyrics.list[lyrics.cur][2] or ""
                -- increment the current line
                lyrics.cur = lyrics.cur + 1
                -- check if we're done
                if lyrics.cur > #lyrics.list then
                    lyrics.isDone = true
                end
            end
        end
    end
end

function lyrics.draw()
    love.graphics.push()
        -- draw in the middle of the screen
        love.graphics.setColor(1, 1, 1)
        local text = lyrics.output
        local colourInline = {1, 1, 1, 1}
        if not colourInline[4] then colourInline[4] = 1 end
        local colourOutline = {0, 0, 0, 1}
        if not colourOutline[4] then colourOutline[4] = 1 end

        graphics.setColor(colourOutline[1], colourOutline[2], colourOutline[3], colourOutline[4])
        love.graphics.printf(text, -2, 580, 1300, "center")
        love.graphics.printf(text, 2, 580, 1300, "center")
        love.graphics.printf(text, 0, 580-2, 1300, "center")
        love.graphics.printf(text, 0, 580+2, 1300, "center")

        graphics.setColor(colourInline[1], colourInline[2], colourInline[3], colourInline[4])
        love.graphics.printf(text, 0, 580, 1300, "center")
    love.graphics.pop()
end

return lyrics