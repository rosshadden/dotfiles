""""""""""""""""
" SETTINGS
""""""""""""""""

" highlight cursor line
set cursorline

if has('nvim')
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

""""""""""""""""
" PLUGINS
""""""""""""""""

" vim-multiple-cursors

" Make multiple cursors fast with neocomplete

if !has('nvim')
	function! Multiple_cursors_before()
		exec 'NeoCompleteLock'
	endfunction

	function! Multiple_cursors_after()
		exec 'NeoCompleteUnlock'
	endfunction
endif
