require("globals")
local awful = require("awful")


local util = {}

util.spawn = awful.util.spawn
util.exec = awful.util.pread

test = function(...)
	log(...)
end

util.getIconPath = function(options)
	options.size = options.size or "32"
	options.category = options.category or "apps"
	options.ext = options.ext or "png"
	local icon = "/usr/share/icons/hicolor/" .. options.size .. "x" .. options.size .. "/" .. options.category .. "/" .. options.app .. "." .. options.ext
	return icon
end

util.makeBrowse = function(path)
	return handlers["fm"] .. " " .. path
end

util.makeRun = function(cmd)
	return handlers["terminal"] .. " -x run " .. cmd
end

util.copy = function(contents)
	util.exec("echo -n " .. contents .. " | xsel -ib")
	return contents
end

util.paste = function()
	local contents = util.exec("xsel -b")
	return contents
end

util.isArray = function(t)
	local i = 0
	for _ in pairs(t) do
		i = i + 1
		if t[i] == nil then return false end
	end
	return true
end

-- Screens (may break out into module)
util.screens = {
	left = 1,
	right = screen.count(),
	count = screen.count()
}


return util
