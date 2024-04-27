-- redo
vim.keymap.set("n", "U", "<c-r>", { silent = true, noremap = true })

-- find
vim.keymap.set("", "<a-/>", "/\\v", { noremap = true })

-- fixes c-i for some reason
vim.keymap.set("", "<c-i>", "<c-i>")
