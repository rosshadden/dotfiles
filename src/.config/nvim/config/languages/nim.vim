""""""""""""""""
" SETTINGS
""""""""""""""""

call tcomment#type#Define('nim', '# %s')

""""""""""""""""
" MISC
""""""""""""""""

augroup nim
	autocmd!
	autocmd BufEnter,BufNew *.nimble setlocal ft=nims | setlocal expandtab
augroup END
