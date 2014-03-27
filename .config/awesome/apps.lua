local util = require("util")
local beautiful = require("beautiful")


hr = "-----------------------"


local apps = {}

apps["list"] = {
	chrome = {
		name = "Chrome",
		cmd = "chrome --profile-directory=Default",
		icon = util.getImagePath{ app = "google-chrome" }
	},

	chromeZipscene = {
		name = "Chrome - Zipscene",
		cmd = "chrome --profile-directory=Zipscene",
		icon = util.getImagePath{ app = "zipscene", size = 72, category = "places" }
	},

	sublime = {
		name = "Sublime Text",
		cmd = "subl",
		icon = util.getImagePath{ app = "sublime-text" }
	},

	firefox = {
		name = "Firefox",
		cmd = "firefox-aurora",
	},

	steam = {
		name = "Steam",
		cmd = "steam",
		icon = util.getImagePath{ app = "steam" }
	},

	gimp = {
		name = "Gimp",
		cmd = "gimp",
		icon = util.getImagePath{ app = "gimp" }
	},

	skype = {
		name = "Skype",
		cmd = "skype",
		icon = util.getImagePath{ app = "skype" }
	},
}


-- TODO: remove global
handlers = {
	terminal = "terminator",
	fm = "spacefm",
	editor = os.getenv("EDITOR") or "vim"
}
handlers["edit"] = handlers["terminal"] .. " -e " .. handlers["editor"]


local makeEntry = function(app)
	if type(app) == "string" then
		app = apps["list"][app]
	elseif util.isArray(app) then
		return app
	end

	local entry = { app["name"], app["cmd"] }
	if app["icon"] then table.insert(entry, app["icon"]) end

	return entry
end


-- MENU
	appsMenu = {
		makeEntry("chrome"),
		makeEntry("chromeZipscene"),
		makeEntry("sublime"),
		makeEntry("firefox"),
		makeEntry("steam"),
		makeEntry("gimp"),
		makeEntry("skype"),
	}

	filesMenu = {
		{ "SpaceFM", handlers["fm"], util.getImagePath{ app = "spacefm", size = 48 }},
		{ "Home", util.makeBrowse("~") },
		{ "Dropbox", util.makeBrowse("~/Dropbox") },
		{ "Downloads", util.makeBrowse("~/downloads") },
	}

	terminalMenu = {
		{ "Terminator", handlers["terminal"], util.getImagePath{ app = "terminator" }},
		{ "Tmux", util.tmuxify },
	}

	soundMenu = {
		{ "ALSA", handlers["terminal"] .. " -e alsamixer" },
		{ "Mute toggle", "pulseaudio-ctl mute" },
	}

	awesomeMenu = {
		{ "manual", handlers["terminal"] .. " -e man awesome" },
		{ "edit config", handlers["edit"] .. " " .. awesome.conffile },
		{ "restart", awesome.restart },
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

	apps["menu"] = {
		items = {
			{ "APPS", appsMenu, beautiful.awesome_icon },
			{ hr },
			{ "FILES", filesMenu, util.getImagePath{ app = "spacefm", size = 48 }},
			{ "TERMINAL", terminalMenu, util.getImagePath{ app = "terminator" }},
			{ "SOUND", soundMenu },
			{ hr },
			{ "POWER", powerMenu },
		}
	}


return apps
