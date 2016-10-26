""""""""""""""""
" MISC
""""""""""""""""

augroup json
	autocmd!

	" treat other files as json
	autocmd BufEnter,BufNew *.eslintrc set ft=json
	autocmd BufEnter,BufNew *.jl set ft=json
augroup END
