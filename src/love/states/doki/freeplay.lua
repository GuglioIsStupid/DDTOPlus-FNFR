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
return {
    enter = function(self)

    end,

    update = function(self)

    end,

    draw = function(self)
        love.graphics.push()
            love.graphics.translate(graphics.getWidth()/2, graphics.getHeight()/2)
        love.graphics.pop()
    end
}