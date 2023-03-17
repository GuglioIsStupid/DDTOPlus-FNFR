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
	images.notes,
	{
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: markov purple0000
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: markov purple0001
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: markov purple0002
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: markov purple0003
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: markov purple0004
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: markov purple0005
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: markov purple0006
		{x = 315, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: markov purple0007
		{x = 498, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 9: markov purple0008
		{x = 681, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 10: markov purple0009
		{x = 681, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: markov purple0010
		{x = 681, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: markov purple0011
		{x = 681, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 13: markov purple0012
		{x = 864, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 14: markov purple0013
		{x = 1047, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 15: markov purple0014
		{x = 1230, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 16: markov purple0015
		{x = 1230, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 17: markov purple0016
		{x = 1230, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 18: markov purple0017
		{x = 1230, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 19: markov purple0018
		{x = 1413, y = 660, width = 173, height = 158, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: markov purple0019
		{x = 193, y = 660, width = 51, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 21: markov pruple end hold0000
		{x = 254, y = 660, width = 51, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 22: markov purple hold piece0000
	},
	{
		["end"] = {start = 21, stop = 21, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 1, stop = 20, speed = 24, offsetX = 0, offsetY = 0},
		["hold"] = {start = 22, stop = 22, speed = 0, offsetX = 0, offsetY = 0}
	},
	"on",
	true
)
