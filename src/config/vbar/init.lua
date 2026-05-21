local vbar = require("vbar")

vbar.setup({
	shell = { "nu", "-c" },

	font_family = "monospace",
	font_size = "12pt",
	bg_color = "#1e1e2e",
	fg_color = "#cdd6f4",

	providers = {
		cpu = { interval = 2 },
		ram = { interval = 2 },
	}
})

-- Ruby/Python style string formatting.
getmetatable("").__mod = function(a, b)
	if not b then
		return a
	elseif type(b) == "table" then
		return string.format(a, table.unpack(b))
	else
		return string.format(a, b)
	end
end

function p(value)
	vbar.exec("notify-send debug %s" % value)
end

local ws = vbar.workspaces({
	active_color = "#89b4fa",
})
function ws:click(name)
	vbar.exec("hyprctl dispatch workspace %s | ignore" % name)
end

local top_bar = vbar.bar({
	height = 16,
	anchors = { "left", "right", "top" },

	left = {
		ws,
	},
	center = {
	},
	right = {
		vbar.label("${date}"),
		vbar.label("${time}"),
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

local volume = vbar.var("volume", { interval = 1 })
function volume:poll()
	return vbar.exec([[$"(ponymix get-volume)%(try { ponymix is-muted; ' [muted]' } catch { '' })"]])
end

local media = vbar.var("media", { interval = 5 })
function media:poll()
	return vbar.exec([[playerctl metadata --format "{{artist}} - {{title}}"]])
end

vbar.bar({
	height = 16,
	anchors = { "left", "right", "bottom" },

	left = {
		vbar.label("VOL ${volume}"),
	},
	center = {
		vbar.label("${media}"),
	},
	right = {
		vbar.label("CPU ${cpu.avg}%"),
		vbar.label("RAM ${ram.pct}%"),
	},
})
