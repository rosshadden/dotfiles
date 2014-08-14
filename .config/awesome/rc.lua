-- MODULES
	-- Standard awesome library
	local gears = require("gears")
	local awful = require("awful")
	awful.rules = require("awful.rules")
	require("awful.autofocus")
	-- Widget and layout library
	local wibox = require("wibox")
	local radical = require("radical")
	local alttab = require("radical.impl.alttab")
	local cyclefocus = require('cyclefocus')
	-- Theme handling library
	local themeName = "ross"
	theme = require("beautiful")
	theme.init(awful.util.getdir("config") .. "/themes/" .. themeName .. "/theme.lua")
	-- Notification library
	local naughty = require("naughty")
	local menubar = require("menubar")

	-- Mine
	local util = require("modules/util")
	local apps = require("modules/apps")
	local binds = require("modules/binds")
	local widgets = require("modules/widgets")


-- ERRORS
	-- Check if awesome encountered an error during startup and fell back to
	-- another config (This code will only ever execute for the fallback config)
	if awesome.startup_errors then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, there were errors during startup!",
			text = awesome.startup_errors
		})
	end

	-- Handle runtime errors after startup
	do
		local in_error = false
		awesome.connect_signal("debug::error", function(err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true

			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Oops, an error happened!",
				text = err
			})
			in_error = false
		end)
	end


-- WALLPAPER
	if theme.wallpaper then
		for s = 1, screen.count() do
			gears.wallpaper.maximized(theme.wallpaper, s, true)
		end
	end


-- TAGS
	-- Define a tag table which hold all screen tags.
	local tags = {}
	local tagNames = { "", "{}", "", "", "", "", "", "", "" }

	for s = 1, screen.count() do
		-- Each screen has its own tag table.
		tags[s] = awful.tag(tagNames, s, layouts[2])
	end


-- MENU
	-- mainmenu = awful.menu(apps.menu)
	-- mylauncher = awful.widget.launcher({
	-- 	image = theme.awesome_icon,
	-- 	menu = mainmenu
	-- })

	-- awful.menu.menu_keys = {
	-- 	up    = { "k", "Up" },
	-- 	down  = { "j", "Down" },
	-- 	exec  = { "l", "Return", "Right" },
	-- 	enter = { "Right" },
	-- 	back  = { "h", "Left" },
	-- 	close = { "q", "Escape" },
	-- }

	local launcher = wibox.widget.textbox('MENU')
	launcher:set_menu(apps.menu)

	-- Menubar configuration
	menubar.utils.terminal = handlers.terminal -- Set the terminal for applications that require it


