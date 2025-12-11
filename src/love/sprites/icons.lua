--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

return graphics.newSprite(
    images.icons,
	{
		{x = 0, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend
		{x = 150, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Boyfriend Losing
		{x = 300, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: Boyfriend Winning

		{x = 450, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: Pixel Boyfriend
		{x = 600, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: Pixel Boyfriend Losing
		{x = 750, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: Pixel Boyfriend Winning

		{x = 900, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: Sayori
		{x = 1050, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: Sayori Losing
		{x = 1200, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: Sayori Winning

		{x = 0, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: Natsuki
		{x = 150, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: Natsuki Losing
		{x = 300, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: Natsuki Winning
		
		{x = 450, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: Yuri
		{x = 600, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: Yuri Losing
		{x = 750, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: Yuri Winning

		{x = 900, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: Yuri Insane
		{x = 1050, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: Yuri Insane Losing
		{x = 1200, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: Yuri Insane Winning

		{x = 0, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: Monika
		{x = 150, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: Monika Losing
		{x = 300, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: Monika Winning

		{x = 450, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 22: Our Harmony
		{x = 600, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 23: Our Harmony Losing
		{x = 750, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 24: Our Harmony Winning

		{x = 900, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 25: Protag
		{x = 1050, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 26: Protag Losing
		{x = 1200, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 27: Protag Winning

		{x = 0, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 28: Monika Pixel
		{x = 150, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 29: Monika Pixel Losing
		{x = 300, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 30: Monika Pixel Winning

		{x = 450, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 31: Demise
		{x = 600, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 32: Demise Losing
		{x = 750, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 33: Demise Winning

		{x = 900, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 34: Duet
		{x = 1050, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 35: Duet Losing
		{x = 1200, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 36: Duet Winning

		{x = 0, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 37: Girlfriend
		{x = 150, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 38: Girlfriend Losing
		{x = 300, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 39: Girlfriend Winning

		{x = 450, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 40: Dual Demise
		{x = 600, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 41: Dual Demise Losing
		{x = 750, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 42: Dual Demise Winning

		{x = 1350, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 43: Catfight
		{x = 1350, y = 150, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 44: File
		{x = 1350, y = 300, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 45: Shaker
		{x = 1350, y = 450, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 46: Pen
		{x = 1350, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 47: Pen Demise
		{x = 1350, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 48: Pen
		{x = 1350, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 49: Mic
		{x = 1350, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 50: Libitina

		{x = 900, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 51: Senpai
		{x = 1050, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 52: Senpai Losing
		{x = 1200, y = 600, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 53: Senpai Winning

		{x = 900, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 54: Senpai real
		{x = 1050, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 55: Senpai real Losing
		{x = 1200, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 56: Senpai real Winning

		{x = 900, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 57: Soft
		{x = 1050, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 58: Soft Losing
		{x = 1200, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 59: Soft Winning

		{x = 450, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 60: Zipper
		{x = 600, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 61: Zipper Losing
		{x = 750, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 62: Zipper Winning

		{x = 450, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 63: MrCow
		{x = 600, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 64: MrCow Losing
		{x = 750, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 65: MrCow Winning

		{x = 450, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 66: Minus
		{x = 600, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 67: Minus Losing
		{x = 750, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 68: Minus Winning

		{x = 900, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 69: Minus Yellow
		{x = 1050, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 70: Minus Yellow Losing
		{x = 1200, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 71: Minus Yellow Winning

		{x = 0, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 72: Bigika
		{x = 150, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 73: Bigika Losing
		{x = 300, y = 750, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 74: Bigika Winning

		{x = 0, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 75: Jill
		{x = 150, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 76: Jill Losing
		{x = 300, y = 900, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 77: Jill Winning

		{x = 0, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 78: Holofunk
		{x = 150, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 79: Holofunk Losing
		{x = 300, y = 1050, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 80: Holofunk Winning

		{x = 1350, y = 0, width = 1, height = 1, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 61: None
	},
	{
		["boyfriend"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend losing"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend winning"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},

		["boyfriend (pixel)"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend (pixel) losing"] = {start = 5, stop = 5, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend (pixel) winning"] = {start = 6, stop = 6, speed = 0, offsetX = 0, offsetY = 0},

		["sayori"] = {start = 7, stop = 7, speed = 0, offsetX = 0, offsetY = 0},
		["sayori losing"] = {start = 8, stop = 8, speed = 0, offsetX = 0, offsetY = 0},
		["sayori winning"] = {start = 9, stop = 9, speed = 0, offsetX = 0, offsetY = 0},

		["natsuki"] = {start = 10, stop = 10, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki losing"] = {start = 11, stop = 11, speed = 0, offsetX = 0, offsetY = 0},
		["natsuki winning"] = {start = 12, stop = 12, speed = 0, offsetX = 0, offsetY = 0},

		["yuri"] = {start = 13, stop = 13, speed = 0, offsetX = 0, offsetY = 0},
		["yuri losing"] = {start = 14, stop = 14, speed = 0, offsetX = 0, offsetY = 0},
		["yuri winning"] = {start = 15, stop = 15, speed = 0, offsetX = 0, offsetY = 0},

		["yuri insane"] = {start = 16, stop = 16, speed = 0, offsetX = 0, offsetY = 0},
		["yuri insane losing"] = {start = 17, stop = 17, speed = 0, offsetX = 0, offsetY = 0},
		["yuri insane winning"] = {start = 18, stop = 18, speed = 0, offsetX = 0, offsetY = 0},

		["monika"] = {start = 19, stop = 19, speed = 0, offsetX = 0, offsetY = 0},
		["monika losing"] = {start = 20, stop = 20, speed = 0, offsetX = 0, offsetY = 0},
		["monika winning"] = {start = 21, stop = 21, speed = 0, offsetX = 0, offsetY = 0},

		["our harmony"] = {start = 22, stop = 22, speed = 0, offsetX = 0, offsetY = 0},
		["our harmony losing"] = {start = 23, stop = 23, speed = 0, offsetX = 0, offsetY = 0},
		["our harmony winning"] = {start = 24, stop = 24, speed = 0, offsetX = 0, offsetY = 0},

		["protag"] = {start = 25, stop = 25, speed = 0, offsetX = 0, offsetY = 0},
		["protag losing"] = {start = 26, stop = 26, speed = 0, offsetX = 0, offsetY = 0},
		["protag winning"] = {start = 27, stop = 27, speed = 0, offsetX = 0, offsetY = 0},

		["monika pixel"] = {start = 28, stop = 28, speed = 0, offsetX = 0, offsetY = 0},
		["monika pixel losing"] = {start = 29, stop = 29, speed = 0, offsetX = 0, offsetY = 0},
		["monika pixel winning"] = {start = 30, stop = 30, speed = 0, offsetX = 0, offsetY = 0},

		["demise"] = {start = 31, stop = 31, speed = 0, offsetX = 0, offsetY = 0},
		["demise losing"] = {start = 32, stop = 32, speed = 0, offsetX = 0, offsetY = 0},
		["demise winning"] = {start = 33, stop = 33, speed = 0, offsetX = 0, offsetY = 0},

		["duet"] = {start = 34, stop = 34, speed = 0, offsetX = 0, offsetY = 0},
		["duet losing"] = {start = 35, stop = 35, speed = 0, offsetX = 0, offsetY = 0},
		["duet winning"] = {start = 36, stop = 36, speed = 0, offsetX = 0, offsetY = 0},

		["girlfriend"] = {start = 37, stop = 37, speed = 0, offsetX = 0, offsetY = 0},
		["girlfriend losing"] = {start = 38, stop = 38, speed = 0, offsetX = 0, offsetY = 0},
		["girlfriend winning"] = {start = 39, stop = 39, speed = 0, offsetX = 0, offsetY = 0},

		["dual demise"] = {start = 40, stop = 40, speed = 0, offsetX = 0, offsetY = 0},
		["dual demise losing"] = {start = 41, stop = 41, speed = 0, offsetX = 0, offsetY = 0},
		["dual demise winning"] = {start = 42, stop = 42, speed = 0, offsetX = 0, offsetY = 0},

		["senpai"] = {start = 51, stop = 51, speed = 0, offsetX = 0, offsetY = 0},
		["senpai losing"] = {start = 52, stop = 52, speed = 0, offsetX = 0, offsetY = 0},
		["senpai winning"] = {start = 53, stop = 53, speed = 0, offsetX = 0, offsetY = 0},

		["senpai real"] = {start = 54, stop = 54, speed = 0, offsetX = 0, offsetY = 0},
		["senpai real losing"] = {start = 55, stop = 55, speed = 0, offsetX = 0, offsetY = 0},
		["senpai real winning"] = {start = 56, stop = 56, speed = 0, offsetX = 0, offsetY = 0},

		["soft"] = {start = 57, stop = 57, speed = 0, offsetX = 0, offsetY = 0},
		["soft losing"] = {start = 58, stop = 58, speed = 0, offsetX = 0, offsetY = 0},
		["soft winning"] = {start = 59, stop = 59, speed = 0, offsetX = 0, offsetY = 0},

		["zipper"] = {start = 60, stop = 60, speed = 0, offsetX = 0, offsetY = 0},
		["zipper losing"] = {start = 61, stop = 61, speed = 0, offsetX = 0, offsetY = 0},
		["zipper winning"] = {start = 62, stop = 62, speed = 0, offsetX = 0, offsetY = 0},

		["mrcow"] = {start = 63, stop = 63, speed = 0, offsetX = 0, offsetY = 0},
		["mrcow losing"] = {start = 64, stop = 64, speed = 0, offsetX = 0, offsetY = 0},
		["mrcow winning"] = {start = 65, stop = 65, speed = 0, offsetX = 0, offsetY = 0},

		["minus"] = {start = 66, stop = 66, speed = 0, offsetX = 0, offsetY = 0},
		["minus losing"] = {start = 67, stop = 67, speed = 0, offsetX = 0, offsetY = 0},
		["minus winning"] = {start = 68, stop = 68, speed = 0, offsetX = 0, offsetY = 0},

		["minus yellow"] = {start = 69, stop = 69, speed = 0, offsetX = 0, offsetY = 0},
		["minus yellow losing"] = {start = 70, stop = 70, speed = 0, offsetX = 0, offsetY = 0},
		["minus yellow winning"] = {start = 71, stop = 71, speed = 0, offsetX = 0, offsetY = 0},

		["bigika"] = {start = 72, stop = 72, speed = 0, offsetX = 0, offsetY = 0},
		["bigika losing"] = {start = 73, stop = 73, speed = 0, offsetX = 0, offsetY = 0},
		["bigika winning"] = {start = 74, stop = 74, speed = 0, offsetX = 0, offsetY = 0},

		["jill"] = {start = 75, stop = 75, speed = 0, offsetX = 0, offsetY = 0},
		["jill losing"] = {start = 76, stop = 76, speed = 0, offsetX = 0, offsetY = 0},
		["jill winning"] = {start = 77, stop = 77, speed = 0, offsetX = 0, offsetY = 0},

		["holofunk"] = {start = 78, stop = 78, speed = 0, offsetX = 0, offsetY = 0},
		["holofunk losing"] = {start = 79, stop = 79, speed = 0, offsetX = 0, offsetY = 0},
		["holofunk winning"] = {start = 80, stop = 80, speed = 0, offsetX = 0, offsetY = 0},

		["catfight"] = {start = 43, stop = 43, speed = 0, offsetX = 0, offsetY = 0},
		["file"] = {start = 44, stop = 44, speed = 0, offsetX = 0, offsetY = 0},
		["shaker"] = {start = 45, stop = 45, speed = 0, offsetX = 0, offsetY = 0},
		["pen"] = {start = 46, stop = 46, speed = 0, offsetX = 0, offsetY = 0},
		["pen demise"] = {start = 47, stop = 47, speed = 0, offsetX = 0, offsetY = 0},
		["pen alt"] = {start = 48, stop = 48, speed = 0, offsetX = 0, offsetY = 0},
		["mic"] = {start = 49, stop = 49, speed = 0, offsetX = 0, offsetY = 0},
		["libitina"] = {start = 50, stop = 50, speed = 0, offsetX = 0, offsetY = 0},

		["none"] = {start = 81, stop = 81, speed = 0, offsetX = 0, offsetY = 0},
	},
	"boyfriend",
	false
)
