local naughty = require("naughty")


each = function(items, fn)
	for i, item in ipairs(items) do
		fn(item, i)
	end
end

map = function(items, fn)
	local new = {}
	each(items, function(item)
		new[i] = fn(item, i)
	end)
	return new
end

filter = function(items, fn)
	local new = {}
	each(items, function(item)
		if fn(item, i) then
			new[i] = item
		end
	end)
	return new
end

reduce = function(items, fn, value)
	each(items, function(item)
		value = fn(value, item, i)
	end)
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
			return text .. " " .. tostring(arg)
		end, "")
	, 2)

	naughty.notify(options)
end
