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
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: markov blue0000
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 46: markov blue0001
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 47: markov blue0002
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 48: markov blue0003
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 49: markov blue0004
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 50: markov blue0005
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 51: markov blue0006
		{x = 1432, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 52: markov blue0007
		{x = 1615, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 53: markov blue0008
		{x = 1798, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 54: markov blue0009
		{x = 1798, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 55: markov blue0010
		{x = 1798, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 56: markov blue0011
		{x = 1798, y = 254, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 57: markov blue0012
		{x = 10, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 58: markov blue0013
		{x = 193, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 59: markov blue0014
		{x = 376, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 60: markov blue0015
		{x = 376, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 61: markov blue0016
		{x = 376, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 62: markov blue0017
		{x = 376, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 63: markov blue0018
		{x = 559, y = 494, width = 173, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 20: markov blue0019
		{x = 1310, y = 254, width = 51, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 43: markov blue hold end0000
		{x = 1371, y = 254, width = 51, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 44: markov blue hold piece0000
	},
	{
		["on"] = {start = 1, stop = 20, speed = 24, offsetX = 0, offsetY = 0},
		["end"] = {start = 21, stop = 21, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 22, stop = 22, speed = 0, offsetX = 0, offsetY = 0},
	},
	"on",
	true
)
