local wezterm = require "wezterm"
local act = wezterm.action

local theme = "Synthwave Alpha (Gogh)"
local scheme = wezterm.get_builtin_color_schemes()[theme]

local config = {
	key_tables = {},

	-- startup
	-- default_gui_startup_args = { "connect", "unix" },
	term = "wezterm",

	front_end = "WebGpu",

	-- fonts
	font_size = 12,
	line_height = 1.0,
	font = wezterm.font_with_fallback({
		-- "Monocraft",
		"Fairfax Hax HD",
		-- "Maple Mono",
		"JetBrains Mono",
		"Symbols Nerd Font Mono",
		"Noto Color Emoji",
		"Unifont",
	}),

	enable_wayland = true,

	-- ui
	color_scheme = "main",
	color_schemes = {
		["main"] = scheme,
	},
	-- window_background_opacity = 0.90,

	-- cursor
	force_reverse_video_cursor = true,

	-- more native keys
	enable_csi_u_key_encoding = true,
	enable_kitty_keyboard = true,

	-- quick select keys
	quick_select_alphabet = "cieansthbyouvwdl,kj.rm",
}

-- mappings

config.leader = { mods = "CTRL", key = "Space" }

config.keys = {
	-- send prefix
	{ mods = "LEADER", key = "Space", action = act{ SendKey = { mods = "CTRL", key = "Space" } } },
	{ mods = "LEADER|CTRL", key = "Space", action = act{ SendKey = { mods = "CTRL", key = "Space" } } },

	-- unmap
	{ mods = "ALT", key = "Enter", action = "DisableDefaultAssignment" },
	{ mods = "CTRL", key = "Slash", action = act.SendString("")},

	-- main
	{ mods = "LEADER|CTRL", key = "p", action = act.ActivateCommandPalette },

	-- normalize
	{ key = "Delete", action = act{ SendKey = { key = "Delete" } } },
	{ mods = "SHIFT", key = " ", action = act{ SendString = " " } },
	{ mods = "SHIFT", key = "Backspace", action = act{ SendKey = { key = "Backspace" } } },

	-- modes
	{ mods = "LEADER", key = "a", action = act{ ActivateKeyTable = { name = "app", one_shot = true, replace_current = false } } },
	{ mods = "LEADER", key = "b", action = act{ ActivateKeyTable = { name = "panes", one_shot = true, replace_current = false } } },
	{ mods = "LEADER", key = "c", action = "ActivateCopyMode" },
	{ mods = "LEADER", key = "r", action = act{ ActivateKeyTable = { name = "resize", one_shot = false, replace_current = false } } },
	{ mods = "LEADER", key = "s", action = act{ ActivateKeyTable = { name = "sessions", one_shot = true, replace_current = false } } },
	{ mods = "LEADER", key = "t", action = act{ ActivateKeyTable = { name = "tabs", one_shot = true, replace_current = false } } },
	{ mods = "LEADER", key = "w", action = act{ ActivateKeyTable = { name = "workspaces", one_shot = true, replace_current = false } } },

	-- navigation
	{ mods = "LEADER", key = "Tab", action = "ActivateLastTab" },
	{ mods = "LEADER", key = "p", action = act{ ActivateTabRelative = -1 } },
	{ mods = "LEADER", key = "n", action = act{ ActivateTabRelative = 1 } },
	{ mods = "CTRL", key = "j", action = act{ ActivatePaneDirection = "Down" } },
	{ mods = "CTRL", key = "k", action = act{ ActivatePaneDirection = "Up" } },
	{ mods = "CTRL", key = "h", action = act{ ActivatePaneDirection = "Left" } },
	{ mods = "CTRL", key = "l", action = act{ ActivatePaneDirection = "Right" } },

	-- debug
	{
		mods = "LEADER", key = "Backspace",
		action = wezterm.action_callback(function(win, pane)
			os.execute("notify-send debug")
		end)
	},
}

local exitMappings = {
	{ key = "Escape", action = "PopKeyTable" },
	{ key = "q", action = "PopKeyTable" },
}

if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode,
		{ key = "Enter", mods = 'NONE', action = act.Multiple{
			{ CopyTo =  "PrimarySelection" },
			"ClearSelection",
			"ScrollToBottom",
			{ CopyMode =  "Close" },
			{ PasteFrom =  "PrimarySelection" },
		} }
	)
	config.key_tables.copy_mode = copy_mode
end

