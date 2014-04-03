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

	gimp = {
		name = "Gimp",
		cmd = "gimp",
		icon = util.getIconPath{ app = "gimp" }
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
			if not name then name = awful.tag.selected(mouse.screen).name end

			local doesExist = util.exec("tmux list-sessions | sed -r 's|^(.+): .*|\\1|' | grep " .. name)
			if doesExist == name .. "\n" then
				util.spawn(util.makeRun("tmux attach -t " .. name))
			else
				util.spawn(util.makeRun("tmux new-session -s " .. name))
			end
		end,
	},

	transmission = {
		name = "Transmission",
		cmd = "transmission-gtk"
	},
}


apps.get = function(app)
	return apps.list[app]
end

-- TODO: Allow infinite args
apps.bake = function(app, arg)
	if type(app) == "string" then app = apps.get(app) end
	fn = app.cmd

	if type(fn) == "function" and arg then
		fn = function()
			app.cmd(arg)
		end
	elseif arg then
		fn = fn .. " " .. arg
	end

	return fn
end

apps.run = function(app, arg)
	apps.bake(app, arg)()
end


local makeEntry = function(app)
	if type(app) == "string" then
		app = apps.list[app]
	elseif util.isArray(app) then
		return app
	end

	local entry = { app.name, app.cmd }
	if app.icon then table.insert(entry, app.icon) end

	return entry
end


-- TODO: remove global
handlers = {
	terminal = apps.get("terminator").cmd,
	fm = apps.get("spacefm").cmd,
	editor = os.getenv("EDITOR") or "vim"
}
handlers.edit = handlers.terminal .. " -e " .. handlers.editor


-- MENU
	appsMenu = {
		makeEntry("chrome"),
		makeEntry("chrome-zipscene"),
		makeEntry("sublime"),
		makeEntry("firefox"),
		makeEntry("steam"),
		makeEntry("transmission"),
		makeEntry("gimp"),
		makeEntry("skype"),
		makeEntry("robomongo"),
		makeEntry("qalculate"),
		makeEntry("remmina"),
	}

	filesMenu = {
		makeEntry("spacefm"),
		{ "Home", apps.bake("spacefm", "~") },
		{ "Dropbox", apps.bake("spacefm", "~/Dropbox") },
		{ "Downloads", apps.bake("spacefm", "~/downloads") },
	}

	terminalMenu = {
		makeEntry("terminator"),
		makeEntry("tmux"),
	}

	soundMenu = {
		{ "ALSA", handlers.terminal .. " -e alsamixer" },
		{ "Mute toggle", "pulseaudio-ctl mute" },
	}

	awesomeMenu = {
		{ "manual", handlers.terminal .. " -e man awesome" },
		{ "edit config", handlers.edit .. " " .. awesome.conffile },
		{ "restart", awesome.restart },
		{ "quit", awesome.quit },
	}

	powerMenu = {
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


return apps
