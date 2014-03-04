-- MODULES
	-- Standard awesome library
	local gears = require("gears")
	local awful = require("awful")
	awful.rules = require("awful.rules")
	require("awful.autofocus")
	-- Widget and layout library
	local wibox = require("wibox")
	-- Theme handling library
	local beautiful = require("beautiful")
	-- Notification library
	local naughty = require("naughty")
	local menubar = require("menubar")
	-- Misc
	local lain = require("lain")

	-- Mine
	local menu = require("menu")


-- ERRORS
	-- Check if awesome encountered an error during startup and fell back to
	-- another config (This code will only ever execute for the fallback config)
	if awesome.startup_errors then
		naughty.notify({ preset = naughty.config.presets.critical,
						 title = "Oops, there were errors during startup!",
						 text = awesome.startup_errors })
	end

	-- Handle runtime errors after startup
	do
		local in_error = false
		awesome.connect_signal("debug::error", function(err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true

			naughty.notify({ preset = naughty.config.presets.critical,
							 title = "Oops, an error happened!",
							 text = err })
			in_error = false
		end)
	end


-- VARIABLES
	-- Themes define colours, icons, and wallpapers
	theme = "ross"
	beautiful.init(awful.util.getdir("config") .. "/themes/" .. theme .. "/theme.lua")

	handlers = {
		terminal = "terminator",
		fm = "spacefm",
		editor = os.getenv("EDITOR") or "vim"
	}
	handlers["edit"] = handlers["terminal"] .. " -e " .. handlers["editor"]

	current = {}

	-- Default modkey.
	-- Usually, Mod4 is the key with a logo between Control and Alt.
	-- If you do not like this or do not have such a key,
	-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
	-- However, you can use another modifier like Mod1, but it may interact with others.
	modkey = "Mod4"

	-- Table of layouts to cover with awful.layout.inc, order matters.
	local layouts = {
		awful.layout.suit.floating,
		awful.layout.suit.tile,
		awful.layout.suit.tile.left,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.top,
		awful.layout.suit.fair,
		awful.layout.suit.fair.horizontal,
		awful.layout.suit.spiral,
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.max,
		awful.layout.suit.max.fullscreen,
		awful.layout.suit.magnifier
	}


-- WALLPAPER
	if beautiful.wallpaper then
		for s = 1, screen.count() do
			gears.wallpaper.maximized(beautiful.wallpaper, s, true)
		end
	end


-- TAGS
	-- Define a tag table which hold all screen tags.
	tags = {}
	tagNames = { "explore", "dev", "sync", "hack", "browse", "VI", "read", "communicate", "run" }
	tagNames = { "☁",      "{}",  "⌥",   "λ",    "browse", "♫",  "¶",   "☎",          "∞"   }
	tagNames = { "",      "{}",  "",   "",   "",      "",  "",  "",          ""   }

	for s = 1, screen.count() do
		-- Each screen has its own tag table.
		tags[s] = awful.tag(tagNames, s, layouts[2])
	end


-- MENU
	mainmenu = awful.menu(menu(awesome, awful, beautiful))
	mylauncher = awful.widget.launcher({
		image = beautiful.awesome_icon,
		menu = mainmenu
	})

	awful.menu.menu_keys = {
		up    = { "k", "Up" },
		down  = { "j", "Down" },
		exec  = { "l", "Return", "Right" },
		enter = { "Right" },
		back  = { "h", "Left" },
		close = { "q", "Escape" },
	}

	-- Menubar configuration
	menubar.utils.terminal = handlers["terminal"] -- Set the terminal for applications that require it


-- WIDGETS
	markup = lain.util.markup

	-- clock
		clockicon = wibox.widget.imagebox(beautiful.widget_clock)
		mytextclock = wibox.widget.background(
			awful.widget.textclock(" %a %d %b %H:%M")
		, "#313131")

	-- calendar
		lain.widgets.calendar:attach(mytextclock, { font_size = 12 })

	-- MEM
		memicon = wibox.widget.imagebox(beautiful.mem)
		memwidget = lain.widgets.mem({
			settings = function()
				widget:set_text(mem_now.used .. "MB ")
			end
		})

	-- CPU
		cpuicon = wibox.widget.imagebox(beautiful.cpu)
		cpuwidget = wibox.widget.background(lain.widgets.cpu({
			settings = function()
				widget:set_text(cpu_now.usage .. "% ")
			end
		}), "#313131")

	-- Coretemp
		tempicon = wibox.widget.imagebox(beautiful.temp)
		tempwidget = lain.widgets.temp({
			settings = function()
				widget:set_text(coretemp_now .. "°C ")
			end
		})

	-- Net
		neticon = wibox.widget.imagebox(beautiful.net)
		neticon:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn_with_shell(iptraf) end)))
		netwidget = wibox.widget.background(lain.widgets.net({
			settings = function()
				widget:set_markup(
					markup("#7AC82E", net_now.received)
					.. "/" ..
					markup("#46A8C3", net_now.sent)
					.. " "
				)
			end
		}), "#313131")

	-- Battery
		baticon = wibox.widget.imagebox(beautiful.battery)
		batwidget = lain.widgets.bat({
			settings = function()
				if bat_now.status ~= "Discharging" then
					widget:set_markup(bat_now.perc .. "% [" .. bat_now.status .. "] ")
					baticon:set_image(beautiful.ac)
					return
				elseif tonumber(bat_now.perc) <= 5 then
					baticon:set_image(beautiful.battery_empty)
				elseif tonumber(bat_now.perc) <= 15 then
					baticon:set_image(beautiful.battery_low)
				else
					baticon:set_image(beautiful.battery)
				end
				widget:set_markup(bat_now.perc .. "% ")
			end
		})

	-- Volume
		volicon = wibox.widget.imagebox(beautiful.vol)
		volumewidget = lain.widgets.alsa({
			settings = function()
				if volume_now.status == "off" then
					volicon:set_image(beautiful.vol_mute)
				elseif tonumber(volume_now.level) == 0 then
					volicon:set_image(beautiful.vol_no)
				elseif tonumber(volume_now.level) <= 50 then
					volicon:set_image(beautiful.vol_low)
				else
					volicon:set_image(beautiful.vol)
				end

				widget:set_text(volume_now.level .. "% ")
			end
		})

	-- Separators
		spr = wibox.widget.textbox(" ")
		arrl = wibox.widget.imagebox()
		arrl:set_image(beautiful.arrl)
		arrl_dl = wibox.widget.imagebox()
		arrl_dl:set_image(beautiful.arrl_dl)
		arrl_ld = wibox.widget.imagebox()
		arrl_ld:set_image(beautiful.arrl_ld)

	-- DEBUG
		debug = wibox.widget.textbox("")

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
			-- left_layout:add(spr)
		left_layout:add(mylauncher)
		left_layout:add(mytaglist[s])
		left_layout:add(mypromptbox[s])

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		if s == 1 then right_layout:add(wibox.widget.systray()) end
		right_layout:add(arrl)
			right_layout:add(tempicon)
			right_layout:add(tempwidget)
		right_layout:add(arrl_ld)
			right_layout:add(neticon)
			right_layout:add(netwidget)
		right_layout:add(arrl_dl)
			right_layout:add(memicon)
			right_layout:add(memwidget)
		right_layout:add(arrl_ld)
			right_layout:add(cpuicon)
			right_layout:add(cpuwidget)
		right_layout:add(arrl_dl)
			right_layout:add(volicon)
			right_layout:add(volumewidget)
		right_layout:add(arrl)
			right_layout:add(baticon)
			right_layout:add(batwidget)
		right_layout:add(arrl_ld)
			right_layout:add(mytextclock)
		right_layout:add(mylayoutbox[s])
		right_layout:add(debug)
		right_layout:add(wibox.widget.textbox(s))

		-- Now bring it all together (with the tasklist in the middle)
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		-- layout:set_middle(mytasklist[s])
		layout:set_right(right_layout)
		mywibox[s]:set_widget(layout)

		-- local layout2 = wibox.layout.rotate()
		-- layout2:set_widget(mytasklist[s])
		-- layout2:set_direction("east")
		-- mywibox2[s]:set_widget(layout2)
	end


