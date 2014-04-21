-- MODULES
	-- Standard awesome library
	local gears = require("gears")
	local awful = require("awful")
	awful.rules = require("awful.rules")
	require("awful.autofocus")
	-- Widget and layout library
	local wibox = require("wibox")
	-- Theme handling library
	theme = require("beautiful")
	themeName = "ross"
	theme.init(awful.util.getdir("config") .. "/themes/" .. themeName .. "/theme.lua")
	-- Notification library
	local naughty = require("naughty")
	local menubar = require("menubar")
	-- Misc
	local lain = require("lain")

	-- Mine
	local util = require("util")
	local apps = require("apps")


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


-- VARIABLES
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

	-- Cache to store temp things.
	local CACHE = {}


-- WALLPAPER
	if theme.wallpaper then
		for s = 1, screen.count() do
			gears.wallpaper.maximized(theme.wallpaper, s, true)
		end
	end


-- TAGS
	-- Define a tag table which hold all screen tags.
	tags = {}
	tagNames = { "", "{}", "", "", "", "", "", "", "" }

	for s = 1, screen.count() do
		-- Each screen has its own tag table.
		tags[s] = awful.tag(tagNames, s, layouts[2])
	end


-- MENU
	mainmenu = awful.menu(apps.menu)
	mylauncher = awful.widget.launcher({
		image = theme.awesome_icon,
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
	menubar.utils.terminal = apps.get("terminal") -- Set the terminal for applications that require it


-- WIDGETS
	markup = lain.util.markup

	-- clock
		local dateformat = "<span font='FontAwesome'></span> %a %b %d"
		local timeformat = "<span font='FontAwesome'></span> %H:%M"
		clockicon = wibox.widget.imagebox(theme.widget_clock)
		mytextclock = wibox.widget.background(
			awful.widget.textclock(" " .. dateformat .. "  " .. timeformat .. " ")
		, theme.colors.pastel.red)

	-- calendar
		lain.widgets.calendar:attach(mytextclock, { font_size = 12 })

	-- MEM
		memicon = wibox.widget.imagebox(theme.mem)
		memwidget = lain.widgets.mem({
			settings = function()
				widget:set_text(mem_now.used .. "MB ")
			end
		})

	-- CPU
		cpuicon = wibox.widget.background()
		cpuiconInner = wibox.widget.imagebox(theme.cpu)
		cpuicon:set_widget(cpuiconInner)
		cpuicon:set_bg(theme.colors.pastel.red)
		cpuwidget = wibox.widget.background(lain.widgets.cpu({
			settings = function()
				widget:set_text(cpu_now.usage .. "% ")
			end
		}), theme.colors.pastel.red)

	-- Coretemp
		if (util.fileExists("/sys/class/thermal/thermal_zone0/temp")) then
			tempicon = wibox.widget.background(wibox.widget.imagebox(theme.temp), theme.colors.pastel.yellow)
			tempwidget = wibox.widget.background(lain.widgets.temp({
				settings = function()
					widget:set_text(coretemp_now .. "°C ")
				end
			}), theme.colors.pastel.yellow)
		end

	-- Net
		neticon = wibox.widget.background()
		neticonInner = wibox.widget.imagebox(theme.net)
		neticonInner:buttons(awful.util.table.join(awful.button({}, 1, function() awful.util.spawn_with_shell(iptraf) end)))
		neticon:set_widget(neticonInner)
		neticon:set_bg(theme.colors.pastel.red)
		netwidget = wibox.widget.background(lain.widgets.net({
			settings = function()
				widget:set_markup(
					markup("#7AC82E", net_now.received)
					.. "/" ..
					markup("#46A8C3", net_now.sent)
					.. " "
				)
			end
		}), theme.colors.pastel.red)

	-- Battery
		if (util.fileExists("/sys/class/power_supply/BAT0")) then
			baticonInner = wibox.widget.imagebox(theme.battery)
			baticon = wibox.widget.background(baticonInner, theme.colors.pastel.blue)
			batwidget = wibox.widget.background(lain.widgets.bat({
				settings = function()
					if bat_now.status ~= "Discharging" then
						widget:set_markup(bat_now.perc .. "% [" .. bat_now.status .. "] ")
						baticonInner:set_image(theme.ac)
						return
					end

					widget:set_markup(bat_now.perc .. "% ")
					if tonumber(bat_now.perc) <= 5 then
						baticonInner:set_image(theme.battery_empty)
					elseif tonumber(bat_now.perc) <= 15 then
						baticonInner:set_image(theme.battery_low)
					else
						baticonInner:set_image(theme.battery)
					end
				end
			}), theme.colors.pastel.blue)
		end

	-- Volume
		voliconInner = wibox.widget.imagebox(theme.vol)
		volicon = wibox.widget.background(voliconInner, theme.colors.pastel.green)
		volumewidget = wibox.widget.background(lain.widgets.alsa({
			settings = function()
				local icon = ""
				if volume_now.status == "off" then
					icon = ""
					voliconInner:set_image(theme.vol_mute)
				elseif tonumber(volume_now.level) == 0 then
					icon = ""
					voliconInner:set_image(theme.vol_no)
				elseif tonumber(volume_now.level) <= 50 then
					icon = ""
					voliconInner:set_image(theme.vol_low)
				else
					icon = ""
					voliconInner:set_image(theme.vol)
				end

				-- widget:set_text("<span font='FontAwesome'>" .. icon .. "</span> " .. volume_now.level .. "% ")
				widget:set_text(volume_now.level .. "% ")
			end
		}), theme.colors.pastel.green)

	-- Separators
		spr = wibox.widget.textbox(" ")
		separate = function(from, to)
			if not from then from = theme.colors.bg end
			if not to then to = theme.colors.bg end
			return wibox.widget.textbox("<span font='FontAwesome 30' color='" .. to .. "' bgcolor='" .. from .. "'></span>")
		end

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

		if util.exec("whoami") ~= "ross\n" then
			left_layout:add(mylauncher)
		end

		left_layout:add(mytaglist[s])
		left_layout:add(mypromptbox[s])

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		if s == 1 then right_layout:add(wibox.widget.systray()) end

		if s == util.screens.right then
			if batwidget then
				right_layout:add(separate(nil, theme.colors.pastel.yellow))
				right_layout:add(tempicon)
				right_layout:add(tempwidget)
			end

			right_layout:add(separate(theme.colors.pastel.yellow, theme.colors.pastel.red))
			right_layout:add(neticon)
			right_layout:add(netwidget)

			right_layout:add(separate(theme.colors.pastel.red, nil))
			right_layout:add(memicon)
			right_layout:add(memwidget)

			right_layout:add(separate(nil, theme.colors.pastel.red))
			right_layout:add(cpuicon)
			right_layout:add(cpuwidget)
		end

		right_layout:add(separate(theme.colors.pastel.red, theme.colors.pastel.green))
		right_layout:add(volicon)
		right_layout:add(volumewidget)

		if batwidget then
			right_layout:add(separate(theme.colors.pastel.green, theme.colors.pastel.blue))
			right_layout:add(baticon)
			right_layout:add(batwidget)
		end

		right_layout:add(separate(theme.colors.pastel.blue, theme.colors.pastel.red))
		right_layout:add(mytextclock)

		right_layout:add(mylayoutbox[s])
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


-- BINDS
	-- MOUSE
		root.buttons(awful.util.table.join(
			awful.button({ modkey }, 3, function()
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
			awful.key({ modkey,		   }, "t", function() apps.run("terminal") end),
			awful.key({ modkey,	"Shift" }, "t", apps.bake("tmux")),

			awful.key({ modkey, "Control", "Shift" }, "r", awful.util.restart),
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

			awful.key( { modkey }, "x", function()
				awful.prompt.run(
					{ prompt = "Run Lua code: " },
					mypromptbox[mouse.screen].widget,
					awful.util.eval,
					nil,
					awful.util.getdir("cache") .. "/history_eval"
				)
			end),

			-- Menubar
			awful.key({ modkey }, "p", function() menubar.show() end),

			awful.key({ modkey }, "Delete", function() util.spawn("dm-tool lock") end),

			-- Volume keys
			awful.key({}, "XF86AudioRaiseVolume", function()
				util.spawn("pulseaudio-ctl up", false)
			end),
			awful.key({}, "XF86AudioLowerVolume", function()
				util.spawn("pulseaudio-ctl down", false)
			end),
			awful.key({}, "XF86AudioMute", function()
				util.spawn("pulseaudio-ctl mute", false)
			end),

			-- Screenshots
			awful.key({}, "Print", function()
				local file = os.date("%Y-%m-%d-%T.png")
				local path = "/srv/http/media/img/" .. file
				local url = "http://rhadden.com/media/img/" .. file

				util.spawn("escrotum " .. path, false)
				util.copy(url)

				naughty.notify({
					title = "Screenshot saved",
					text = path .. "\n" .. url
				})
			end),

			awful.key({ "Control", "Shift" }, "Print", function()
				local file = os.date("%Y-%m-%d-%T.png")
				local path = "/srv/http/media/img/" .. file
				local url = "http://rhadden.com/media/img/" .. file

				util.spawn("escrotum -s " .. path, false)
				util.copy(url)

				naughty.notify({
					title = "Screenshot saved",
					text = path .. "\n" .. url
				})
			end),

			-- Calculator
			awful.key({ modkey }, "c", function ()
				if not CACHE.calc then CACHE.calc = { expression = nil, equation = nil, result = nil } end

				awful.prompt.run(
					{
						prompt = "Calc: ",
						text = CACHE.calc.expression and tostring(CACHE.calc.expression)
					},
					mypromptbox[mouse.screen].widget,
					function (expression)
						if expression ~= "" then
							CACHE.calc.expression = expression
							CACHE.calc.equation = util.exec("qalc \"" .. expression .. "\"")
							CACHE.calc.result = util.exec("qalc -t \"" .. expression .. "\"")
							log(CACHE.calc.equation)
						end
					end,
					nil,
					awful.util.getdir("cache") .. "/history_calc"
				)
			end),

			-- Init environments
				-- reset
				awful.key({ modkey }, "F1", function()
					CACHE.env = nil
				end),

				-- dev
				awful.key({ modkey }, "F2", function()
					if CACHE.env ~= "dev" then
						CACHE.env = "dev"
						apps.init("dev")
					end
				end),

				-- zipscene
				awful.key({ modkey }, "F3", function()
					if CACHE.env ~= "zipscene" then
						CACHE.env = "zipscene"
						apps.init("zipscene")
					end
				end),

				-- test
				awful.key({ modkey }, "F4", function()
					if CACHE.env ~= "test" then
						CACHE.env = "test"
						apps.init("test")
					end
				end),

			-- Debug
			awful.key({ modkey, "Control", "Shift" }, "space", function()
				test("this", "is", { title = "aoeu" })
			end)
		)

		clientkeys = awful.util.table.join(
			awful.key({ modkey,		   }, "f",	  function(c) c.fullscreen = not c.fullscreen  end),
			awful.key({ modkey, "Shift"   }, "c",	  function(c) c:kill()						 end),
			awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle					 ),
			awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
			awful.key({ modkey,		   }, "o",	  awful.client.movetoscreen						),
			awful.key({ modkey,		   }, "t",	  function(c) c.ontop = not c.ontop			end),

			awful.key({ modkey,		   }, "n", function(c)
				-- The client currently has the input focus, so it cannot be
				-- minimized, since minimized clients can't have the focus.
				c.minimized = true
			end),

			awful.key({ modkey }, "m", function(c)
				c.maximized_horizontal = not c.maximized_horizontal
				c.maximized_vertical   = not c.maximized_vertical
			end)
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
	awful.rules.rules = {
		-- All clients will match this rule.
		{
			rule = {},
			properties = {
				border_width = theme.border_width,
				border_color = theme.border_normal,
				focus = awful.client.focus.filter,
				keys = clientkeys,
				buttons = clientbuttons
			}
		}, {
			rule = { class = "MPlayer" },
			properties = { floating = true }
		}, {
			rule = { class = "Qalculate!" },
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
		-- }, {
		-- 	rule = { instance = "geeqie" },
		-- 	properties = { tag = tags[util.screens.left][6] }
		-- }, {
		-- 	rule = { instance = "skype" },
		-- 	properties = { tag = tags[util.screens.left][7] }
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

			awful.titlebar(c, { position = "left" }):set_widget(vert)
		end
	end)

	client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
	client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)
