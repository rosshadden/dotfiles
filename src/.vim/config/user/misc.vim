if has('autocmd')
	filetype plugin indent on

	augroup rcMain
		autocmd!

		" Reload vimrc when edited (using :Reload, defined elsewhere)
		autocmd! BufWritePost *.vim Reload

		" Preserve cursor position
		autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

		" turn on spell check in certain files, and move cursor to beginning of gitcommits
		autocmd BufRead,BufNewFile *.md setlocal spell | setlocal complete+=kspell
		autocmd FileType gitcommit setlocal spell | setlocal complete+=kspell | call cursor(1, 1)

		" syntax highlighting
		autocmd BufNewFile,BufReadPost *.md set filetype=markdown

		" default to shell script syntax
		autocmd BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif
		autocmd BufNewFile,BufRead * if &filetype == '' | set filetype=sh | endif
	augroup END
endif
