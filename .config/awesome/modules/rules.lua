--
local awful = require("awful")

local binds = require("modules/binds")
local tags = require("modules/tags")
local util = require("modules/util")
--


return {
	{
		-- All clients will match this rule.
		rule = {},
		properties = {
			border_width = theme.border_width,
			border_color = theme.border_normal,
			focus = awful.client.focus.filter,
			keys = binds.clientkeys,
			buttons = binds.clientbuttons
		}
	}, {
		rule = { name = "Quake" },
		properties = {
			floating = true,
			-- widgth = 920,
			height = 600,
			-- y = 0,
			-- x = 0,
			maximized_horizontal = true,
			-- maximized_vertical = true,
			skip_taskbar = true
		}
	}, {
		rule = { instance = "geeqie" },
		properties = {
			tag = tags[util.screens.left][6],
			switchtotag = true
		}
	}, {
		rule = { class = "Pidgin" },
		properties = { tag = tags[util.screens.right][8] }
	}, {
		rule_any = {
			instance = {"qalculate-gtk", "gpick"},
			class = {"Gimp", "MPlayer"},
			name = {"CopyQ", "Terminator Preferences"}
		},
		properties = { floating = true }
	}
}