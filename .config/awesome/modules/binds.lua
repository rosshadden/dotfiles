--
local awful = require("awful")
local menubar = require("menubar")
-- local radical = require("radical")
local alttab = require("radical.impl.alttab")

local apps = require("modules/apps")
local util = require("modules/util")
--


local binds = {}

-- MOUSE
	local globalMouse = awful.util.table.join(
		awful.button({ modkey }, 3, function()
			apps.menu.visible = not apps.menu.visible
		end),
		awful.button({}, 4, awful.tag.viewprev),
		awful.button({}, 5, awful.tag.viewnext)
	)

-- KEYS
	local globalkeys = awful.util.table.join(
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
		awful.key({ modkey,		   }, "w", function()
			apps.menu.visible = true
		end),

		-- Layout manipulation
		awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(  1)	end),
		awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx( -1)	end),
		awful.key({ modkey, "Control" }, "l", function() awful.screen.focus_relative( 1) end),
		awful.key({ modkey, "Control" }, "h", function() awful.screen.focus_relative(-1) end),
		awful.key({ modkey,		   }, "u", awful.client.urgent.jumpto),

		-- Super+Tab: cycle through all clients
		awful.key({ modkey,           }, "Tab"   , function() alttab.altTab()          end),
		awful.key({ modkey, "Shift"   }, "Tab"   , function() alttab.altTabBack()      end),

		-- Alt+Tab: cycle through all clients
		awful.key({ "Mod1",           }, "Tab"   , function() alttab.altTab({ auto_release = true })          end),
		awful.key({ "Mod1", "Shift"   }, "Tab"   , function() alttab.altTabBack({ auto_release = true })      end),

		-- Standard program
		awful.key({ modkey,		   }, "t", function() apps.run("terminal") end),
		awful.key({ modkey,	"Shift" }, "t", apps.bake("tmux")),

		awful.key({ modkey, "Control", "Shift" }, "r", function()
			mouse.coords({ x = 0, y = 0 })
			awful.util.restart()
		end),
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

		awful.key({ modkey }, "Delete", function() util.spawn("light-locker-command -l") end),

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

			util.shell("escrotum " .. path)
			util.copy(url)

			note = naughty.notify({
				title = "Screenshot saved",
				text = path .. "\n" .. url .. "\n" .. "Click to move to Dropbox.",
				timeout = 20,
				run = function()
					naughty.destroy(note)
					local newPath = "~/Dropbox/Public/media/images/ss/" .. file
					util.shell("mv " .. path .. " " .. newPath)
					local puburl = util.exec("dropbox puburl " .. newPath)
					util.copy(puburl)
					log("Moved to " .. newPath .. "\n" .. "Available at " .. puburl)
				end
			})
		end),

		awful.key({ "Control", "Shift" }, "Print", function()
			local file = os.date("%Y-%m-%d-%T.png")
			local path = "/srv/http/media/img/" .. file
			local url = "http://rhadden.com/media/img/" .. file

			util.shell("escrotum -s " .. path)
			util.copy(url)

			note = naughty.notify({
				title = "Screenshot saved",
				text = path .. "\n" .. url .. "\n" .. "Click to move to Dropbox.",
				timeout = 20,
				run = function()
					naughty.destroy(note)
					local newPath = "~/Dropbox/Public/media/images/ss/" .. file
					util.shell("mv " .. path .. " " .. newPath)
					local puburl = util.exec("dropbox puburl " .. newPath)
					util.copy(puburl)
					log("Moved to " .. newPath .. "\n" .. "Available at " .. puburl)
				end
			})
		end),

		-- Calculator
		awful.key({ modkey }, "c", function ()
			if not CACHE.calc then CACHE.calc = { expression = nil, equation = nil, result = nil } end

			awful.prompt.run(
				{ prompt = "calc:  " },
				mypromptbox[mouse.screen].widget,
				function (expression)
					if expression ~= "" then
						CACHE.calc.expression = expression
						CACHE.calc.equation = util.exec("qalc \"" .. expression .. "\"")
						CACHE.calc.result = util.exec("qalc -t \"" .. expression .. "\"")

						log(CACHE.calc.equation, {
							run = function()
								util.copy(CACHE.calc.result)
							end
						})
					end
				end,
				nil,
				awful.util.getdir("cache") .. "/history_calc"
			)
		end),

		-- Init environments
			-- -- reset
			-- awful.key({ modkey, "Control", "Shift" }, "F1", function()
			-- 	CACHE.env = nil
			-- end),

			-- -- dev
			-- awful.key({ modkey, "Control", "Shift" }, "F2", function()
			-- 	if CACHE.env ~= "dev" then
			-- 		CACHE.env = "dev"
			-- 		apps.init("dev")
			-- 	end
			-- end),

			-- -- zipscene
			-- awful.key({ modkey, "Control", "Shift" }, "F3", function()
			-- 	if CACHE.env ~= "zipscene" then
			-- 		CACHE.env = "zipscene"
			-- 		apps.init("zipscene")
			-- 	end
			-- end),

			-- -- test
			-- awful.key({ modkey, "Control", "Shift" }, "F4", function()
			-- 	if CACHE.env ~= "test" then
			-- 		CACHE.env = "test"
			-- 		apps.init("test")
			-- 	end
			-- end),

		-- Debug
		awful.key({ modkey, "Control", "Shift" }, "space", function()
			log("ueoa", { title = "aoeu" })
		end)
	)

	local clientkeys = awful.util.table.join(
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
			-- Switch to tag
			awful.key({ modkey }, "#" .. i + 9, function()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewonly(tag)
				end
			end),
			-- Toggle tag
			awful.key({ modkey, "Control" }, "#" .. i + 9, function()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end),
			-- Move client to tag
			awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen)[i]
					if tag then
						awful.client.movetotag(tag)
					end
				end
			end),
			-- Toggle client on tag
			awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen)[i]
					if tag then
						awful.client.toggletag(tag)
					end
				end
			end)
		)
	end

	for s = 1, screen.count() do
		globalkeys = awful.util.table.join(globalkeys,
			-- Focus screen
			awful.key({ modkey }, "F" .. s, function()
				awful.screen.focus(s)
			end),
			-- Move client to screen
			awful.key({ modkey, "Shift" }, "F" .. s, function(client)
				awful.client.movetoscreen(client, s)
			end)
		)
	end

	local clientbuttons = awful.util.table.join(
		awful.button({}, 1, function(c) client.focus = c; c:raise() end),
		awful.button({ modkey }, 1, awful.mouse.client.move),
		awful.button({ modkey }, 3, awful.mouse.client.resize)
	)

binds.globalMouse = globalMouse
binds.globalkeys = globalkeys
binds.clientkeys = clientkeys
binds.clientbuttons = clientbuttons

return binds
