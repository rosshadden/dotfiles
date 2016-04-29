""""""""""""""""
" SETTINGS
""""""""""""""""

" highlight cursor line
set cursorline

if has('nvim')
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

""""""""""""""""
" PLUGINS
""""""""""""""""

" vim-multiple-cursors

" Make multiple cursors fast with neocomplete

if has('nvim')
	function! Multiple_cursors_before()
		let g:deoplete#disable_auto_complete = 1
	endfunction

	function! Multiple_cursors_after()
		let g:deoplete#disable_auto_complete = 0
	endfunction
else
	function! Multiple_cursors_before()
		exec 'NeoCompleteLock'
	endfunction

	function! Multiple_cursors_after()
		exec 'NeoCompleteUnlock'
	endfunction
endif
