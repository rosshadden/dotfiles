local wezterm = require "wezterm"

local config = {
	-- startup
	-- default_prog = { "/usr/bin/nu", "-l" },
	default_gui_startup_args = { "connect", "unix" },

	-- fonts
	font_size = 10,
	line_height = 0.8,

	-- ui
	hide_tab_bar_if_only_one_tab = true,

	-- cursor
	force_reverse_video_cursor = true,

	-- more native keys
	enable_csi_u_key_encoding = true,
}

-- mappings
config.keys = {
	-- unmap
	{ mods = "ALT", key = "Enter", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "1", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "2", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "3", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "4", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "5", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "6", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "7", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "8", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "9", action = "DisableDefaultAssignment" },
	{ mods = "ALT", key = "0", action = "DisableDefaultAssignment" },

	-- normalize
	{ mods = "SHIFT", key = " ", action = wezterm.action{ SendString = " " } },
	{ mods = "SHIFT", key = "Backspace", action = wezterm.action{ SendKey = { key = "Backspace" } } },

	{ key = "F11", action = "ToggleFullScreen" },

	-- commands
	-- { mods = "CTRL", key = "R", action = wezterm.action{ SpawnCommand = { args = { "ls" } } } },
}

-- menu
config.launch_menu = {
	{ args = { "htop" }, },
	{ args = { "btm" }, },
}

-- workspaces
config.unix_domains = {
	{
		name = "unix",
	},
}

return config
