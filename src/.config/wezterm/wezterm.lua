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

	-- workspaces

	unix_domains = {
		{
			name = "unix",
		},
	},
}
