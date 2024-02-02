--
-- SETTINGS
--

-- disable splash screen and "press ENTER" prompt
vim.opt.shortmess = "actIO"

-- 🐀 ratJAM 🐀
vim.opt.mouse = "ar"

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>a", "<plug><app>", { silent = true })

-- quit
vim.keymap.set("n", "<plug><app>q", ":quitall<cr>", { silent = true })
vim.keymap.set("n", "<plug><app>Q", ":quitall!<cr>", { silent = true })

-- error
vim.keymap.set("n", "<plug><app>e", ":cquit<cr>", { silent = true })
vim.keymap.set("n", "<plug><app>E", ":cquit!<cr>", { silent = true })

-- write
vim.keymap.set("n", "<plug><app>w", ":wall<cr>", { silent = true })
vim.keymap.set("n", "<plug><app>W", ":wall!<cr>", { silent = true })

-- exit
vim.keymap.set("n", "<plug><app>x", ":xall<cr>", { silent = true })
vim.keymap.set("n", "<plug><app>X", ":xall!<cr>", { silent = true })

-- close
vim.keymap.set("n", "<plug><app>c", ":bufdo bdelete<cr>", { silent = true })
vim.keymap.set("n", "<plug><app>C", ":bufdo bdelete!<cr>", { silent = true })

-- reload config
vim.keymap.set("n", "<plug><app>r", reload, { silent = true })

-- messages
vim.keymap.set("n", "<plug><app>m", ":messages<cr>", { silent = true })
vim.keymap.set("n", "<plug><app>M", ":messages clear<cr>", { silent = true })
