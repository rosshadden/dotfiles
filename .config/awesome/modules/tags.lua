--
local awful = require("awful")
local _ = require("moses/moses_min")
--


-- Define a tag table which hold all screen tags.
local tags = {}


tags.entries = {
	{ name = "explore", icon = "" },
	{ name = "dev", icon = "{}" },
	{ name = "sync", icon = "" },
	{ name = "hack", icon = "" },
	{ name = "find", icon = "" },
	{ name = "look", icon = "" },
	{ name = "comm", icon = "" },
	{ name = "chat", icon = "" },
	{ name = "run", icon = "" }
}
tags.icons = {"", "{}", "", "", "", "", "", "", ""}

-- TODO: Does not work. I don't think moses supports arrays of objects.
tags.getName = function(icon)
	local tag = _.find(tags.entries, { icon = icon })
	if tag then
		return tag.name
	end
	return ""
end

tags.list = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags.list[s] = awful.tag(tags.icons, s, layouts[2])
end


return tags
