""""""""""""""""
" SETTINGS
""""""""""""""""

let g:zv_disable_mapping = 1


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('docs', '<:prefix>D')

nmap <:docs><space> <plug>Zeavim
vmap <:docs><space> <plug>ZVVisSelection
nmap <:docs>f <plug>ZVKeyword
nmap <:docs>F <plug>ZVKeyDocset