-- BINDS
	-- MOUSE
		root.buttons(awful.util.table.join(
			awful.button({}, 3, function()
				mainmenu:toggle()
			end),
			awful.button({}, 4, awful.tag.viewprev),
			awful.button({}, 5, awful.tag.viewnext)
		))

	-- KEYS
		globalkeys = awful.util.table.join(
			awful.key({ modkey }, "h", awful.tag.viewprev),
			awful.key({ modkey }, "l", awful.tag.viewnext),
			awful.key({ modkey }, "Left", awful.tag.viewprev),
			awful.key({ modkey }, "Right", awful.tag.viewnext),
			awful.key({ modkey }, "Escape", awful.tag.history.restore),

			-- Move current client to previous tag.
			awful.key({ modkey, "Shift"   }, "h",	 function()
				if client.focus then
					local index = ((awful.tag.getidx() - 1) % 10)
					index = (index > 0) and index or 9
					local tag = awful.tag.gettags(client.focus.screen)[index]
					if tag then
						awful.client.movetotag(tag)
					end
				end

			end),

			-- Move current client to next tag.
			awful.key({ modkey, "Shift"   }, "l",	 function()
				if client.focus then
					local index = ((awful.tag.getidx() + 1) % 10)
					index = (index > 0) and index or 1
					local tag = awful.tag.gettags(client.focus.screen)[index]
					if tag then
						awful.client.movetotag(tag)
					end
				end

			end),

			awful.key({ modkey,		   }, "j",
				function()
					awful.client.focus.byidx( 1)
					if client.focus then client.focus:raise() end
				end),
			awful.key({ modkey,		   }, "k",
				function()
					awful.client.focus.byidx(-1)
					if client.focus then client.focus:raise() end
				end),
			awful.key({ modkey,		   }, "w", function() mainmenu:show() end),

			-- Layout manipulation
			awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(  1)	end),
			awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx( -1)	end),
			awful.key({ modkey, "Control" }, "l", function() awful.screen.focus_relative( 1) end),
			awful.key({ modkey, "Control" }, "h", function() awful.screen.focus_relative(-1) end),
			awful.key({ modkey,		   }, "u", awful.client.urgent.jumpto),
			awful.key({ modkey,		   }, "Tab",
				function()
					awful.client.focus.history.previous()
					if client.focus then
						client.focus:raise()
					end
				end),

			-- Standard program
			awful.key({ modkey,		   }, "t", function() awful.util.spawn(handlers["terminal"]) end),
			awful.key({ modkey,	"Shift" }, "t", tmuxThatShit),

			awful.key({ modkey, "Control" }, "r", awesome.restart),
			-- awful.key({ modkey, "Shift"   }, "q", awesome.quit),

			awful.key({ modkey,	"Control" }, "j",	 function() awful.tag.incmwfact( 0.05)	end),
			awful.key({ modkey,	"Control" }, "k",	 function() awful.tag.incmwfact(-0.05)	end),
			-- awful.key({ modkey, "Control", "Shift"   }, "h",	 function() awful.tag.incnmaster( 1)	  end),
			-- awful.key({ modkey, "Control", "Shift"   }, "l",	 function() awful.tag.incnmaster(-1)	  end),
			-- awful.key({ modkey, "Control" }, "h",	 function() awful.tag.incncol( 1)		 end),
			-- awful.key({ modkey, "Control" }, "l",	 function() awful.tag.incncol(-1)		 end),
			awful.key({ modkey,		   }, "space", function() awful.layout.inc(layouts,  1) end),
			awful.key({ modkey, "Shift"   }, "space", function() awful.layout.inc(layouts, -1) end),

			awful.key({ modkey, "Control" }, "n", awful.client.restore),

			-- Prompt
			awful.key({ modkey },			"Return", function() mypromptbox[mouse.screen]:run() end),
			awful.key({ modkey },			"r",	  function() mypromptbox[mouse.screen]:run() end),

			awful.key({ modkey }, "x",
					  function()
						  awful.prompt.run({ prompt = "Run Lua code: " },
						  mypromptbox[mouse.screen].widget,
						  awful.util.eval, nil,
						  awful.util.getdir("cache") .. "/history_eval")
					  end),
			-- Menubar
			awful.key({ modkey }, "p", function() menubar.show() end),

			awful.key({ modkey }, "Delete", function() awful.util.spawn("dm-tool lock") end)
		)

		clientkeys = awful.util.table.join(
			awful.key({ modkey,		   }, "f",	  function(c) c.fullscreen = not c.fullscreen  end),
			awful.key({ modkey, "Shift"   }, "c",	  function(c) c:kill()						 end),
			awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle					 ),
			awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
			awful.key({ modkey,		   }, "o",	  awful.client.movetoscreen						),
			awful.key({ modkey,		   }, "t",	  function(c) c.ontop = not c.ontop			end),
			awful.key({ modkey,		   }, "n",
				function(c)
					-- The client currently has the input focus, so it cannot be
					-- minimized, since minimized clients can't have the focus.
					c.minimized = true
				end),
			awful.key({ modkey,		   }, "m",
				function(c)
					c.maximized_horizontal = not c.maximized_horizontal
					c.maximized_vertical   = not c.maximized_vertical
				end),

			-- Volume keys
		   awful.key({}, "XF86AudioRaiseVolume", function()
			   awful.util.spawn("pulseaudio-ctl up", false) end),
		   awful.key({}, "XF86AudioLowerVolume", function()
			   awful.util.spawn("pulseaudio-ctl down", false) end),
		   awful.key({}, "XF86AudioMute", function()
			   awful.util.spawn("pulseaudio-ctl mute", false) end)
		)

		-- Bind all key numbers to tags.
		-- Be careful: we use keycodes to make it works on any keyboard layout.
		-- This should map on the top row of your keyboard, usually 1 to 9.
		for i = 1, 9 do
			globalkeys = awful.util.table.join(globalkeys,
				awful.key({ modkey }, "#" .. i + 9, function()
					local screen = mouse.screen
					local tag = awful.tag.gettags(screen)[i]
					if tag then
						awful.tag.viewonly(tag)
					end
				end),
				awful.key({ modkey, "Control" }, "#" .. i + 9, function()
					local screen = mouse.screen
					local tag = awful.tag.gettags(screen)[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end),
				awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
					if client.focus then
						local tag = awful.tag.gettags(client.focus.screen)[i]
						if tag then
							awful.client.movetotag(tag)
						end
					end
				end),
				awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
					if client.focus then
						local tag = awful.tag.gettags(client.focus.screen)[i]
						if tag then
							awful.client.toggletag(tag)
						end
					end
				end))
		end

		clientbuttons = awful.util.table.join(
			awful.button({}, 1, function(c) client.focus = c; c:raise() end),
			awful.button({ modkey }, 1, awful.mouse.client.move),
			awful.button({ modkey }, 3, awful.mouse.client.resize))

		-- Set keys
		root.keys(globalkeys)


-- RULES
	left = 1
	right = screen.count()
	awful.rules.rules = {
		-- All clients will match this rule.
		{
			rule = {},
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				keys = clientkeys,
				buttons = clientbuttons
			}
		}, {
			rule = { class = "MPlayer" },
			properties = { floating = true }
		}, {
			rule = { class = "pinentry" },
			properties = { floating = true }
		}, {
			rule = { class = "gimp" },
			properties = { floating = true }
		}, {
			rule = { class = "Chrome" },
			properties = { tag = tags[left][1] }
		}, {
			rule = { instance = "spacefm" },
			properties = { tag = tags[left][5] }
		}, {
			rule = { instance = "geeqie" },
			properties = { tag = tags[left][7] }
		}, {
			rule = { instance = "skype" },
			properties = { tag = tags[left][8] }
		}, {
			rule = { instance = "subl" },
			properties = { tag = tags[right][2] }
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

			awful.titlebar(c, { position = "left" }):set_widget(vert)
		end
	end)

	client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
	client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
