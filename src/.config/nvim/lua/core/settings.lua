-- line numbers
vim.opt.number = true

-- 🐀 ratJAM 🐀
vim.opt.mouse = "a"

-- maintain undo history across sessions
if vim.fn.has("persistent_undo") == 1 then
	vim.opt.undofile = true
	vim.opt.undodir = "~/.local/share/nvim/history"
end
