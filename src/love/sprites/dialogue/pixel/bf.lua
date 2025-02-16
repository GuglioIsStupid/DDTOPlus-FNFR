return graphics.newSprite(
	graphics.imagePath("dialogue/pixel/bf"),
	{
		{x = 0, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 1: bf_neutral0000
		{x = 106, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 2: bf_angry0001
		{x = 0, y = 106, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 3: bf_what0002
	},
	{
		["neutral"] = {start = 1, stop = 1, speed = 24, offsetX = 0, offsetY = 0},
		["angry"] = {start = 2, stop = 2, speed = 24, offsetX = 0, offsetY = 0},
		["what"] = {start = 3, stop = 3, speed = 24, offsetX = 0, offsetY = 0},
	},
	"neutral",
	false
)