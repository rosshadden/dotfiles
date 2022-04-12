local wezterm = require "wezterm"

function tablfy(value)
	result = {}
	for match in (value .. " "):gmatch("(.-)" .. " ") do
		table.insert(result, match)
	end
	return result
end

local config = {
	key_tables = {},

	-- startup
	default_gui_startup_args = { "connect", "unix" },
	term = "wezterm",

	-- fonts
	font_size = 10,
	line_height = 0.8,
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		-- "Fira Code",
		"Noto Color Emoji",
		"Unifont",
	}),

	-- ui
	color_scheme = "Paraiso Dark",
	window_background_opacity = 0.95,

	-- cursor
	force_reverse_video_cursor = true,

	-- more native keys
	enable_csi_u_key_encoding = true,
}

-- mappings

config.leader = { mods = "CTRL", key = "Space" }

config.keys = {
	-- unmap
	{ mods = "ALT", key = "Enter", action = "DisableDefaultAssignment" },

	-- normalize
	{ mods = "SHIFT", key = " ", action = wezterm.action{ SendString = " " } },
	{ mods = "SHIFT", key = "Backspace", action = wezterm.action{ SendKey = { key = "Backspace" } } },

	-- modes
	{ mods = "LEADER", key = "a", action = wezterm.action{ ActivateKeyTable = { name = "app" } } },
	{ mods = "LEADER", key = "b", action = wezterm.action{ ActivateKeyTable = { name = "panes" } } },
	{ mods = "LEADER", key = "c", action = "ActivateCopyMode" },
	{ mods = "LEADER", key = "r", action = wezterm.action{ ActivateKeyTable = { name = "resize", one_shot = false } } },
	{ mods = "LEADER", key = "t", action = wezterm.action{ ActivateKeyTable = { name = "tabs" } } },

	-- navigation
	{ mods = "LEADER", key = "Tab", action = "ActivateLastTab" },
	{ mods = "LEADER", key = "p", action = wezterm.action{ ActivateTabRelative = -1 } },
	{ mods = "LEADER", key = "n", action = wezterm.action{ ActivateTabRelative = 1 } },
	{ mods = "ALT", key = "j", action = wezterm.action{ ActivatePaneDirection = "Down" } },
	{ mods = "ALT", key = "k", action = wezterm.action{ ActivatePaneDirection = "Up" } },
	{ mods = "ALT", key = "h", action = wezterm.action{ ActivatePaneDirection = "Left" } },
	{ mods = "ALT", key = "l", action = wezterm.action{ ActivatePaneDirection = "Right" } },

	-- debug
	{
		mods = "LEADER", key = "Backspace",
		action = wezterm.action_callback(function(win, pane)
			os.execute("notify-send debug 'title: " .. pane:get_title() .. "\nprocess: " .. pane:get_foreground_process_name() .. "\ncwd: " .. pane:get_current_working_dir() .. "'")
		end)
	},
}

local exitMappings = {
	{ key = "Escape", action = "PopKeyTable" },
	{ key = "q", action = "PopKeyTable" },
}

config.key_tables.app = {
	{ key = "f", action = "ToggleFullScreen" },
	{ key = "l", action = "ShowLauncher" },
	{ key = "r", action = "ReloadConfiguration" },
}

config.key_tables.tabs = {
	{ key = "Space", action = "ShowTabNavigator" },
	{ key = "Tab", action = "ActivateLastTab" },
	{ key = "`", action = wezterm.action{ ActivateTab = -1 } },

	{ key = "n", action = wezterm.action{ SpawnTab = "CurrentPaneDomain" } },
	{ key = "c", action = wezterm.action{ CloseCurrentTab = { confirm = true } } },
	{ key = "C", action = wezterm.action{ CloseCurrentTab = { confirm = false } } },

	{ key = "h", action = wezterm.action{ ActivateTabRelative = -1 } },
	{ key = "l", action = wezterm.action{ ActivateTabRelative = 1 } },
	{ key = "H", action = wezterm.action{ MoveTabRelative = -1 } },
	{ key = "L", action = wezterm.action{ MoveTabRelative = 1 } },
}
for i = 1, 9 do
	table.insert(config.key_tables.tabs, {
		key = tostring(i),
		action = wezterm.action{ ActivateTab = i - 1 },
	})
end

config.key_tables.panes = {
	{ key = "j", action = wezterm.action{ SplitVertical = {} } },
	{ key = "k", action = wezterm.action{ SplitVertical = {} } },
	{ key = "h", action = wezterm.action{ SplitHorizontal = {} } },
	{ key = "l", action = wezterm.action{ SplitHorizontal = {} } },

	{ key = "f", action = "TogglePaneZoomState" },
	{ key = "z", action = "TogglePaneZoomState" },
}

config.key_tables.resize = {
	{ key = "j", action = wezterm.action{ AdjustPaneSize = { "Down", 1 } } },
	{ key = "k", action = wezterm.action{ AdjustPaneSize = { "Up", 1 } } },
	{ key = "h", action = wezterm.action{ AdjustPaneSize = { "Left", 1 } } },
	{ key = "l", action = wezterm.action{ AdjustPaneSize = { "Right", 1 } } },
	table.unpack(exitMappings),
}

-- menu
config.launch_menu = {
	{ args = { "btm" }, },
	{ args = { "htop" }, },
}

-- workspaces
config.unix_domains = {
	{
		name = "unix",
	},
}

config.window_frame = {
	font_size = 8.0,
	active_titlebar_bg = "#2f1e2e",
	inactive_titlebar_bg = "#333333",
}

config.colors = {
	compose_cursor = "orange",
	selection_fg = "black",
	selection_bg = "fffacd",

	tab_bar = {
		background = "#ef6155",
		active_tab = {
			bg_color = "#815ba4",
			fg_color = "#ffffff",
		},
		inactive_tab = {
			bg_color = "#2f1e2e",
			fg_color = "#ffffff",
		},
	},
}

wezterm.on("update-right-status", function(win, pane)
	local process = pane:get_foreground_process_name()
	local mode = win:active_key_table() or ""
	local status = process
	if mode ~= "" then status = "[" .. string.upper(mode) .. "] " .. status end
	win:set_right_status(" " .. status .. " ")
end)

return config
