return graphics.newSprite(
	graphics.imagePath("story/LockedWeek"),
	{
		{x = 0, y = 0, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 1: idle0000
		{x = 0, y = 0, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 2: idle0001
		{x = 423, y = 0, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 3: idle0002
		{x = 423, y = 0, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 4: idle0003
		{x = 0, y = 312, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 5: idle0004
		{x = 0, y = 312, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 6: idle0005
		{x = 423, y = 312, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 7: idle0006
		{x = 423, y = 312, width = 423, height = 312, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 8: idle0007
	},
	{
		["idle"] = {start = 1, stop = 8, speed = 24, offsetX = 0, offsetY = 0},
	},
	"idle",
	false
)