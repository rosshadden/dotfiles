vim.cmd [[
	augroup misc
		" preserve cursor position [:h restore-cursor]
		autocmd BufRead * if line("'\"") > 1 && line("'\"") <= line("$") | exec "normal! g`\"" | endif
		" autocmd BufRead * autocmd FileType <buffer> ++once
		" 	\if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exec 'normal! g`"' | endif

		" automatically resize windows
		autocmd VimResized * wincmd =
	augroup END
]]
