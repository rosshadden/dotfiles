--
-- SETTINGS
--

-- show invisibles
vim.opt.list = true
vim.opt.listchars = [[tab:» ,trail:·,nbsp:_,extends:>,precedes:<]]

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>s", "<plug><spacing>", { silent = true })

-- visual shifting (does not exit Visual mode)
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })

-- cardinal
vim.keymap.set("n", "<plug><spacing>j", [[:set paste<cr>m`o<esc>``:set nopaste<cr>]], { silent = true, noremap = true })
vim.keymap.set("n", "<plug><spacing>k", [[:set paste<cr>m`O<esc>``:set nopaste<cr>]], { silent = true, noremap = true })
vim.keymap.set("n", "<plug><spacing>h", "i<space><esc>l", { silent = true, noremap = true })
vim.keymap.set("n", "<plug><spacing>l", "a<space><esc>h", { silent = true, noremap = true })

-- vertical
vim.keymap.set("n", "<plug><spacing>v", "<plug><spacing>j<plug><spacing>k", { silent = true, noremap = false })
-- horizontal
vim.keymap.set("n", "<plug><spacing>s", "<plug><spacing>h<plug><spacing>l", { silent = true, noremap = false })
