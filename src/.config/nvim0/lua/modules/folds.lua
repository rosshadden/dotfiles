--
-- SETTINGS
--

vim.opt.foldenable = false

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>z", "<plug><folds>", { silent = true })

-- fold levels
vim.keymap.set("n", "<plug><folds>`", ":set foldlevel=0<cr>", { silent = true })
vim.keymap.set("n", "<plug><folds>0", ":set foldlevel=128<cr>", { silent = true })
for i = 1, 9, 1 do
	vim.keymap.set("n", "<plug><folds>" .. i, ":set foldlevel=" .. i .. "<cr>", { silent = true })
end

-- toggle folds
-- vim.keymap.set("n", "<plug><folds><space>", "zf", { silent = true })
