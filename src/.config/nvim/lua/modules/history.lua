-- maintain undo history across sessions
if vim.fn.has("persistent_undo") == 1 then
	vim.opt.undofile = true
end
