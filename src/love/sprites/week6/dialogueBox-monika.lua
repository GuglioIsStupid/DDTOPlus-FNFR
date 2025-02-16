return graphics.newSprite(
	graphics.imagePath("dialogue/pixel/dialogueBox-monika"),
	{
		{x = 0, y = 0, width = 249, height = 144, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 1: Text Box Appear instance 10000
		{x = 259, y = 0, width = 249, height = 144, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 2: Text Box Appear instance 10001
		{x = 0, y = 154, width = 249, height = 144, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 3: Text Box Appear instance 10002
		{x = 259, y = 154, width = 249, height = 144, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 4: Text Box Appear instance 10003
		{x = 259, y = 154, width = 249, height = 144, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0, rotated = false}, -- 5: Text Box Appear instance 10004
	},
	{
		["anim"] = {start = 1, stop = 5, speed = 24, offsetX = 0, offsetY = 0},
	},
	"anim",
	false
)