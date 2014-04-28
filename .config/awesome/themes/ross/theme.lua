------------------------------------
--  "Ross" awesome theme          --
--    By Ross Hadden (rosshadden) --
--  Modified from Zenburn         --
------------------------------------

local awful = require("awful")
local util = require("util")

dirs = {
	themes = awful.util.getdir("config") .. "/themes"
}
dirs.theme = dirs.themes .. "/ross"

-- Main
	theme = {}
	theme.wallpaper = dirs.theme .. "/wallpaper/ultimate_marvel_vs_capcom_3_magneto.png"

-- Styles
	theme.font = "Ubuntu Mono Bold 11"
	theme.taglist_font = "FontAwesome 13"

	-- Colors
		theme.colors = {
			-- darkgrey
			dark = "#1f211c",
			-- offwhite
			light = "#F8F8F2",
			-- rich blue
			current = "#2463B4",
			-- pastel yellow
			highlight = "#f2eb8f",
			-- rose
			accent = "#CC9393",

			pastel = {
				red = "#E67373",
				yellow = "#ECEC85",
				-- yellow = "#E0E259",
				green = "#9DE970",
				-- green = "#6Db940",
				blue = "#708EE9",
			}
		}

	-- General
		theme.fg_normal  = theme.colors.light
		theme.fg_focus   = "#FFFFFF"
		theme.fg_urgent  = "#CC9393"
		theme.bg_normal  = theme.colors.dark
		theme.bg_focus   = theme.colors.current
		theme.bg_urgent  = theme.colors.highlight
		theme.bg_systray = theme.bg_normal

	-- Borders
		theme.border_width  = 0
		theme.border_normal = "#6F6F6F"
		theme.border_focus  = theme.colors.accent
		theme.border_marked = theme.fg_urgent

	-- Titlebars
		theme.titlebar_fg_focus  = theme.fg_normal
		theme.titlebar_bg_focus  = theme.bg_focus
		theme.titlebar_bg_normal = "#1f2e3a"

	-- Taglist
		theme.taglist_fg_focus = theme.fg_focus
		theme.taglist_fg_urgent = theme.bg_normal
		-- theme.taglist_bg_urgent = theme.colors.highlight

	-- Tasklist
		theme.tasklist_bg_focus = theme.colors.current .. "88"

	-- There are other variable sets
	-- overriding the default one when
	-- defined, the sets are:
	-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
	-- titlebar_[normal|focus]
	-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]

-- Widgets
	-- You can add as many variables as
	-- you wish and access them by using
	-- beautiful.variable in your rc.lua
	--theme.fg_widget        = "#AECF96"
	--theme.fg_center_widget = "#88A175"
	--theme.fg_end_widget    = "#FF5656"
	--theme.bg_widget        = "#494B4F"
	--theme.border_widget    = "#3F3F3F"

-- Mouse finder
	theme.mouse_finder_color = "#CC9393"
	-- mouse_finder_[timeout|animate_timeout|radius|factor]

-- Menu
	-- Variables set for theming the menu:
	-- menu_[bg|fg]_[normal|focus]
	-- menu_[border_color|border_width]
	theme.menu_height = 32
	theme.menu_width  = 256
	-- theme.menu_border_width = 1
	-- theme.menu_border_color = "#ff0000"

