--
local awful = require("awful")

local binds = require("modules/binds")
local tags = require("modules/tags")
local util = require("modules/util")
--


return {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = theme.border_width,
			border_color = theme.border_normal,
			focus = awful.client.focus.filter,
			keys = binds.clientkeys,
			buttons = binds.clientbuttons
		}
	}, {
		rule = { class = "MPlayer" },
		properties = { floating = true }
	}, {
		rule = { instance = "qalculate-gtk" },
		properties = { floating = true }
	}, {
		rule = { class = "pinentry" },
		properties = { floating = true }
	}, {
		rule = { class = "gimp" },
		properties = { floating = true }
	-- }, {
	-- 	rule = { class = "Chrome" },
	-- 	properties = { tag = tags[util.screens.left][1] }
	-- }, {
	-- 	rule = { instance = "spacefm" },
	-- 	properties = { tag = tags[util.screens.left][5] }
	}, {
		rule = { instance = "geeqie" },
		properties = { tag = tags[util.screens.left][6] }
	}, {
		rule = { instance = "skype" },
		properties = { tag = tags[util.screens.right][7] }
	}, {
		rule = { class = "Pidgin" },
		properties = { tag = tags[util.screens.right][8] }
	-- }, {
	-- 	rule = { instance = "subl" },
	-- 	properties = { tag = tags[util.screens.right][2] }
	}
}
