""""""""""""""""
" SETTINGS
""""""""""""""""

" highlight cursor line
set cursorline

let g:multi_cursor_select_all_word_key = '<m-N>'
let g:multi_cursor_select_all_key = 'g<m-N>'

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