-- WIDGETS
	-- Separators
		local separate = function(from, to)
			if not from then from = theme.colors.dark end
			if not to then to = theme.colors.dark end
			return wibox.widget.textbox("<span font='FontAwesome 30' color='" .. to .. "' bgcolor='" .. from .. "'></span>")
		end

	-- Create a wibox for each screen and add it
	mywibox = {}
	mywibox2 = {}
	mypromptbox = {}
	mylayoutbox = {}
	mytaglist = {}
	mytaglist.buttons = awful.util.table.join(
		awful.button({}, 1, awful.tag.viewonly),
		awful.button({ modkey }, 1, awful.client.movetotag),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, awful.client.toggletag),
		awful.button({}, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end),
		awful.button({}, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end)
	)
	mytasklist = {}
	mytasklist.buttons = awful.util.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				-- Without this, the following
				-- :isvisible() makes no sense
				c.minimized = false
				if not c:isvisible() then
					awful.tag.viewonly(c:tags()[1])
				end
				-- This will also un-minimize
				-- the client, if needed
				client.focus = c
				c:raise()
			end
		end),
		awful.button({}, 3, function()
			if instance then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({ width=250 })
			end
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
			if client.focus then client.focus:raise() end
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end)
	)

	for s = 1, screen.count() do
		-- Create a promptbox for each screen
		mypromptbox[s] = awful.widget.prompt()
		-- Create an imagebox widget which will contains an icon indicating which layout we're using.
		-- We need one layoutbox per screen.
		mylayoutbox[s] = awful.widget.layoutbox(s)
		mylayoutbox[s]:buttons(
			awful.util.table.join(
				awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
				awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
				awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
				awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)
			)
		)
		-- Create a taglist widget
		mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

		-- Create a tasklist widget
		mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

		-- Create the wibox
		mywibox[s] = awful.wibox({ position = "top", screen = s })
		-- mywibox2[s] = awful.wibox({ position = "left", screen = s })

		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()

		-- left_layout:add(mylauncher)
		left_layout:add(launcher)

		left_layout:add(mytaglist[s])
		left_layout:add(mypromptbox[s])

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		if s == 1 then right_layout:add(wibox.widget.systray()) end

		local color = 0
		local colors = {
			theme.colors.pastel.red,
			theme.colors.pastel.yellow,
			theme.colors.pastel.green,
			theme.colors.pastel.blue,
		}
		colors[0] = theme.colors.dark
		for w, widget in ipairs(widgets) do
			if not widget.screen or widget.screen == s then
				local left = colors[color]
				local right = colors[color % (#colors) + 1]
				local theIcon = wibox.widget.background(widget.icon, right)
				local theWidget = wibox.widget.background(widget.widget, right)

				if (util.color.hexToHSL(right)[1] < 40 or 200 < util.color.hexToHSL(right)[1]) and util.color.isDark(right, .2) then
					theIcon:set_fg(theme.colors.light)
					theWidget:set_fg(theme.colors.light)
				else
					theIcon:set_fg("#999999")
					theWidget:set_fg("#999999")
				end

				right_layout:add(separate(left, right))
				right_layout:add(theIcon)
				right_layout:add(theWidget)
				color = color % (#colors) + 1
			end
		end

		right_layout:add(mylayoutbox[s])

		-- DEBUG
		local debug = wibox.widget.textbox(s)
		right_layout:add(debug)

		-- Now bring it all together (with the tasklist in the middle)
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_middle(mytasklist[s])
		layout:set_right(right_layout)
		mywibox[s]:set_widget(layout)

		-- local layout2 = wibox.layout.rotate()
		-- layout2:set_widget(mytasklist[s])
		-- layout2:set_direction("east")
		-- mywibox2[s]:set_widget(layout2)
	end


-- RULES
	root.buttons(binds.globalMouse)
	root.keys(binds.globalkeys)

	awful.rules.rules = {
		-- All clients will match this rule.
		{
			rule = {},
			properties = {
				border_width = theme.border_width,
				border_color = theme.border_normal,
				focus = awful.client.focus.filter,
				keys = binds.clientkeys,
				buttons = binds.clientbuttons
			}
		}, {
			rule = { class = "MPlayer" },
			properties = { floating = true }
		}, {
			rule = { instance = "qalculate-gtk" },
			properties = { floating = true }
		}, {
			rule = { class = "pinentry" },
			properties = { floating = true }
		}, {
			rule = { class = "gimp" },
			properties = { floating = true }
		-- }, {
		-- 	rule = { class = "Chrome" },
		-- 	properties = { tag = tags[util.screens.left][1] }
		-- }, {
		-- 	rule = { instance = "spacefm" },
		-- 	properties = { tag = tags[util.screens.left][5] }
		}, {
			rule = { instance = "geeqie" },
			properties = { tag = tags[util.screens.left][6] }
		}, {
			rule = { instance = "skype" },
			properties = { tag = tags[util.screens.right][7] }
		}, {
			rule = { class = "Pidgin" },
			properties = { tag = tags[util.screens.right][8] }
		-- }, {
		-- 	rule = { instance = "subl" },
		-- 	properties = { tag = tags[util.screens.right][2] }
		}
	}


-- SIGNALS
	-- Signal function to execute when a new client appears.
	client.connect_signal("manage", function(c, startup)
		-- Enable sloppy focus
		-- c:connect_signal("mouse::enter", function(c)
		-- 	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		-- 		and awful.client.focus.filter(c) then
		-- 		client.focus = c
		-- 	end
		-- end)

		if not startup then
			-- Set the windows at the slave,
			-- i.e. put it at the end of others instead of setting it master.
			-- awful.client.setslave(c)

			-- Put windows in a smart way, only if they does not set an initial position.
			if not c.size_hints.user_position and not c.size_hints.program_position then
				awful.placement.no_overlap(c)
				awful.placement.no_offscreen(c)
			end
		end

		local titlebars_enabled = true
		if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
			-- buttons for the titlebar
			local buttons = awful.util.table.join(
				awful.button({}, 1, function()
					client.focus = c
					c:raise()
					awful.mouse.client.move(c)
				end),
				awful.button({}, 3, function()
					client.focus = c
					c:raise()
					awful.mouse.client.resize(c)
				end)
			)

			-- Widgets that are aligned to the left
			local left_layout = wibox.layout.fixed.horizontal()
			left_layout:add(awful.titlebar.widget.iconwidget(c))
			left_layout:buttons(buttons)

			-- Widgets that are aligned to the right
			local right_layout = wibox.layout.fixed.horizontal()
			right_layout:add(awful.titlebar.widget.floatingbutton(c))
			right_layout:add(awful.titlebar.widget.maximizedbutton(c))
			right_layout:add(awful.titlebar.widget.stickybutton(c))
			right_layout:add(awful.titlebar.widget.ontopbutton(c))
			right_layout:add(awful.titlebar.widget.closebutton(c))

			-- The title goes in the middle
			local middle_layout = wibox.layout.flex.horizontal()
			local title = awful.titlebar.widget.titlewidget(c)
			title:set_align("center")
			middle_layout:add(title)
			middle_layout:buttons(buttons)

			-- Now bring it all together
			local layout = wibox.layout.align.horizontal()
			layout:set_left(left_layout)
			layout:set_right(right_layout)
			layout:set_middle(middle_layout)

			local vert = wibox.layout.rotate()
			vert:set_direction("east")
			vert:set_widget(layout)

			-- awful.titlebar(c, { position = "left" }):set_widget(vert)
		end
	end)

	client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
	client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)
