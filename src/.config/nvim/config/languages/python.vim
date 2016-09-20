""""""""""""""""
" MISC
""""""""""""""""

let ts = &tabstop
augroup python
	autocmd!

	autocmd FileType python exec 'setlocal tabstop=' . ts
augroup END
