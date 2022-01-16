-- command
vim.keymap.set("", ";", ":", { noremap = true })
vim.keymap.set("", "<leader>;", ";", { noremap = true })

-- redo
vim.keymap.set("n", "U", "<c-r>", { noremap = true, silent = true })
