" prefix
call MakePrefix('clipboard', '<:prefix>c')
call MakePrefix('put', '<:prefix>p')

" easy ref to system clipboard
nnoremap <c-c> "+
vnoremap <c-c> "+

" easy system clipboard
noremap <:clipboard>y "+y
noremap <:clipboard>Y "+Y
noremap <:clipboard>p "+p
noremap <:clipboard>P "+P
noremap <:clipboard>d "+d
noremap <:clipboard>D "+D
noremap <:clipboard>c "+c
noremap <:clipboard>C "+C

" paste without comments mucking everything up
nnoremap cop :set invpaste<cr>

" put in <motion>
map <:put> <plug>(operator-replace)
