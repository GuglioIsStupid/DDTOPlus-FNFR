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
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 67: markov green0000
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 68: markov green0001
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 69: markov green0002
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 70: markov green0003
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 71: markov green0004
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 72: markov green0005
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 73: markov green0006
		{x = 864, y = 494, width = 173, height = 156, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 74: markov green0007
		{x = 1047, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 75: markov green0008
		{x = 1230, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 76: markov green0009
		{x = 1230, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 77: markov green0010
		{x = 1230, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 78: markov green0011
		{x = 1230, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 79: markov green0012
		{x = 1413, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 80: markov green0013
		{x = 1596, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 81: markov green0014
		{x = 1779, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 82: markov green0015
		{x = 1779, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 83: markov green0016
		{x = 1779, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 84: markov green0017
		{x = 1779, y = 494, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 85: markov green0018
		{x = 10, y = 660, width = 173, height = 154, offsetX = 0, offsetY = -2, offsetWidth = 173, offsetHeight = 156}, -- 86: markov green0019
		{x = 742, y = 494, width = 51, height = 65, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 65: markov green hold end0000
		{x = 803, y = 494, width = 51, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 66: markov green hold piece0000
	},
	{
		["on"] = {start = 1, stop = 20, speed = 24, offsetX = 0, offsetY = 0},
		["end"] = {start = 21, stop = 21, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 22, stop = 22, speed = 0, offsetX = 0, offsetY = 0},
	},
	"on",
	true
)
