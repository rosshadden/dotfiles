""""""""""""""""
" MISC
""""""""""""""""

augroup rust
	autocmd!

	autocmd FileType rust
		\ noremap <localleader>c :RustRun |
		\ noremap <localleader>C :exec '!rustc ' . expand('%p')<cr>
augroup END
