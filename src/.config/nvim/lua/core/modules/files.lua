-- prefix
vim.keymap.set("n", "<space>f", "<plug><files>", { silent = true })

-- list
vim.keymap.set("n", "<plug><files>l", ":Telescope find_files find_command=fd,--hidden<cr>", { silent = true })

-- git
vim.keymap.set("n", "<plug><files>g", ":Telescope git_files<cr>", { silent = true })
