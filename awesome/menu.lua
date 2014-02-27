getImagePath = function(options)
	options.size = options.size or "32"
	options.category = options.category or "apps"
	options.ext = options.ext or "png"
	local icon = "/usr/share/icons/hicolor/" .. options.size .. "x" .. options.size .. "/" .. options.category .. "/" .. options.app .. "." .. options.ext
	print(icon)
	return icon
end

makeBrowse = function(path)
	return handlers["fm"] .. " " .. path
end

makeRun = function(cmd)
	return handlers["terminal"] .. " -x run " .. cmd
end

hr = "-----------------------"


function init(awesome, awful, beautiful)
	local exec = awful.util.spawn

	awesomeMenu = {
		{ "manual", handlers["terminal"] .. " -e man awesome" },
		{ "edit config", handlers["edit"] .. " " .. awesome.conffile },
		{ "restart", awesome.restart }
	}

	appsMenu = {
		{ "Chrome", "chrome --profile-directory=Default", getImagePath{ app = "google-chrome" }},
		{ "Chrome - Zipscene", "chrome --profile-directory=Zipscene", getImagePath{ app = "zipscene", size = 72, category = "places" }},
		{ "Sublime Text", "subl", getImagePath{ app = "sublime-text" }},
		{ "SpaceFM", handlers["fm"], getImagePath{ app = "spacefm", size = 48 }},
		{ "Terminator", handlers["terminal"], getImagePath{ app = "terminator" }},
		{ "Gimp", "gimp", getImagePath{ app = "gimp" }},
		{ "Skype", "skype", getImagePath{ app = "skype" }},
	}

	filesMenu = {
		{ "Home", makeBrowse("~") },
		{ "Download", makeBrowse("~/downloads") },
	}

	terminalMenu = {
		{ "Finch", makeRun("finch") },
		{ "Tmux", function()
			local curTag = awful.tag.selected(mouse.screen).name
			local doesExist = awful.util.pread("tmux list-sessions | sed -r 's|^(\\w+): .*|\\1|' | grep " .. curTag )
			if doesExist == curTag .. "\n" then
				exec(makeRun("tmux attach -t " .. curTag))
			else
				exec(makeRun("tmux new-session -s " .. curTag))
			end
		end },
	}

	soundMenu = {
		{ "ALSA", handlers["terminal"] .. " -e alsamixer" },
		{ "Mute toggle", "amixer set Master toggle" }
	}

	powerMenu = {
		{ "awesome", awesomeMenu, beautiful.awesome_icon },
		{ "Switch user", "dm-tool switch-to-greeter" },
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
			{ "FILES", filesMenu, getImagePath{ app = "spacefm", size = 48 }},
			{ "TERMINAL", terminalMenu, getImagePath{ app = "terminator" }},
			{ "SOUND", soundMenu },
			{ hr },
			{ "POWER", powerMenu },
		}
	}
end

return init
