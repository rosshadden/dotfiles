" prefix
call MakePrefix('copypasta', '[prefix]c')

" easier system clipboard
map [copypasta]y "+y
map <c-c> "+y
map [copypasta]Y "+Y
map <c-s-c> "+Y
map [copypasta]p "+p
map [copypasta]P "+P
map [copypasta]d "+d
map [copypasta]D "+D
map [copypasta]c "+c
map [copypasta]C "+C

" paste without comments mucking everything up
nnoremap cop :set invpaste<CR>

" paste motion
" TODO: make a plugin or function that accepts any arbitrary motion
map [prefix]piw "_ciw<c-r>0<esc>
