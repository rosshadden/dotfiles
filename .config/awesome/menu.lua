local util = require("util")


hr = "-----------------------"


function init(awesome, beautiful)
	awesomeMenu = {
		{ "manual", handlers["terminal"] .. " -e man awesome" },
		{ "edit config", handlers["edit"] .. " " .. awesome.conffile },
		{ "restart", awesome.restart }
	}

	appsMenu = {
		{ "Chrome", "chrome --profile-directory=Default", util.getImagePath{ app = "google-chrome" }},
		{ "Chrome - Zipscene", "chrome --profile-directory=Zipscene", util.getImagePath{ app = "zipscene", size = 72, category = "places" }},
		{ "Sublime Text", "subl", util.getImagePath{ app = "sublime-text" }},
		{ "Steam", "steam", util.getImagePath{ app = "steam" }},
		{ "Gimp", "gimp", util.getImagePath{ app = "gimp" }},
		{ "Skype", "skype", util.getImagePath{ app = "skype" }},
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
		{ "Finch", util.makeRun("finch") },
	}

	soundMenu = {
		{ "ALSA", handlers["terminal"] .. " -e alsamixer" },
		{ "Mute toggle", "pulseaudio-ctl mute" }
	}

	powerMenu = {
		{ "awesome", awesomeMenu, beautiful.awesome_icon },
		{ "Switch user", "dm-tool switch-to-greeter" },
		{ "Lock", "dm-tool lock" },
		{ "Sleep", "systemctl suspend" },
		-- { "Hibernate", "systemctl hibernate" },
		-- { "Hybrid-sleep", "systemctl hybrid-sleep" },
		{ "Reboot", "systemctl reboot" },
		{ "Shutdown", "systemctl poweroff" }
	}

	return {
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
end

return init
