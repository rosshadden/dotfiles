--
require("modules/globals")
local awful = require("awful")
--


local util = {}

util.run = awful.util.spawn
util.shell = awful.util.spawn_with_shell
util.pread = awful.util.pread

util.exec = function(cmd)
	result = util.pread(cmd)
	if result:sub(-1) == "\n" then result = result:sub(1, -2) end
	return result
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

util.makeRun = function(cmd, title)
	local run = handlers["terminal"]
	if title then run = run .. " --title " .. title end
	run = run .. " -x " .. cmd
	return run
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

util.fileExists = function(path)
	local file = io.open(path, "r")
	if file ~= nil then io.close(file) return true end
	return false
end

-- Screens (may break out into module)
util.screens = {
	left = 1,
	right = math.min(2, screen.count()),
	count = screen.count()
}


util.color = {
	-- RGB to HSL
	rgbToHSL = function(r, g, b)
		--r, g, b = r/255, g/255, b/255
		local min = math.min(r, g, b)
		local max = math.max(r, g, b)
		local delta = max - min

		local h, s, l = 0, 0, ((min+max)/2)

		if l > 0 and l < 0.5 then s = delta/(max+min) end
		if l >= 0.5 and l < 1 then s = delta/(2-max-min) end

		if delta > 0 then
			if max == r and max ~= g then h = h + (g-b)/delta end
			if max == g and max ~= b then h = h + 2 + (b-r)/delta end
			if max == b and max ~= r then h = h + 4 + (r-g)/delta end
			h = h / 6;
		end

		if h < 0 then h = h + 1 end
		if h > 1 then h = h - 1 end

		return { h * 360, s, l }
	end,

	-- hex to HSL
	hexToHSL = function(hex)
		return util.color.rgbToHSL(
			tonumber(hex:sub(2, 3), 16) / 256,
			tonumber(hex:sub(4, 5), 16) / 256,
			tonumber(hex:sub(6, 7), 16) / 256
		)
	end,

	isLight = function(hex, tolerance)
		if not tolerance then tolerance = 0 end
		return util.color.hexToHSL(hex)[3] >= .5 - tolerance
	end,

	isDark = function(hex, tolerance)
		if not tolerance then tolerance = 0 end
		return util.color.hexToHSL(hex)[3] < .5 + tolerance
	end,

	isSaturated = function(hex, tolerance)
		if not tolerance then tolerance = 0 end
		return util.color.hexToHSL(hex)[2] >= .5 - tolerance
	end,
}


util.runOrRaise = function(cmd, properties)
	local matcher = function(c)
		return awful.rules.match(c, properties)
	end
	awful.client.run_or_raise(cmd, matcher)
end

-- Returns true if all pairs in table1 are present in table2
util.matchClient = function(table1, table2)
	for k, v in pairs(table1) do
		if table2[k] ~= v and not table2[k]:find(v) then
			return false
		end
	end
	return true
end

util.findClient = function(properties)
	for i, c in pairs(client.get()) do
		if util.matchClient(properties, c) then
			return c
		end
	end

	return false
end


return util
