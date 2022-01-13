--
-- SETTINGS
--

-- tabs! (not to be confused with tabs)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>t", "<plug><tabs>", { silent = true })

-- navigate [±n:1] tabs
local nextTabWithCount = [[:<c-u>execute (v:count == 0) ? "tabnext" : "tabnext " . (v:count1 + 2)<cr>]]
local prevTabWithCount = [[:<c-u>execute (v:count == 0) ? "tabprevious" : "tabprevious " . v:count1<cr>]]
vim.keymap.set("n", "<a-n>", nextTabWithCount, { silent = true })
vim.keymap.set("n", "<a-p>", prevTabWithCount, { silent = true })
vim.keymap.set("n", "<plug><tabs>h", prevTabWithCount, { silent = true })
vim.keymap.set("n", "<plug><tabs>l", nextTabWithCount, { silent = true })

-- move [±n:1] tabs
vim.keymap.set("n", "<plug><tabs>H", [[:<c-u>execute "tabmove -" . v:count1<cr>]], { silent = true })
vim.keymap.set("n", "<plug><tabs>L", [[:<c-u>execute "tabmove +" . v:count1<cr>]], { silent = true })

-- absolute navigation
vim.keymap.set("n", "<a-`>", ":tabfirst<cr>", { silent = true })
vim.keymap.set("n", "<a-0>", ":tablast<cr>", { silent = true })

-- direct navigation
for i = 1, 9, 1 do
	vim.keymap.set("n", [[<a-]] .. i .. [[>]], i .. [[gt]], { silent = true })
end

-- alt-tab (pun)
vim.keymap.set("n", "<a-tab>", "g<tab>", { silent = true })

-- split ("zoom" current buffer)
vim.keymap.set("n", "<plug><tabs>s", ":tab split<cr>", { silent = true })

-- new
vim.keymap.set("n", "<plug><tabs>n", ":tabnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>N", ":$tabnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>p", ":-tabnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>P", ":0tabnew<cr>", { silent = true })

-- close
vim.keymap.set("n", "<plug><tabs>c", ":tabclose<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>C", ":tabclose!<cr>", { silent = true })

-- close others
vim.keymap.set("n", "<plug><tabs>o", ":tabonly<cr>", { silent = true })
vim.keymap.set("n", "<plug><tabs>O", ":tabonly!<cr>", { silent = true })
