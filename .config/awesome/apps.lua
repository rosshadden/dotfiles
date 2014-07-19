local util = require("util")
local awful = require("awful")
local beautiful = require("beautiful")


hr = "-----------------------"


local apps = {}

apps.list = {
	chrome = {
		name = "Chrome",
		cmd = "chrome --profile-directory=Default",
		icon = util.getIconPath{ app = "google-chrome" }
	},

	["chrome-zipscene"] = {
		name = "Chrome - Zipscene",
		cmd = "chrome --profile-directory=Zipscene",
		icon = util.getIconPath{ app = "zipscene", size = 72, category = "places" }
	},

	firefox = {
		name = "Firefox",
		cmd = "firefox-aurora",
		icon = "/usr/share/pixmaps/firefox-aurora-icon.png"
	},

	atom = {
		name = "Atom",
		cmd = "atom",
	},

	gimp = {
		name = "Gimp",
		cmd = "gimp",
		icon = util.getIconPath{ app = "gimp" }
	},

	gimp = {
		name = "Pidgin",
		cmd = "pidgin",
		icon = util.getIconPath{ app = "pidgin" }
	},

	qalculate = {
		name = "Qalculate!",
		cmd = "qalculate-gtk",
		icon = "/usr/share/pixmaps/qalculate.png"
	},

	remmina = {
		name = "Remmina",
		cmd = "remmina",
		icon = util.getIconPath{ app = "remmina" }
	},

	robomongo = {
		name = "Robomongo",
		cmd = "robomongo",
		icon = "/usr/share/robomongo/share/icons/robomongo.png"
	},

	skype = {
		name = "Skype",
		cmd = "skype",
		icon = util.getIconPath{ app = "skype" }
	},

	spacefm = {
		name = "SpaceFM",
		cmd = "spacefm",
		icon = util.getIconPath{ app = "spacefm", size = 48 }
	},

	steam = {
		name = "Steam",
		cmd = "steam",
		icon = util.getIconPath{ app = "steam" }
	},

	sublime = {
		name = "Sublime Text",
		cmd = "subl",
		icon = util.getIconPath{ app = "sublime-text" }
	},

	terminator = {
		name = "Terminator",
		cmd = "terminator",
		icon = util.getIconPath{ app = "terminator" }
	},

	tmux = {
		name = "Tmux",
		cmd = function(name)
			if type(name) ~= "string" then name = awful.tag.selected(mouse.screen).name end

			local pid
			local doesExist = util.exec("tmux list-sessions | sed -r 's|^(.+): .*|\\1|' | grep " .. name)
			if doesExist == name then
				pid = util.spawn(util.makeRun("tmux attach -t " .. name))
			else
				pid = util.spawn(util.makeRun("tmux new-session -s " .. name))
			end
			return pid
		end,
	},

	transmission = {
		name = "Transmission",
		cmd = "transmission-gtk"
	},
}
apps.list.terminal = apps.list.terminator
apps.list.fm = apps.list.spacefm


apps.get = function(app)
	return apps.list[app]
end


-- TODO: remove global
handlers = {
	terminal = apps.get("terminator").cmd,
	fm = apps.get("spacefm").cmd,
	editor = os.getenv("EDITOR") or "vim"
}
handlers.edit = handlers.terminal .. " -e " .. handlers.editor


-- TODO: Allow infinite args
apps.bake = function(app, arg)
	if type(app) == "string" then app = apps.get(app) end
	if type(app) == "function" then return app end

	local fn
	local cmd = app.cmd

	if type(cmd) == "function" then
		if arg then
			fn = function()
				return cmd(arg)
			end
		else
			fn = cmd
		end
	elseif arg then
		cmd = cmd .. " " .. arg
	end

	if type(cmd) == "string" then
		fn = function()
			return util.spawn(cmd)
		end
	end

	return fn
end

apps.run = function(app, arg)
	return apps.bake(app, arg)()
end


local makeEntry = function(app)
	if type(app) == "string" then
		app = apps.get(app)
	elseif util.isArray(app) then
		return app
	end

	local entry = { app.name, app.cmd }
	if app.icon then table.insert(entry, app.icon) end

	return entry
end


