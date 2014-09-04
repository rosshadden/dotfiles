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
			-- floating = true,
			-- height = 800,
			-- fullscreen = true,
			maximized = true,
			-- maximized_horizontal = true,
			-- maximized_vertical = true,
			sticky = true,
			-- modal = true,
			skip_taskbar = true
		}
	}, {
		rule = { instance = "spotify" },
		properties = {
			tag = tags.list[util.screens.left][6],
		}
	}, {
		rule = { instance = "geeqie" },
		properties = {
			fullscreen = true
		}
	}, {
		rule = { class = "Pidgin" },
		properties = { tag = tags.list[util.screens.right][8] }
	}, {
		rule_any = {
			instance = { "qalculate-gtk", "gpick", "geeqie" },
			class = { "Gimp", "MPlayer" },
			name = { "CopyQ", "Zeal", "Terminator Preferences" }
		},
		properties = { floating = true }
	}
}
