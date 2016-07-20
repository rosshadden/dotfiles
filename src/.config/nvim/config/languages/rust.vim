""""""""""""""""
" SETTINGS
""""""""""""""""

let g:rust_recommended_style = 0

""""""""""""""""
" MISC
""""""""""""""""

augroup rust
	autocmd!

	autocmd FileType rust
		\ let &l:makeprg = 'rustc ' . expand('%p') |
		\ noremap <localleader>c :RustRun |
		\ noremap <localleader>C :exec '!rustc ' . expand('%p')<cr>
augroup END
