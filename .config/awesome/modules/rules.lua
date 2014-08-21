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
			height = 800,
			maximized_horizontal = true,
			sticky = true,
			modal = true,
			skip_taskbar = true
		}
	}, {
		rule = { instance = "geeqie" },
		properties = {
			tag = tags.list[util.screens.left][6],
			switchtotag = true
		}
	}, {
		rule = { class = "Pidgin" },
		properties = { tag = tags.list[util.screens.right][8] }
	}, {
		rule_any = {
			instance = {"qalculate-gtk", "gpick"},
			class = {"Gimp", "MPlayer"},
			name = {"CopyQ", "Zeal", "Terminator Preferences"}
		},
		properties = { floating = true }
	}
}
