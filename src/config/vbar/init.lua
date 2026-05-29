local vbar = require("vbar")

--
-- UTILS

function p(value)
	vbar.exec([[notify-send debug "%s"]] % value)
end

-- Get hyprland workspaces.
-- TODO: make work
function get_workspaces()
	local out = vbar.exec("hyprctl workspaces -j")
	return vbar.json.decode(out)
end

-- Truncate text to a given length.
local function truncate(text, length)
	local line = text:match("^([^\n]*)")
	if #line > length then
		return line:sub(1, length) .. "…"
	end
	return line
end

--
-- SETUP

vbar.setup({
	shell = { "nu", "-c" },

	font_family = "monospace",
	font_size = "12pt",
	bg_color = "#1e1e2e",
	fg_color = "#cdd6f4",
})

--
-- VARIABLES

local volume_cmd = [[$"(ponymix get-volume)%(try { ponymix is-muted; ' [muted]' } catch { '' })"]]
local volume = vbar.var("volume")
	:listen([[pactl subscribe | grep --line-buffered "on sink"]], volume_cmd)
	:poll(volume_cmd, { interval = 5 })

local media = vbar.var("media")
	:listen(
		[[playerctl --follow metadata --format "[{{status}}] {{artist}} - {{title}}"]],
		[[
			"{}"
			| str replace "[Playing] " "▶️ "
			| str replace "[Paused] " "⏸️ "
			| str replace "[Stopped] " "⏹️ "
		]]
	)

local title = vbar.var("title")
	:poll([[hyprctl activewindow -j | from json | get title]])

local mode = vbar.var("mode"):set("NORMAL")

--
-- WIDGETS

local ws = vbar.workspaces({
	active_color = "#89b4fa",
})
	:click([[hyprctl dispatch workspace {} | ignore]])
	:right_click([[hyprctl dispatch moveworkspacetomonitor "name:{}" -1 | ignore]])
	-- TODO: abstract working with hyprctl
	:middle_click([[hyprctl workspaces -j | from json | where name == "{}" | get 0.lastwindow | hyprctl dispatch closewindow $"address:($in)" | ignore]])

local clipboard = vbar.var("clipboard")
	:poll(function()
		return truncate(vbar.exec([[wl-paste]]), 64)
	end, { interval = 5 })
	:drag()
	:drop(function(self, value)
		vbar.exec([[wl-copy "%s"]] % value)
		self:set(truncate(value, 64))
	end)
	:format("📋 {}")

local eos = vbar.var("eos")
	:poll([[eos --format json | from json | get state]], {
		-- TODO: why does `-l` not work in shell?
		-- shell = { "nu", "-l", "-c" }
	})
	:format("EOS:{}")

local vpn = vbar.var("vpn")
	-- :poll([[which -a cu]], { interval = 60 })
  -- "nu -l -c 'cu vpn status | get --ignore-errors state | default null'")

local lab = vbar.label("lab!")
	:click([[notify-send click left]])
	:right_click([[notify-send click right]])
	:middle_click([[notify-send click middle]])
	:drag()

--
-- BARS

local top_bar = vbar.bar({
	height = 16,
	anchors = { "left", "right", "top" },

	left = {
		ws,
	},
	center = {
		title,
	},
	right = {
		vbar.vars.date:format("🗓️ {}"),
		vbar.vars.time:format("🕑 {}"),
	},
})
function top_bar:scroll(dir)
	local sign = dir == "up" and "-" or "+"
	vbar.exec([[
		let current = (hyprctl monitors -j | from json | where id == %d | get activeWorkspace.id | get 0)
		let workspaces = (hyprctl workspaces -j | from json | where monitorID == %d and name !~ special | sort-by id | get id)
		let can_move = if "%s" == "up" { $workspaces | any {|w| $w < $current} } else { $workspaces | any {|w| $w > $current} }
		if $can_move { hyprctl dispatch focusmonitor %d; hyprctl dispatch workspace m%s1 | ignore }
	]] % { self.monitor.id, self.monitor.id, dir, self.monitor.id, sign })
end

vbar.bar({
	height = 16,
	anchors = { "left", "right", "bottom" },

	left = {
		mode,
		volume:format("VOL:{}"),
		eos,
		vpn:format("VPN:{}"),
		lab,
	},
	center = {
		media,
	},
	right = {
		clipboard,
		vbar.vars.cpu:format("CPU:{}"),
		vbar.vars.mem:format("MEM:{}"),
		vbar.systray(),
	},
})
