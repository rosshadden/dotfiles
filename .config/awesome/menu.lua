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

	tmuxThatShit = function()
		local curTag = awful.tag.selected(mouse.screen).name
		local doesExist = awful.util.pread("tmux list-sessions | sed -r 's|^(.+): .*|\\1|' | grep " .. curTag )
		if doesExist == curTag .. "\n" then
			exec(makeRun("tmux attach -t " .. curTag))
		else
			exec(makeRun("tmux new-session -s " .. curTag))
		end
	end

	awesomeMenu = {
		{ "manual", handlers["terminal"] .. " -e man awesome" },
		{ "edit config", handlers["edit"] .. " " .. awesome.conffile },
		{ "restart", awesome.restart }
	}

	appsMenu = {
		{ "Chrome", "chrome --profile-directory=Default", getImagePath{ app = "google-chrome" }},
		{ "Chrome - Zipscene", "chrome --profile-directory=Zipscene", getImagePath{ app = "zipscene", size = 72, category = "places" }},
		{ "Sublime Text", "subl", getImagePath{ app = "sublime-text" }},
		{ "Steam", "steam", getImagePath{ app = "steam" }},
		{ "Gimp", "gimp", getImagePath{ app = "gimp" }},
		{ "Skype", "skype", getImagePath{ app = "skype" }},
	}

	filesMenu = {
		{ "SpaceFM", handlers["fm"], getImagePath{ app = "spacefm", size = 48 }},
		{ "Home", makeBrowse("~") },
		{ "Dropbox", makeBrowse("~/Dropbox") },
		{ "Downloads", makeBrowse("~/downloads") },
	}

	terminalMenu = {
		{ "Terminator", handlers["terminal"], getImagePath{ app = "terminator" }},
		{ "Tmux", tmuxThatShit },
		{ "Finch", makeRun("finch") },
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
			{ "FILES", filesMenu, getImagePath{ app = "spacefm", size = 48 }},
			{ "TERMINAL", terminalMenu, getImagePath{ app = "terminator" }},
			{ "SOUND", soundMenu },
			{ hr },
			{ "POWER", powerMenu },
		}
	}
end

return init
