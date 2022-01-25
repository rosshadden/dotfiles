local wezterm = require "wezterm"

function parseCmd(pane)
	local lines = wezterm.split_by_newlines(pane:get_logical_lines_as_text())
	local current = lines[#lines]
	cwd, a, cmd, d, e = current:match([[([^>]+)>(%s*(.*))]])
	if cmd == nil then cmd = "" end
	return cwd, cmd
end

function tablfy(value)
	result = {}
	for match in (value .. " "):gmatch("(.-)" .. " ") do
		table.insert(result, match)
	end
	return result
end

local config = {
	-- startup
	-- default_prog = { "/usr/bin/nu", "-l" },
	default_gui_startup_args = { "connect", "unix" },
	term = "wezterm",

	-- fonts
	font_size = 10,
	line_height = 0.8,

	-- ui
	hide_tab_bar_if_only_one_tab = true,
	color_scheme = "Paraiso Dark",
	window_background_opacity = 0.95,

	-- cursor
	force_reverse_video_cursor = true,

	-- more native keys
	enable_csi_u_key_encoding = true,
}

config.leader = { mods = "CTRL", key = "Enter" }

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

	-- actions
	{ mods = "LEADER", key = "f", action = "ToggleFullScreen" },

	-- navigation

	{ mods = "LEADER", key = "j", action = wezterm.action{ SplitVertical = {} } },
	{ mods = "LEADER", key = "k", action = wezterm.action{ SplitVertical = {} } },
	{ mods = "LEADER", key = "h", action = wezterm.action{ SplitHorizontal = {} } },
	{ mods = "LEADER", key = "l", action = wezterm.action{ SplitHorizontal = {} } },

	{ mods = "LEADER", key = "t", action = wezterm.action{ SplitHorizontal = {} } },

	-- commands

	{ mods = "LEADER|CTRL", key = "r", action = "ReloadConfiguration" },

	{ mods = "LEADER", key = "c", action = wezterm.action{ SendString = "fzf-files\x0D" } },
	{ mods = "LEADER", key = "d", action = wezterm.action{ SendString = "fzf-cd\x0D" } },
	{ mods = "LEADER", key = "r", action = wezterm.action{ SendString = "'fzf-history --query='\x0D" } },

	{
		-- type last arg from most recent command
		mods = "LEADER", key = ".",
		action = wezterm.action_callback(function(win, pane)
			local _, arg, _ = wezterm.run_child_process({ "nu", "-c", "last-arg" })
			pane:paste(arg)
		end)
	},

	{
		-- debug
		mods = "LEADER", key = "Backspace",
		action = wezterm.action_callback(function(win, pane)
			local cwd, cmd = parseCmd(pane)

			win:perform_action(
				wezterm.action{
					SplitVertical = {
						-- args = { "nu", "-c", "fzf" },
						args = { "shlube", "nu", "--", "wezterm", "cli", "send-text", "--pane-id " .. pane:pane_id(), "hey" },
						cwd = cwd,
					}
				},
				pane
			)

			-- os.execute("wezterm cli split-pane --pane-id " .. 0 .. " -- nu -c fzf")
			-- os.execute("/tmp/aoeu/test.sh")
		end)
	},
	-- { mods = "LEADER", key = "w", action = wezterm.action{ SplitVertical = { args = { "shlube", "nu", "--", "wezterm", "cli", "send-text", "--pane-id " .. pane:pane_id(), "hey" } } } },
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

config.window_frame = {
	font_size = 8.0,
	active_titlebar_bg = "#2f1e2e",
	inactive_titlebar_bg = "#333333",
}

config.colors = {
	tab_bar = {
		background = "#ff0000",
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

return config
