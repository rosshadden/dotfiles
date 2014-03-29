local awful = require("awful")

local spawn = awful.util.spawn
local exec = awful.util.pread

local getIconPath = function(options)
	options.size = options.size or "32"
	options.category = options.category or "apps"
	options.ext = options.ext or "png"
	local icon = "/usr/share/icons/hicolor/" .. options.size .. "x" .. options.size .. "/" .. options.category .. "/" .. options.app .. "." .. options.ext
	return icon
end

local makeBrowse = function(path)
	return handlers["fm"] .. " " .. path
end

local makeRun = function(cmd)
	return handlers["terminal"] .. " -x run " .. cmd
end

local tmuxify = function()
	local curTag = awful.tag.selected(mouse.screen).name
	local doesExist = exec("tmux list-sessions | sed -r 's|^(.+): .*|\\1|' | grep " .. curTag)
	if doesExist == curTag .. "\n" then
		spawn(makeRun("tmux attach -t " .. curTag))
	else
		spawn(makeRun("tmux new-session -s " .. curTag))
	end
end

local isArray = function(t)
	local i = 0
	for _ in pairs(t) do
		i = i + 1
		if t[i] == nil then return false end
	end
	return true
end


return {
	spawn = spawn,
	exec = exec,
	getIconPath = getIconPath,
	makeBrowse = makeBrowse,
	makeRun = makeRun,
	tmuxify = tmuxify,
	isArray = isArray,
}
