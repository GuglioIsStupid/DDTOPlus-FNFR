local highscore = {}
highscore.data = {}

function highscore:save(name, score, mirror)
    if self.data[name .. (mirror and "mirror" or "")] then
        self.data[name .. (mirror and "mirror" or "")] = math.max(self.data[name .. (mirror and "mirror" or "")], score)
    else
        self.data[name .. (mirror and "mirror" or "")] = score
    end
end

function highscore:load()
    return self.data
end

function highscore:reset()
    self.data = {}
end

function highscore:getScore(name)
    return self.data[name] or 0
end

function highscore:getMirrorScore(name)
    return self.data[name .. "mirror"] or 0
end

function highscore:getHighestScore(name)
    return math.max(self:getScore(name), self:getMirrorScore(name))
end

function highscore:saveFile()
    local data = ""
    for k, v in pairs(self.data) do
        k = k:gsub(" ", "_")
        data = data .. k .. " " .. v .. "\n"
    end
    love.filesystem.write("highscore.txt", data)
end

function highscore:loadFile()
    if love.filesystem.getInfo("highscore.txt") then
        local data = love.filesystem.read("highscore.txt")
        for name, score in data:gmatch("(%w+) (%d+)") do
            name = name:gsub("_", " ")
            self.data[name] = tonumber(score)
        end
    end
end

return highscore