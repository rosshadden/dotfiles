local search = Module.new("search", "<space>/")

--
-- SETTINGS
--

-- add the g flag to all searches
vim.opt.gdefault = true

--
-- MAPPINGS
--

-- toggle highlighting
search:map("<space>", cmd "nohlsearch")
search:map("/", cmd "set hlsearch")

-- clear highlighting
map("<a-cr>", "<cr>:nohlsearch<cr>", "c")

-- search for selection
map("/", [["vy/<c-r>v]], "v")
map("?", [["vy?<c-r>v]], "v")
