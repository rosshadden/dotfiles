if has("autocmd")
	filetype plugin on

	augroup rcMain
		au!

		" Reload vimrc when edited (using :reload, defined above)
		autocmd! BufWritePost vimrc source ~/.vim/vimrc

		" Preserve cursor position
		autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

		" Remove trailing whitespaces and \^M chars
		" NOTE: removing in favor of vim-better-whitespace, for more control/knowledge
		" autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1, map(getline(1, '$'), 'substitute(v:val, "\\s\\+$", "", "")'))

		" turn on spell check in certain files, and move cursor to beginning of gitcommits
		autocmd BufRead,BufNewFile *.md setlocal spell | set complete+=kspell
		autocmd FileType gitcommit setlocal spell | set complete+=kspell | call cursor(1, 1)

		" syntax highlighting
		autocmd BufNewFile,BufReadPost *.md set filetype=markdown

		" default to shell script syntax
		autocmd BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif
		autocmd BufNewFile,BufRead * if &filetype == '' | set filetype=sh | endif
	augroup END
endif
