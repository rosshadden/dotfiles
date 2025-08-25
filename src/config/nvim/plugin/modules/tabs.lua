local tabs = Module.new("tabs", "<space>t")

--
-- MAPPINGS
--

-- relatave navigation
local next_tab = cmd [[<c-u>execute (v:count == 0) ? "tabnext" : "tabnext " . (v:count1 + 2)]]
local prev_tab = cmd [[<c-u>execute (v:count == 0) ? "tabprevious" : "tabprevious " . v:count1]]
map("<a-n>", next_tab)
map("<a-p>", prev_tab)
tabs:map("h", prev_tab)
tabs:map("l", next_tab)

-- absolute navigation
map("<a-`>", cmd "tabfirst")
map("<a-0>", cmd "tablast")

-- direct navigation
for i = 1, 9, 1 do
	map("<a-" .. i .. ">", i .. "gt")
end

-- alt-tab (pun)
map("<a-tab>", "g<tab>")

-- move [±n:1] tabs
tabs:map("H", cmd [[<c-u>execute "tabmove -" . v:count1]])
tabs:map("L", cmd [[<c-u>execute "tabmove +" . v:count1]])

-- split ("zoom" current buffer)
tabs:map("s", cmd "tab split")

-- new
tabs:map("n", cmd "tabedit")
tabs:map("N", cmd "tabedit %")
tabs:map("p", cmd "-tabedit")
tabs:map("P", cmd "tabedit %")

-- close
tabs:map("c", cmd "tabclose")
tabs:map("C", cmd "tabclose!")

-- close others
tabs:map("o", cmd "tabonly")
tabs:map("O", cmd "tabonly!")
