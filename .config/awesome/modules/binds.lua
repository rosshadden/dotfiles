--
local awful = require("awful")
local menubar = require("menubar")
-- local radical = require("radical")
local alttab = require("radical.impl.alttab")

local apps = require("modules/apps")
local omni = require("modules/omni")
local util = require("modules/util")
--


local binds = {}

-- MOUSE
	local globalMouse = awful.util.table.join(
		awful.button({ SUPER }, 3, function()
			apps.menu.visible = not apps.menu.visible
		end),
		awful.button({}, 4, awful.tag.viewprev),
		awful.button({}, 5, awful.tag.viewnext)
	)

-- KEYS
	local globalkeys = awful.util.table.join(
		awful.key({ SUPER }, "h", awful.tag.viewprev),
		awful.key({ SUPER }, "l", awful.tag.viewnext),
		awful.key({ SUPER }, "Left", awful.tag.viewprev),
		awful.key({ SUPER }, "Right", awful.tag.viewnext),
		awful.key({ SUPER }, "Escape", awful.tag.history.restore),

		-- Move current client to previous tag.
		awful.key({ SUPER, "Shift"   }, "h",	 function()
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
		awful.key({ SUPER, "Shift"   }, "l",	 function()
			if client.focus then
				local index = ((awful.tag.getidx() + 1) % 10)
				index = (index > 0) and index or 1
				local tag = awful.tag.gettags(client.focus.screen)[index]
				if tag then
					awful.client.movetotag(tag)
				end
			end
		end),

		awful.key({ SUPER,		   }, "j",
			function()
				awful.client.focus.byidx( 1)
				if client.focus then client.focus:raise() end
			end),
		awful.key({ SUPER,		   }, "k",
			function()
				awful.client.focus.byidx(-1)
				if client.focus then client.focus:raise() end
			end),
		awful.key({ SUPER,		   }, "w", function()
			apps.menu.visible = true
		end),

		-- Layout manipulation
		awful.key({ SUPER, "Shift"   }, "j", function() awful.client.swap.byidx(  1)	end),
		awful.key({ SUPER, "Shift"   }, "k", function() awful.client.swap.byidx( -1)	end),
		awful.key({ SUPER, "Control" }, "l", function() awful.screen.focus_relative( 1) end),
		awful.key({ SUPER, "Control" }, "h", function() awful.screen.focus_relative(-1) end),
		awful.key({ SUPER,		   }, "u", awful.client.urgent.jumpto),

		-- Super+Tab: cycle through all clients
		awful.key({ SUPER,           }, "Tab"   , function() alttab.altTab()          end),
		awful.key({ SUPER, "Shift"   }, "Tab"   , function() alttab.altTabBack()      end),

		-- Alt+Tab: cycle through all clients
		awful.key({ META,           }, "Tab"   , function() alttab.altTab({ auto_release = true })          end),
		awful.key({ META, "Shift"   }, "Tab"   , function() alttab.altTabBack({ auto_release = true })      end),

		-- Standard program
		awful.key({ SUPER,		   }, "t", function() apps.run("terminal") end),
		awful.key({ SUPER,	"Shift" }, "t", apps.bake("tmux")),

		awful.key({ SUPER, "Control", "Shift" }, "r", function()
			mouse.coords({ x = 0, y = 0 })
			awful.util.restart()
		end),
		-- awful.key({ SUPER, "Shift"   }, "q", awesome.quit),

		awful.key({ SUPER,	"Control" }, "j",	 function() awful.tag.incmwfact( 0.05)	end),
		awful.key({ SUPER,	"Control" }, "k",	 function() awful.tag.incmwfact(-0.05)	end),
		-- awful.key({ SUPER, "Control", "Shift"   }, "h",	 function() awful.tag.incnmaster( 1)	  end),
		-- awful.key({ SUPER, "Control", "Shift"   }, "l",	 function() awful.tag.incnmaster(-1)	  end),
		-- awful.key({ SUPER, "Control" }, "h",	 function() awful.tag.incncol( 1)		 end),
		-- awful.key({ SUPER, "Control" }, "l",	 function() awful.tag.incncol(-1)		 end),
		awful.key({ SUPER,		   }, "space", function() awful.layout.inc(layouts,  1) end),
		awful.key({ SUPER, "Shift"   }, "space", function() awful.layout.inc(layouts, -1) end),

		awful.key({ SUPER, "Control" }, "n", awful.client.restore),

		-- Prompt
		awful.key({ SUPER }, "r", function()
			omni.menu()
		end),

		-- Omnibar
		awful.key({ SUPER }, "Return", function()
			omni.open()
		end),

		-- Menubar
		awful.key({ SUPER }, "p", function()
			menubar.show()
		end),

		-- execute lua
		awful.key( { SUPER }, "x", function()
			awful.prompt.run(
				{ prompt = "Run Lua code: " },
				mypromptbox[mouse.screen].widget,
				awful.util.eval,
				nil,
				awful.util.getdir("cache") .. "/history_eval"
			)
		end),

		awful.key({ SUPER }, "Delete", function() util.run("light-locker-command -l") end),

		-- Volume keys
		awful.key({}, "XF86AudioRaiseVolume", function()
			util.run("pulseaudio-ctl up", false)
		end),
		awful.key({}, "XF86AudioLowerVolume", function()
			util.run("pulseaudio-ctl down", false)
		end),
		awful.key({}, "XF86AudioMute", function()
			util.run("pulseaudio-ctl mute", false)
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

		-- Quake terminal
		awful.key({ META, "Shift" }, "e", (function()
			local lastClient

			return function()
				local properties = { name = "Quake" }
				local c = util.findClient(properties)

				if c then
					-- toggle visibility if focused
					if client.focus == c then
						c.hidden = true
						if lastClient then
							client.focus = lastClient
						end
					else
						lastClient = client.focus

						local tag = awful.tag.selected(1)
						awful.client.movetotag(tag, c)
						awful.client.movetoscreen(c, mouse.screen)

						c:raise()
						c.hidden = false
						client.focus = c
					end
				else
					-- open the terminal
					local cmd = handlers.terminal .. ' --title Quake --borderless --profile=quake -x tmux -2 new-session -A -s scratch'
					util.runOrRaise(cmd, properties)
				end
			end
		end)()),

		-- Calculator
		awful.key({ SUPER, "Control", "Shift" }, "c", function()
			if not CACHE.calc then CACHE.calc = { expression = nil, equation = nil, result = nil } end

			awful.prompt.run(
				{ prompt = "calc:  " },
				mypromptbox[mouse.screen].widget,
				function(expression)
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
			-- awful.key({ SUPER, "Control", "Shift" }, "F1", function()
			-- 	CACHE.env = nil
			-- end),

			-- -- dev
			-- awful.key({ SUPER, "Control", "Shift" }, "F2", function()
			-- 	if CACHE.env ~= "dev" then
			-- 		CACHE.env = "dev"
			-- 		apps.init("dev")
			-- 	end
			-- end),

			-- -- zipscene
			-- awful.key({ SUPER, "Control", "Shift" }, "F3", function()
			-- 	if CACHE.env ~= "zipscene" then
			-- 		CACHE.env = "zipscene"
			-- 		apps.init("zipscene")
			-- 	end
			-- end),

			-- -- test
			-- awful.key({ SUPER, "Control", "Shift" }, "F4", function()
			-- 	if CACHE.env ~= "test" then
			-- 		CACHE.env = "test"
			-- 		apps.init("test")
			-- 	end
			-- end),

		-- Apps
		awful.key({ SUPER }, "c", function()
			util.run("copyq toggle")
		end),
		
		-- Debug
		awful.key({ SUPER, "Control", "Shift" }, "space", function()
			log(screen[mouse.screen].geometry.width)
		end)
	)

	local clientkeys = awful.util.table.join(
		awful.key({ SUPER,		   }, "f",	  function(c) c.fullscreen = not c.fullscreen  end),
		awful.key({ SUPER, "Shift" }, "c",	  function(c) c:kill()						 end),
		awful.key({ SUPER, "Control" }, "space",  awful.client.floating.toggle					 ),
		awful.key({ SUPER, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),

		-- Move clients between screens
		awful.key({ SUPER }, "o", function(c)
			awful.client.movetoscreen(c, c.screen + 1)
		end),
		awful.key({ SUPER, "Shift" }, "o", function(c)
			awful.client.movetoscreen(c, c.screen - 1)
		end),

		awful.key({ SUPER,		   }, "t",	  function(c) c.ontop = not c.ontop			end),

		awful.key({ SUPER,		   }, "n", function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end),

		awful.key({ SUPER }, "m", function(c)
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
			awful.key({ SUPER }, "#" .. i + 9, function()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewonly(tag)
				end
			end),
			-- Toggle tag
			awful.key({ SUPER, "Control" }, "#" .. i + 9, function()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end),
			-- Move client to tag
			awful.key({ SUPER, "Shift" }, "#" .. i + 9, function()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen)[i]
					if tag then
						awful.client.movetotag(tag)
					end
				end
			end),
			-- Toggle client on tag
			awful.key({ SUPER, "Control", "Shift" }, "#" .. i + 9, function()
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
			awful.key({ SUPER }, "F" .. s, function()
				awful.screen.focus(s)
				local geometry = screen[mouse.screen].geometry
				mouse.coords(geometry)
			end),
			-- Move client to screen
			awful.key({ SUPER, "Shift" }, "F" .. s, function(client)
				awful.client.movetoscreen(client, s)
			end)
		)
	end

	local clientbuttons = awful.util.table.join(
		awful.button({}, 1, function(c) client.focus = c; c:raise() end),
		awful.button({ SUPER }, 1, awful.mouse.client.move),
		awful.button({ SUPER }, 3, awful.mouse.client.resize)
	)

binds.globalMouse = globalMouse
binds.globalkeys = globalkeys
binds.clientkeys = clientkeys
binds.clientbuttons = clientbuttons

return binds
