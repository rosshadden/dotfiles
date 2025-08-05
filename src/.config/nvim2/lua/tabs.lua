local tabs = Mode.new("tabs", "<space>t")

-- relatave navigation
local next_tab = [[:<c-u>execute (v:count == 0) ? "tabnext" : "tabnext " . (v:count1 + 2)<cr>]]
local prev_tab = [[:<c-u>execute (v:count == 0) ? "tabprevious" : "tabprevious " . v:count1<cr>]]
map("<a-n>", next_tab)
map("<a-p>", prev_tab)

-- absolute navigation
map("<a-`>", cmd "tabfirst")
map("<a-0>", cmd "tablast")

-- direct navigation
for i = 1, 9, 1 do
	map("<a-" .. i .. ">", i .. "gt")
end

-- alt-tab (pun)
map("<a-tab>", "g<tab>")
