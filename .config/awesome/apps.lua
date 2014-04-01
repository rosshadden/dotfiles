local util = require("util")
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
		cmd = util.tmuxify,
	},

	transmission = {
		name = "Transmission",
		cmd = "transmission-gtk"
	},
}


apps.get = function(app)
	return apps.list[app]
end

apps.run = function(app, args)
	if type(app) == "string" then app = apps.get(app) end
	cmd = app.cmd
	if args then cmd = cmd .. " " .. args end
	return cmd
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
		{ "Home", apps.run("spacefm", "~") },
		{ "Dropbox", apps.run("spacefm", "~/Dropbox") },
		{ "Downloads", apps.run("spacefm", "~/downloads") },
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
