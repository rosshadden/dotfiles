local wezterm = require "wezterm"

return {
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

	-- keys

	enable_csi_u_key_encoding = true,

	keys = {
		-- unmap
		{ key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },

		{ key = "F11", action = "ToggleFullScreen" },
	},

	-- workspaces

	unix_domains = {
		{
			name = "unix",
		},
	},
}
