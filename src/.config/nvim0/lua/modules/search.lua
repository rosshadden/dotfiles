--
-- SETTINGS
--

-- casing
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.infercase = true

-- add the g flag to search/replace by default
vim.opt.gdefault = true

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>/", "<plug><search>", { silent = true })

-- toggle highlighted search results
vim.keymap.set("n", "<plug><search><space>", ":nohlsearch<cr>", { noremap = true })
vim.keymap.set("n", "<plug><search>/", ":set hlsearch!<cr>", { noremap = true })

-- search for selection
vim.keymap.set("v", "/", [["vy/<c-r>v<cr>]], { noremap = true })
vim.keymap.set("v", "?", [["vy?<c-r>v<cr>]], { noremap = true })
vim.keymap.set("v", "<a-/>", [["vy/<c-r>v]], { noremap = true })
vim.keymap.set("v", "<a-?>", [["vy?<c-r>v]], { noremap = true })

-- search but clear highlight
vim.keymap.set("c", "<a-cr>", "<cr>:nohlsearch<cr>", { noremap = true })
