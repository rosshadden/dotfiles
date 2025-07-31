--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>l", "<plug><lines>", { silent = true })

vim.keymap.set("n", "<plug><lines>j", ":m +1<cr>==", { silent = true, noremap = true })
vim.keymap.set("n", "<plug><lines>k", ":m -2<cr>==", { silent = true, noremap = true })
