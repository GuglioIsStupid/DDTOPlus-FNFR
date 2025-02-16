return graphics.newSprite(
	graphics.imagePath("dialogue/pixel/monika"),
	{
		{x = 0, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 1: monika_neutral0000
		{x = 106, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 2: monika_hmm0001
		{x = 212, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 3: monika_happy0002
		{x = 318, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 4: monika_uhoh0003
		{x = 0, y = 106, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 5: monika_gasp0004
		{x = 106, y = 106, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 6: monika_sad0005
	},
	{
		["neutral"] = {start = 1, stop = 1, speed = 24, offsetX = 0, offsetY = 0},
		["hmm"] = {start = 2, stop = 2, speed = 24, offsetX = 0, offsetY = 0},
		["happy"] = {start = 3, stop = 3, speed = 24, offsetX = 0, offsetY = 0},
		["uhoh"] = {start = 4, stop = 4, speed = 24, offsetX = 0, offsetY = 0},
		["gasp"] = {start = 5, stop = 5, speed = 24, offsetX = 0, offsetY = 0},
		["sad"] = {start = 6, stop = 6, speed = 24, offsetX = 0, offsetY = 0},
	},
	"neutral",
	false
)