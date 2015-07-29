if has('autocmd')
	filetype plugin indent on

	augroup rcMain
		autocmd!

		" Reload vimrc when edited (using :Reload, defined elsewhere)
		" autocmd! BufWritePost *.vim Reload

		" Preserve cursor position
		autocmd BufRead * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

		" turn on spell check in git commits, and move cursor to beginning of gitcommits
		autocmd FileType gitcommit setlocal spell | setlocal complete+=kspell | call cursor(1, 1)

		" read things as shell scripts
		autocmd BufNewFile,BufReadPost *.conf set filetype=sh
	augroup END
endif
