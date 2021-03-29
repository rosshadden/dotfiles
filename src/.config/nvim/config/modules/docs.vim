""""""""""""""""
" SETTINGS
""""""""""""""""

let g:zv_disable_mapping = 1

" vim-jsdoc

let g:jsdoc_allow_input_prompt      = 1 " 0
let g:jsdoc_input_description       = 1 " 1
let g:jsdoc_additional_descriptions = 0 " 0
let g:jsdoc_return                  = 1 " 1
let g:jsdoc_return_type             = 1 " 1
let g:jsdoc_return_description      = 1 " 1
let g:jsdoc_default_mapping         = 0 " 1

""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('docs', '<:prefix>D')

nmap <:docs><space> <plug>Zeavim
vmap <:docs><space> <plug>ZVVisSelection
nmap <:docs>f <plug>ZVKeyword
nmap <:docs>F <plug>ZVKeyDocset

" jsdoc
augroup docs
	autocmd!

	autocmd FileType javascript nmap <silent> <:docs>j <plug>(jsdoc)
augroup END
