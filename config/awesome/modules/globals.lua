--
local awful = require("awful")
local naughty = require("naughty")
--
local _ = require("modules/_")
--


SUPER = "Mod4"
META = "Mod1"
modkey = SUPER

-- Cache to store temporary things.
CACHE = {}

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}

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
		_.reduce(args, function(text, arg)
			if arg ~= args.n then
				text = text .. " " .. tostring(arg)
			end
			return text
		end, "")
	, 2)

	options.screen = options.screen or mouse.screen

	naughty.notify(options)
end
