" prefix
call MakePrefix('clipboard', '<c-c>')
call MakePrefix('put', '<:prefix>p')

" easy ref to system clipboard (CLIPBOARD)
nnoremap <:clipboard> "+
vnoremap <:clipboard> "+

" easy ref to selection clipboard (PRIMARY)
nnoremap <:clipboard><c-s> "*
vnoremap <:clipboard><c-s> "*

" easy ref to (non-volatile) yank register
nnoremap <:clipboard><c-y> "0
vnoremap <:clipboard><c-y> "0

" easy ref to blackhole register
nnoremap <:clipboard><c-b> "_
vnoremap <:clipboard><c-b> "_

" paste without comments mucking everything up
nnoremap cop :set invpaste<cr>

" put in <motion>
map <:clipboard><c-p> <plug>(operator-replace)
" TODO: consider deprecating?
map <:put> <plug>(operator-replace)
