" easier system clipboard
map <leader>y "+y
map <leader>Y "+Y
map <leader>p "+p
map <leader>P "+P
map <leader>d "+d
map <leader>D "+D
map <leader>c "+c
map <leader>C "+C

" paste without comments mucking everything up
nnoremap cop :set invpaste<CR>

" paste motion
" TODO: make a plugin or function that accepts any arbitrary motion
map [prefix]piw "_ciw<c-r>0<esc>