-- MENU
	local appsMenu = {
		makeEntry("chrome"),
		makeEntry("chrome-zipscene"),
		makeEntry("sublime"),
		makeEntry("atom"),
		makeEntry("firefox"),
		makeEntry("steam"),
		makeEntry("transmission"),
		makeEntry("gimp"),
		makeEntry("skype"),
		makeEntry("robomongo"),
		makeEntry("qalculate"),
		makeEntry("remmina"),
	}

	local filesMenu = {
		makeEntry("spacefm"),
		{ "Home", apps.bake("spacefm", "~") },
		{ "Dropbox", apps.bake("spacefm", "~/Dropbox") },
		{ "Downloads", apps.bake("spacefm", "~/downloads") },
	}

	local terminalMenu = {
		makeEntry("terminator"),
		makeEntry("tmux"),
	}

	local soundMenu = {
		{ "ALSA", handlers.terminal .. " -e alsamixer" },
		{ "Mute toggle", "pulseaudio-ctl mute" },
	}

	local awesomeMenu = {
		{ "manual", handlers.terminal .. " -e man awesome" },
		{ "edit config", handlers.edit .. " " .. awesome.conffile },
		{ "restart", awesome.restart },
		{ "quit", awesome.quit },
	}

	local powerMenu = {
		{ "awesome", awesomeMenu, beautiful.awesome_icon },
		{ "Switch user", "dm-tool switch-to-greeter" },
		{ "Lock", "dm-tool lock" },
		{ "Sleep", "systemctl suspend" },
		-- { "Hibernate", "systemctl hibernate" },
		-- { "Hybrid-sleep", "systemctl hybrid-sleep" },
		{ "Reboot", "systemctl reboot" },
		{ "Shutdown", "systemctl poweroff" },
	}

	apps.menu = {
		items = {
			{ "APPS", appsMenu, beautiful.awesome_icon },
			{ hr },
			{ "FILES", filesMenu, util.getIconPath{ app = "spacefm", size = 48 }},
			{ "TERMINAL", terminalMenu, util.getIconPath{ app = "terminator" }},
			-- { "SOUND", soundMenu },
			{ hr },
			{ "POWER", powerMenu },
		}
	}


-- INIT
	local init = {}
	init.dev = {
		{ app = apps.get("chrome"), screen = util.screens.left, tag = 1 },
		{ app = apps.get("sublime"), screen = util.screens.right, tag = 2 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 3 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 4 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 8 },
	}
	if util.screens.count == 2 then
		table.insert(init.dev, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 3 })
		table.insert(init.dev, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 4 })
		table.insert(init.dev, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 8 })
	end

	init.zipscene = {
		{ app = apps.get("chrome-zipscene"), screen = util.screens.left, tag = 1 },
		{ app = apps.get("chrome"), screen = util.screens.right, tag = 1 },
		{ app = apps.get("sublime"), screen = util.screens.right, tag = 2 },
		{ app = apps.get("skype"), screen = util.screens.right, tag = 7 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 3 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 4 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 8 },
		{ app = apps.bake("tmux", ""), screen = util.screens.left, tag = 9 },
	}
	if util.screens.count == 2 then
		table.insert(init.zipscene, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 3 })
		table.insert(init.zipscene, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 4 })
		table.insert(init.zipscene, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 8 })
		table.insert(init.zipscene, { app = apps.bake("tmux", ""), screen = util.screens.right, tag = 9 })
	end

	init.test = {
		{ app = apps.bake("tmux", "test"), screen = util.screens.right, tag = 6 },
		{ app = apps.bake("tmux", "aoeu"), screen = util.screens.right, tag = 7 },
	}

	apps.init = function(profile)
		local rules = {}
		local numCaught = 0

		rules.handler = function(c, startup)
			local entry = rules[c.pid]
			if entry then
				local tag = awful.tag.gettags(entry.screen)
				awful.client.movetotag(tag[entry.tag], c)
				numCaught = numCaught + 1
			end

			if numCaught == table.maxn(init[profile]) then
				client.disconnect_signal("manage", rules.handler)
			end
		end
		client.connect_signal("manage", rules.handler)

		for e, entry in ipairs(init[profile]) do
			local pid = apps.run(entry.app)
			rules[pid] = entry
		end
	end


return apps
