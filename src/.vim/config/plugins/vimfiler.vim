" enable
let g:vimfiler_as_default_explorer = 1

" datetime format
let g:vimfiler_time_format = '%Y-%m-%d %H:%M'

" let `vim-airline` handle the statusbar
let g:vimfiler_force_overwrite_statusline = 0

" moar indentation
let g:vimfiler_tree_indentation = 2


" ICONS

" TODO: I need to get unicode fonts working in `urxvt`
if has("gui_running")
	let g:vimfiler_tree_leaf_icon = '|'  " '|'
	let g:vimfiler_tree_opened_icon = ''  " '-'
	let g:vimfiler_tree_closed_icon = ''  " '+'
	let g:vimfiler_readonly_file_icon = ''  " 'X'
	let g:vimfiler_file_icon = ' '  " ' '
	let g:vimfiler_marked_file_icon = ''  " '*'
endif


" MAPPINGS

map <leader>f :VimFilerExplorer<cr>

function! s:settings()
	" RESET

	unmap <buffer> <c-l>
	unmap <buffer> <c-j>


	" EXPLORER

	" refresh
	map <buffer> <leader>r <plug>(vimfiler_redraw_screen)

	" directory history
	map <buffer> <c-r> <plug>(vimfiler_switch_to_history_directory)
endfunction

autocmd FileType vimfiler call s:settings()
