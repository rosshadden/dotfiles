vim.keymap.set("n", ";", ":", { noremap = true })

-- redo
vim.keymap.set("n", "U", "<c-r>", { noremap = true, silent = true })

vim.keymap.set("n", "<space>T", ":Telescope<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "<space>r", reload, { silent = true })

vim.keymap.set("n", "<bs>", function() print("debug") end)
