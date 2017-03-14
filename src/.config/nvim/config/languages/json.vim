""""""""""""""""
" MISC
""""""""""""""""

augroup json
	autocmd!
	autocmd BufEnter,BufNew *.eslintrc set ft=json
	autocmd BufEnter,BufNew *.jl set ft=json
augroup END
