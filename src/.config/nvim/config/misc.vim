augroup misc
	autocmd!

	" Reload vimrc when edited (using :Reload, defined elsewhere)
	" autocmd BufWritePost *.vim Reload

	" Preserve cursor position
	autocmd BufRead * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

	" turn on spell check in git commits, and move cursor to beginning of gitcommits
	autocmd FileType gitcommit setlocal spell | setlocal complete+=kspell | call cursor(1, 1)

	" read things as shell scripts
	autocmd BufNewFile,BufReadPost,BufEnter * if &filetype == '' | setlocal filetype=config | endif

	autocmd FileType conf call css_color#init('hex', 'extended', 'confString')

	" automatically resize windows
	autocmd VimResized * wincmd =

	" sync stuff between instances
	" https://github.com/neovim/neovim/issues/3463#issuecomment-148757691
	if has('nvim')
		autocmd CursorHold,FocusGained,FocusLost * rshada|wshada
	endif
augroup END
