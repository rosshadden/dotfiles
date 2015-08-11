""""""""""""""""
" SETTINGS
""""""""""""""""

" enable
let g:vimfiler_as_default_explorer = 1

" datetime format
let g:vimfiler_time_format = '%Y-%m-%d %H:%M'

" let `vim-airline` handle the statusbar
let g:vimfiler_force_overwrite_statusline = 0

" moar indentation
let g:vimfiler_tree_indentation = 2

" don't jump to first child
let g:vimfiler_expand_jump_to_first_child = 0

" YOLO
" let g:vimfiler_safe_mode_by_default = 0

" ignore
" TODO: see if this can be dynamic, based on .gitignore or wildignore
let g:vimfiler_ignore_pattern = '^\%(\.git\|node_modules\)$'

" preview command
let g:vimfiler_quick_look_command = 'gloobus-preview'


" ICONS

if has("gui_running")
	let g:vimfiler_tree_leaf_icon = ' '  " '|'
	let g:vimfiler_tree_opened_icon = ''  " '-'
	let g:vimfiler_tree_closed_icon = ''  " '+'
	let g:vimfiler_readonly_file_icon = ''  " 'X'
	let g:vimfiler_file_icon = '•'  " ' '
	let g:vimfiler_marked_file_icon = ''  " '*'
else
	let g:vimfiler_tree_leaf_icon = ' '  " '|'
	let g:vimfiler_tree_opened_icon = '▾'  " '-'
	let g:vimfiler_tree_closed_icon = '▷'  " '+'
	let g:vimfiler_readonly_file_icon = ''  " 'X'
	let g:vimfiler_file_icon = '•'  " ' '
	let g:vimfiler_marked_file_icon = '✓'  " '*'
endif


""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('explorer', '<:prefix>e')
call MakePrefix('files', '<:prefix>f')

map <leader>f :VimFilerExplorer<cr>
map <leader>F :VimFilerExplorer -toggle -find<cr>

map <:files>f :VimFiler<cr>
map <:files>F :VimFilerBufferDir<cr>

map <:files>t :VimFilerTab<cr>

map <:files>j :VimFilerSplit -create -horizontal -direction=rightbelow<cr>
map <:files>k :VimFilerSplit -create -horizontal -direction=leftabove<cr>
map <:files>h :VimFilerSplit -create -direction=leftabove<cr>
map <:files>l :VimFilerSplit -create -direction=rightbelow<cr>

map <:files>J :VimFilerBufferDir -create -split -horizontal -direction=rightbelow<cr>
map <:files>K :VimFilerBufferDir -create -split -horizontal -direction=leftabove<cr>
map <:files>H :VimFilerBufferDir -create -split -direction=leftabove<cr>
map <:files>L :VimFilerBufferDir -create -split -direction=rightbelow<cr>

map <:explorer><space> :EditVifm<cr>

map <:explorer>t :TabVifm<cr>

map <:explorer>s :VsplitVifm<cr>
map <:explorer>h :VsplitVifm<cr>
map <:explorer>l :VsplitVifm<cr>

map <:explorer>- :SplitVifm<cr>
map <:explorer>j :SplitVifm<cr>
map <:explorer>k :SplitVifm<cr>

map <:explorer>d :DiffVifm<cr>


""""""""""""""""
" ACTIONS
""""""""""""""""

function! s:settings()
	" RESET

	unmap <buffer> <c-l>
	unmap <buffer> <c-j>
	unmap <buffer> <space>


	" TREE

	" select
	map <buffer> t <plug>(vimfiler_toggle_mark_current_line)
	map <buffer> T <plug>(vimfiler_toggle_mark_current_line_up)
	vmap <buffer> t <plug>(vimfiler_toggle_mark_selected_lines)

	" expand/collapse
	map <buffer> o <plug>(vimfiler_expand_tree)
	map <buffer> O <plug>(vimfiler_expand_tree_recursive)

	" refresh
	map <buffer> <leader>r <plug>(vimfiler_redraw_screen)
	map <buffer> <leader>R <plug>(vimfiler_sync_with_current_vimfiler)

	" preview
	map <buffer> <leader>p <plug>(vimfiler_quick_look)

	" directory history
	map <buffer> <c-r> <plug>(vimfiler_switch_to_history_directory)


	" toggle hidden
	map <buffer> za <plug>(vimfiler_toggle_visible_dot_files)
	map <buffer> zf <plug>(vimfiler_toggle_visible_ignore_files)
endfunction

autocmd FileType vimfiler call s:settings()
