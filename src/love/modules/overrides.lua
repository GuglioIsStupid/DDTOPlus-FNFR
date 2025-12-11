local o_love_audio_newSource = love.audio.newSource
---@diagnostic disable-next-line: duplicate-set-field
function love.audio.newSource(file, type)
    type = type or "static"
    local source = o_love_audio_newSource(file, type)
    local mt = getmetatable(source)

    local o_play = mt.play
    function mt:play(dontrestart)
        if not dontrestart and self:isPlaying() then
            self:stop()
        end
        o_play(self)
    end

    return source
end
