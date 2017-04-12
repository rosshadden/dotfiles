""""""""""""""""
" SETTINGS
""""""""""""""""

" tabs! (not to be confused with tabs)
set tabstop=2 shiftwidth=2

let g:tagbar_map_closefold = 'zc'


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('tabs', '<:prefix>T')

" tagbar
noremap <:tabs><space> :TagbarToggle<cr>