config.key_tables.app = {
	{ key = "f", action = "ToggleFullScreen" },
	{ key = "l", action = "ShowLauncher" },
	{ key = "r", action = "ReloadConfiguration" },
}

config.key_tables.sessions = {
	{ key = "d", action = act{ DetachDomain = "CurrentPaneDomain" } },
}

config.key_tables.tabs = {
	{ key = "Space", action = "ShowTabNavigator" },
	{ key = "Tab", action = "ActivateLastTab" },
	{ key = "`", action = act{ ActivateTab = -1 } },

	{ key = "n", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "q", action = act{ CloseCurrentTab = { confirm = true } } },
	{ key = "Q", action = act{ CloseCurrentTab = { confirm = false } } },

	{ key = "h", action = act{ ActivateTabRelative = -1 } },
	{ key = "l", action = act{ ActivateTabRelative = 1 } },
	{ key = "H", action = act{ MoveTabRelative = -1 } },
	{ key = "L", action = act{ MoveTabRelative = 1 } },

	{ key = "e", action = act.SpawnCommandInNewTab { args = { "nvim" } } },
	{ key = "g", action = act.SpawnCommandInNewTab { args = { "tig", "status" } } },
}
for i = 1, 9 do
	table.insert(config.keys, { mods = "LEADER", key = tostring(i), action = act{ ActivateTab = i - 1 } })
	table.insert(config.key_tables.tabs, { key = tostring(i), action = act{ ActivateTab = i - 1 } })
end

config.key_tables.panes = {
	{ key = "Space", action = act{ PaneSelect = {} } },
	{ key = "s", action = act{ PaneSelect = { mode = "SwapWithActive" } } },

	{ key = "q", action = act{ CloseCurrentPane = { confirm = true } } },
	{ key = "Q", action = act{ CloseCurrentPane = { confirm = false } } },

	{ key = "j", action = act{ SplitPane = { direction = "Down" } } },
	{ key = "k", action = act{ SplitPane = { direction = "Up" } } },
	{ key = "h", action = act{ SplitPane = { direction = "Left" } } },
	{ key = "l", action = act{ SplitPane = { direction = "Right" } } },

	{ key = "J", action = act{ SplitPane = { direction = "Down", top_level = true } } },
	{ key = "K", action = act{ SplitPane = { direction = "Up", top_level = true } } },
	{ key = "H", action = act{ SplitPane = { direction = "Left", top_level = true } } },
	{ key = "L", action = act{ SplitPane = { direction = "Right", top_level = true } } },

	{ key = "f", action = "TogglePaneZoomState" },
	{ key = "z", action = "TogglePaneZoomState" },
}

config.key_tables.resize = {
	{ key = "j", action = act{ AdjustPaneSize = { "Down", 1 } } },
	{ key = "k", action = act{ AdjustPaneSize = { "Up", 1 } } },
	{ key = "h", action = act{ AdjustPaneSize = { "Left", 1 } } },
	{ key = "l", action = act{ AdjustPaneSize = { "Right", 1 } } },
	table.unpack(exitMappings),
}

config.key_tables.workspaces = {
	{ key = "Space", action = act.ShowLauncherArgs{ flags = "FUZZY|WORKSPACES" } },
	{ key = "p", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "n", action = act.SwitchWorkspaceRelative(1) },
	{
		key = "N",
		action = act.PromptInputLine {
			description = wezterm.format {
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			},
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(act.SwitchToWorkspace { name = line, }, pane)
				end
			end),
		},
	},
}

-- menu
config.launch_menu = {
	{ args = { "btm" }, },
	{ args = { "htop" }, },
}

-- domains
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
	cursor_border = "white",
	-- foreground = "white",

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

config.tls_servers = {
	{
		bind_address = "0.0.0.0:8888",
	},
}

config.tls_clients = {
	{
		name = "localhost",
		remote_address = "localhost:8888",
		bootstrap_via_ssh = "localhost",
	}, {
		name = "bork",
		remote_address = "bork:8888",
		bootstrap_via_ssh = "bork",
	},
}

for key, value in pairs(config.colors) do
	scheme[key] = value
end

wezterm.on("update-right-status", function(win, pane)
	local process = pane:get_foreground_process_name()
	local mode = win:active_key_table() or ""
	local status = process or ""
	if mode ~= "" then status = "[" .. string.upper(mode) .. "] " .. status end
	if status then
		win:set_right_status(" " .. status .. " ")
	end
end)

return config
