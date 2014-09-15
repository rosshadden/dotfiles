--
local awful = require("awful")
--
local util = require("modules/util")
--


-- Define a tag table which hold all screen tags.
local tags = {}


tags.entries = {
	{ name = "explore", icon = "" },
	{ name = "dev", icon = "" },
	{ name = "sync", icon = "" },
	{ name = "hack", icon = "" },
	{ name = "find", icon = "" },
	{ name = "watch", icon = "" },
	{ name = "play", icon = "" },
	{ name = "chat", icon = "" },
	{ name = "run", icon = "" }
}
tags.icons = _.map(tags.entries, function(tag)
	return tag.icon
end)

tags.getName = function(icon)
	local tag = _.find(tags.entries, function(tag)
		return tag.icon == icon
	end)

	if tag then return tag.name end
	return ""
end

tags.list = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags.list[s] = awful.tag(tags.icons, s, layouts[2])
end


return tags

