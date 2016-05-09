" TODO: rename module

""""""""""""""""
" MAPPINGS
""""""""""""""""
" prefix
call MakePrefix('aoeu', '<:prefix>u')
call MakePrefix('aoeu', '<:aoeu>u', 1)

" line
nnoremap <:aoeu>l :Lines<cr>
nnoremap <:aoeu>L :BLines<cr>

" TODO: spelling

" search files
nnoremap <:aoeu>g :Ag<cr>
nnoremap <:aoeu>G :Ag<space>

" metavim
" mappings
nnoremap <:aoeu>m :Maps<cr>
