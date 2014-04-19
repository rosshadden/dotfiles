local awful = require("awful")
local naughty = require("naughty")


-- globals
	map = function(array, fn)
		local new = {}
		for index, element in pairs(array) do
			new[index] = fn(element, index)
		end
		return new
	end

	filter = function(array, fn)
		local new = {}
		for index, element in pairs(array) do
			if fn(element, index) then
				new[index] = element
			end
		end
		return new
	end

	reduce = function(array, fn, value)
		for index, element in pairs(array) do
			value = fn(value, element, index)
		end
		return value
	end

	log = function(...)
		local options = {}

		local args = { n = select("#", ...), ... }
		if type(args[args.n]) == "table" then
			options = table.remove(args, args.n)
			args.n = select("#", unpack(args))
		end

		if args.n == 2 then
			options.title = options.title or tostring(table.remove(args, 1))
			-- args.n = select("#", unpack(args))
		end

		options.text = options.text or string.sub(
			reduce(args, function(text, arg, a)
				if type(a) == "number" then
					return text .. " " .. tostring(arg)
				end
				return text
			end, "")
		, 2)

		naughty.notify(options)
	end


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