-- Icons
	-- Taglist
		theme.taglist_squares_sel   = dirs.theme .. "/taglist/squarefz.png"
		theme.taglist_squares_unsel = dirs.theme .. "/taglist/squarez.png"
		--theme.taglist_squares_resize = "false"

	-- Misc
		theme.awesome_icon           = dirs.theme .. "/icons/awesome.png"
		theme.menu_submenu_icon      = dirs.themes .. "/default/submenu.png"

	-- Layout
		theme.layout_tile       = dirs.theme .. "/layouts/tile.png"
		theme.layout_tileleft   = dirs.theme .. "/layouts/tileleft.png"
		theme.layout_tilebottom = dirs.theme .. "/layouts/tilebottom.png"
		theme.layout_tiletop    = dirs.theme .. "/layouts/tiletop.png"
		theme.layout_fairv      = dirs.theme .. "/layouts/fairv.png"
		theme.layout_fairh      = dirs.theme .. "/layouts/fairh.png"
		theme.layout_spiral     = dirs.theme .. "/layouts/spiral.png"
		theme.layout_dwindle    = dirs.theme .. "/layouts/dwindle.png"
		theme.layout_max        = dirs.theme .. "/layouts/max.png"
		theme.layout_fullscreen = dirs.theme .. "/layouts/fullscreen.png"
		theme.layout_magnifier  = dirs.theme .. "/layouts/magnifier.png"
		theme.layout_floating   = dirs.theme .. "/layouts/floating.png"

	-- Titlebar
		theme.titlebar_close_button_focus  = dirs.theme .. "/titlebar/close_focus.png"
		theme.titlebar_close_button_normal = dirs.theme .. "/titlebar/close_normal.png"

		theme.titlebar_ontop_button_focus_active  = dirs.theme .. "/titlebar/ontop_focus_active.png"
		theme.titlebar_ontop_button_normal_active = dirs.theme .. "/titlebar/ontop_normal_active.png"
		theme.titlebar_ontop_button_focus_inactive  = dirs.theme .. "/titlebar/ontop_focus_inactive.png"
		theme.titlebar_ontop_button_normal_inactive = dirs.theme .. "/titlebar/ontop_normal_inactive.png"

		theme.titlebar_sticky_button_focus_active  = dirs.theme .. "/titlebar/sticky_focus_active.png"
		theme.titlebar_sticky_button_normal_active = dirs.theme .. "/titlebar/sticky_normal_active.png"
		theme.titlebar_sticky_button_focus_inactive  = dirs.theme .. "/titlebar/sticky_focus_inactive.png"
		theme.titlebar_sticky_button_normal_inactive = dirs.theme .. "/titlebar/sticky_normal_inactive.png"

		theme.titlebar_floating_button_focus_active  = dirs.theme .. "/titlebar/floating_focus_active.png"
		theme.titlebar_floating_button_normal_active = dirs.theme .. "/titlebar/floating_normal_active.png"
		theme.titlebar_floating_button_focus_inactive  = dirs.theme .. "/titlebar/floating_focus_inactive.png"
		theme.titlebar_floating_button_normal_inactive = dirs.theme .. "/titlebar/floating_normal_inactive.png"

		theme.titlebar_maximized_button_focus_active  = dirs.theme .. "/titlebar/maximized_focus_active.png"
		theme.titlebar_maximized_button_normal_active = dirs.theme .. "/titlebar/maximized_normal_active.png"
		theme.titlebar_maximized_button_focus_inactive  = dirs.theme .. "/titlebar/maximized_focus_inactive.png"
		theme.titlebar_maximized_button_normal_inactive = dirs.theme .. "/titlebar/maximized_normal_inactive.png"

	-- Widgets
		-- Separator
		theme.arrl = dirs.theme .. "/icons/arrl.png"
		theme.arrl_dl = dirs.theme .. "/icons/arrl_dl.png"
		theme.arrl_ld = dirs.theme .. "/icons/arrl_ld.png"

		-- Battery
		theme.ac = dirs.theme .. "/icons/ac.png"
		theme.battery = dirs.theme .. "/icons/battery.png"
		theme.battery_empty = dirs.theme .. "/icons/battery_empty.png"
		theme.battery_low = dirs.theme .. "/icons/battery_low.png"

		-- Volume
		theme.vol = dirs.theme .. "/icons/vol.png"
		theme.vol_low = dirs.theme .. "/icons/vol_low.png"
		theme.vol_no = dirs.theme .. "/icons/vol_no.png"
		theme.vol_mute = dirs.theme .. "/icons/vol_mute.png"

		theme.temp = dirs.theme .. "/icons/temp.png"
		theme.mem = dirs.theme .. "/icons/mem.png"
		theme.cpu = dirs.theme .. "/icons/cpu.png"
		theme.net = dirs.theme .. "/icons/net.png"
		theme.net_wired = dirs.theme .. "/icons/net_wired.png"

return theme
