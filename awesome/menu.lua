getImagePath = function(app, size)
	size = size or "32"
	return "/usr/share/icons/hicolor/" .. size .. "x" .. size .. "/apps/" .. app .. ".png"
end

hr = "-----------------------"


function init(awesome, beautiful)
	awesomemenu = {
		{ "manual", handlers["terminal"] .. " -e man awesome" },
		{ "edit config", handlers["edit"] .. " " .. awesome.conffile },
		{ "restart", awesome.restart }
	}

	appsmenu = {
		{ "Chrome", "chrome", getImagePath("google-chrome") },
		{ "Sublime Text", "subl", getImagePath("sublime-text") },
		{ "Skype", "skype", getImagePath("skype") },
	}

	soundmenu = {
		{ "ALSA", handlers["terminal"] .. " -e alsamixer" },
		{ "Mute toggle", "amixer set Master toggle" }
	}

	powermenu = {
		{ "awesome", awesomemenu, beautiful.awesome_icon },
		{ "Switch user", "dm-tool switch-to-greeter" },
		{ "Sleep", "systemctl suspend" },
		-- { "Hibernate", "systemctl hibernate" },
		-- { "Hybrid-sleep", "systemctl hybrid-sleep" },
		{ "Reboot", "systemctl reboot" },
		{ "Shutdown", "systemctl poweroff" }
	}

	return {
		items = {
			{ "apps", appsmenu, beautiful.awesome_icon },
			{ hr },
			{ "sound", soundmenu },
			{ "files", handlers["fm"], getImagePath("spacefm", 48) },
			{ "terminal", handlers["terminal"], getImagePath("terminator") },
			{ hr },
			{ "power", powermenu },
		}
	}
end

return init
