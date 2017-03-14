""""""""""""""""
" SETTINGS
""""""""""""""""

call tcomment#DefineType('nim', '# %s')

""""""""""""""""
" MISC
""""""""""""""""

augroup nim
	autocmd!
	autocmd BufEnter,BufNew *.nimble setlocal ft=nims | setlocal expandtab
augroup END
