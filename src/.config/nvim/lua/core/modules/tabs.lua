--
-- settings
--

-- tabs! (not to be confused with tabs)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

--
-- mappings
--

-- prefix
vim.keymap.set("n", "<space>t", "<plug><tabs>", { silent = true })

-- navigation
vim.keymap.set("n", "<m-n>", ":tabnext<cr>", { silent = true })
vim.keymap.set("n", "<m-p>", ":tabprevious<cr>", { silent = true })

-- new
vim.keymap.set("n", "<plug><tabs>n", ":tabnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>N", ":$tabnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>p", ":-tabnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>P", ":0tabnew<cr>", { silent = true })
