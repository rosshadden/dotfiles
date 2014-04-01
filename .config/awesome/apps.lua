local util = require("util")
local awful = require("awful")
local beautiful = require("beautiful")


hr = "-----------------------"


local apps = {}

apps.list = {
	chrome = {
		name = "Chrome",
		run = "chrome --profile-directory=Default",
		icon = util.getIconPath{ app = "google-chrome" }
	},

	["chrome-zipscene"] = {
		name = "Chrome - Zipscene",
		run = "chrome --profile-directory=Zipscene",
		icon = util.getIconPath{ app = "zipscene", size = 72, category = "places" }
	},

	firefox = {
		name = "Firefox",
		run = "firefox-aurora",
		icon = "/usr/share/pixmaps/firefox-aurora-icon.png"
	},

	gimp = {
		name = "Gimp",
		run = "gimp",
		icon = util.getIconPath{ app = "gimp" }
	},

	qalculate = {
		name = "Qalculate!",
		run = "qalculate-gtk",
		icon = "/usr/share/pixmaps/qalculate.png"
	},

	remmina = {
		name = "Remmina",
		run = "remmina",
		icon = util.getIconPath{ app = "remmina" }
	},

	robomongo = {
		name = "Robomongo",
		run = "robomongo",
		icon = "/usr/share/robomongo/share/icons/robomongo.png"
	},

	skype = {
		name = "Skype",
		run = "skype",
		icon = util.getIconPath{ app = "skype" }
	},

	spacefm = {
		name = "SpaceFM",
		run = "spacefm",
		icon = util.getIconPath{ app = "spacefm", size = 48 }
	},

	steam = {
		name = "Steam",
		run = "steam",
		icon = util.getIconPath{ app = "steam" }
	},

	sublime = {
		name = "Sublime Text",
		run = "subl",
		icon = util.getIconPath{ app = "sublime-text" }
	},

	terminator = {
		name = "Terminator",
		run = "terminator",
		icon = util.getIconPath{ app = "terminator" }
	},

	tmux = {
		name = "Tmux",
		run = function(name)
			local tmuxify = function()
				if not name then name = awful.tag.selected(mouse.screen).name end

				local doesExist = util.exec("tmux list-sessions | sed -r 's|^(.+): .*|\\1|' | grep " .. name)
				if doesExist == name .. "\n" then
					util.spawn(util.makeRun("tmux attach -t " .. name))
				else
					util.spawn(util.makeRun("tmux new-session -s " .. name))
				end
			end

			-- Run or return.
			if not name then tmuxify() else return tmuxify end
		end,
	},

	transmission = {
		name = "Transmission",
		run = "transmission-gtk"
	},
}


apps.get = function(app)
	return apps.list[app]
end

apps.run = function(app, args)
	if type(app) == "string" then app = apps.get(app) end
	run = app.run
	if args then run = run .. " " .. args end
	return run
end


local makeEntry = function(app)
	if type(app) == "string" then
		app = apps.list[app]
	elseif util.isArray(app) then
		return app
	end

	local entry = { app.name, app.run }
	if app.icon then table.insert(entry, app.icon) end

	return entry
end


-- TODO: remove global
handlers = {
	terminal = apps.get("terminator").run,
	fm = apps.get("spacefm").run,
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
