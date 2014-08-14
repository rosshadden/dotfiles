--
local awful = require("awful")
--


-- Define a tag table which hold all screen tags.
local tags = {}
local tagNames = { "", "{}", "", "", "", "", "", "", "" }

for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag(tagNames, s, layouts[2])
end


return tags
