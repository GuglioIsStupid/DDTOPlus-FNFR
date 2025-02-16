return graphics.newSprite(
	graphics.imagePath("dialogue/pixel/senpai"),
	{
		{x = 0, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 1: senpai_neutral0000
		{x = 106, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 2: senpai_angry0001
		{x = 212, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 3: senpai_whodis0002
		{x = 318, y = 0, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 4: senpai_hmm0003
		{x = 0, y = 106, width = 106, height = 106, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 5: senpai_spirit0004
	},
	{
		["neutral"] = {start = 1, stop = 1, speed = 24, offsetX = 0, offsetY = 0},
		["angry"] = {start = 2, stop = 2, speed = 24, offsetX = 0, offsetY = 0},
		["whodis"] = {start = 3, stop = 3, speed = 24, offsetX = 0, offsetY = 0},
		["hmm"] = {start = 4, stop = 4, speed = 24, offsetX = 0, offsetY = 0},
		["spirit"] = {start = 5, stop = 5, speed = 24, offsetX = 0, offsetY = 0},
	},
	"neutral",
	false
)