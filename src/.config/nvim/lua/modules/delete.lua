--
-- MAPPINGS
--

-- delete word
vim.keymap.set("i", "<c-backspace>", "<c-w>", { silent = true, noremap = true })

-- prefix
vim.keymap.set("n", "<space>d", "<plug><delete>", { silent = true })

-- cardinal
vim.keymap.set("n", "<plug><delete>j", "mDjdd`D", { silent = true, noremap = true })
vim.keymap.set("n", "<plug><delete>k", "kdd", { silent = true, noremap = true })
vim.keymap.set("n", "<plug><delete>h", "dh", { silent = true, noremap = true })
vim.keymap.set("n", "<plug><delete>l", "ldlh", { silent = true, noremap = true })

-- vertical
vim.keymap.set("n", "<plug><delete>v", "<plug><delete>j<plug><delete>k", { silent = true, noremap = false })
-- horizontal
vim.keymap.set("n", "<plug><delete>s", "<plug><delete>h<plug><delete>l", { silent = true, noremap = false })
