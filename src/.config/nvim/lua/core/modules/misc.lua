local group = vim.api.nvim_create_augroup("misc", {})

-- preserve cursor position [:h restore-cursor]
vim.api.nvim_create_autocmd("BufRead", {
	group = group,
	command = [[
		if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
	]],
})

-- automatically resize windows
vim.api.nvim_create_autocmd("VimResized", {
	group = group,
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- autocmd BufRead * autocmd FileType <buffer> ++once
-- 	\if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exec 'normal! g`"' | endif
