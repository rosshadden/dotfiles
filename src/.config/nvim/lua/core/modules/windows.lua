--
-- SETTINGS
--

-- window title
vim.opt.title = true

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>w", "<plug><windows>", { silent = true })

-- navigation
vim.keymap.set("n", "<plug><windows>n", ":wnext<cr>", { silent = true })
vim.keymap.set("n", "<plug><windows>p", ":wprevious<cr>", { silent = true })

-- split [j, k, h, l]
vim.keymap.set("n", "<plug><windows>j", ":botright new<cr>", { silent = true })
vim.keymap.set("n", "<plug><windows>k", ":topleft new<cr>", { silent = true })
vim.keymap.set("n", "<plug><windows>h", ":topleft vnew<cr>", { silent = true })
vim.keymap.set("n", "<plug><windows>l", ":botright vnew<cr>", { silent = true })

-- move window [H, J, K, L]
-- NOTE: this is not expected, but all vim can natively do
vim.keymap.set("n", "<plug><windows>J", "<c-w>J", { silent = true })
vim.keymap.set("n", "<plug><windows>K", "<c-w>K", { silent = true })
vim.keymap.set("n", "<plug><windows>H", "<c-w>H", { silent = true })
vim.keymap.set("n", "<plug><windows>L", "<c-w>L", { silent = true })

-- close
vim.keymap.set("n", "<plug><windows>c", ":close<cr>", { silent = true })
vim.keymap.set("n", "<plug><windows>C", ":close!<cr>", { silent = true })

-- move window to a new tab
vim.keymap.set("n", "<plug><windows>t", "<c-w>T", { silent = true })

-- close all other windows
vim.keymap.set("n", "<plug><windows>o", "<c-w>O", { silent = true })
