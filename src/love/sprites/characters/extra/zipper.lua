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
	love.graphics.newImage(graphics.imagePath("characters/zipper")),
		-- Automatically generated from zipper.xml
		{
			{x = 0, y = 0, width = 659, height = 733, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Idle0000
			{x = 0, y = 0, width = 659, height = 733, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Idle0001
			{x = 659, y = 0, width = 646, height = 730, offsetX = -3, offsetY = -3, offsetWidth = 659, offsetHeight = 733}, -- 3: Idle0002
			{x = 659, y = 0, width = 646, height = 730, offsetX = -3, offsetY = -3, offsetWidth = 659, offsetHeight = 733}, -- 4: Idle0003
			{x = 1305, y = 0, width = 567, height = 695, offsetX = -4, offsetY = -38, offsetWidth = 659, offsetHeight = 733}, -- 5: Idle0004
			{x = 1305, y = 0, width = 567, height = 695, offsetX = -4, offsetY = -38, offsetWidth = 659, offsetHeight = 733}, -- 6: Idle0005
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 7: Idle0006
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 8: Idle0007
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 9: Idle0008
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 10: Idle0009
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 11: Idle0010
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 12: Idle0011
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 13: Idle0012
			{x = 1872, y = 0, width = 536, height = 680, offsetX = -5, offsetY = -53, offsetWidth = 659, offsetHeight = 733}, -- 14: Idle0013
			{x = 2408, y = 0, width = 697, height = 611, offsetX = 0, offsetY = -10, offsetWidth = 697, offsetHeight = 621}, -- 15: Sing Down0000
			{x = 3105, y = 0, width = 678, height = 621, offsetX = -9, offsetY = 0, offsetWidth = 697, offsetHeight = 621}, -- 16: Sing Down0001
			{x = 0, y = 733, width = 795, height = 654, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: Sing Left0000
			{x = 795, y = 733, width = 781, height = 634, offsetX = -13, offsetY = -20, offsetWidth = 795, offsetHeight = 654}, -- 18: Sing Left0001
			{x = 1576, y = 733, width = 818, height = 713, offsetX = 0, offsetY = -9, offsetWidth = 818, offsetHeight = 722}, -- 19: Sing Right0000
			{x = 2394, y = 733, width = 817, height = 722, offsetX = 0, offsetY = 0, offsetWidth = 818, offsetHeight = 722}, -- 20: Sing Right0001
			{x = 3211, y = 733, width = 636, height = 778, offsetX = 0, offsetY = 0, offsetWidth = 644, offsetHeight = 778}, -- 21: Sing Up0000
			{x = 0, y = 1511, width = 622, height = 761, offsetX = -22, offsetY = -16, offsetWidth = 644, offsetHeight = 778}, -- 22: Sing Up0001
			{x = 622, y = 1511, width = 722, height = 677, offsetX = -8, offsetY = -33, offsetWidth = 731, offsetHeight = 711}, -- 23: scream0000
			{x = 1344, y = 1511, width = 731, height = 711, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 24: scream0001
			{x = 2075, y = 1511, width = 721, height = 697, offsetX = -10, offsetY = -14, offsetWidth = 731, offsetHeight = 711} -- 25: scream0002
		},
	{
		["singDOWN"] = {start = 15, stop = 16, speed = 24, offsetX = 66, offsetY = -64},
		["singLEFT"] = {start = 17, stop = 18, speed = 24, offsetX = 10, offsetY = -41},
		["singRIGHT"] = {start = 19, stop = 20, speed = 24, offsetX = 153, offsetY = -19},
		["singUP"] = {start = 21, stop = 22, speed = 24, offsetX = 118, offsetY = 22},

		["idle"] = {start = 1, stop = 14, speed = 24, offsetX = 0, offsetY = 0},
		["scream"] = {start = 23, stop = 25, speed = 24, offsetX = 224, offsetY = -18},
	},
	"idle",
	false,
	{
		isCharacter = true,
		danceSpeed = 2,
		sing_duration = 4,
		icon = "zipper"
	}
)
