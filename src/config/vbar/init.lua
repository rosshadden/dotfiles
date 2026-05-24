local vbar = require("vbar")

--
-- UTILS

function p(value)
	vbar.exec("notify-send debug %s" % value)
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

local volume = vbar.var("volume")
volume:poll([[$"(ponymix get-volume)%(try { ponymix is-muted; ' [muted]' } catch { '' })"]])

local media = vbar.var("media")
media:poll([[playerctl metadata --format "{{artist}} - {{title}}"]])

local title = vbar.var("title")
title:poll([[hyprctl activewindow -j | from json | get title]])

local lab = vbar.var("lab", { foo = "bar" })
local mode = vbar.var("mode", "NORMAL")

local clipboard = vbar.var("clipboard", "clip")
clipboard:poll("wl-paste | lines | first", { interval = 5 })

--
-- WIDGETS

local ws = vbar.workspaces({
	active_color = "#89b4fa",
})
function ws:click(name)
	vbar.exec("hyprctl dispatch workspace %s | ignore" % name)
end

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
		volume:format("VOL {}"),
		mode,
		lab,
	},
	center = {
		media,
	},
	right = {
		clipboard,
		vbar.vars.cpu:format("CPU {}"),
		vbar.vars.mem:format("MEM {}"),
	},
})
