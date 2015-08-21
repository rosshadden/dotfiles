""""""""""""""""
" SETTINGS
""""""""""""""""

" use same column for j/k motions
let g:EasyMotion_startofline = 0
" use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" use smart case
let g:EasyMotion_smartcase = 1
" prefer the home row
let g:EasyMotion_keys = 'AOEUIDHTN-,.PYFGCRL;QJKXBMWVZS'
" jump to first search result with `<enter>`
let g:EasyMotion_enter_jump_first = 1


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('easymotion', '<:prefix>e')
map <:prefix>e <plug>(easymotion-prefix)
call MakePrefix('camel', '<:prefix>C')

" vim-sneak
nmap S <plug>(easymotion-s2)

" Replace default search
" TODO: doesn't work?
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" better long-distance travel
map <:prefix>ej <plug>(easymotion-j)
map <:prefix>ek <plug>(easymotion-k)
map <:prefix>eh <plug>(easymotion-linebackward)
map <:prefix>el <plug>(easymotion-lineforward)
map <:prefix>eJ <plug>(easymotion-sol-j)
map <:prefix>eK <plug>(easymotion-sol-k)
map <:prefix>eH <plug>(easymotion-linebackward)
map <:prefix>eL <plug>(easymotion-lineforward)

map <silent> <:camel>w <plug>CamelCaseMotion_w
map <silent> <:camel>b <plug>CamelCaseMotion_b
map <silent> <:camel>e <plug>CamelCaseMotion_e

omap <silent> <:camel>iw <plug>CamelCaseMotion_iw
xmap <silent> <:camel>iw <plug>CamelCaseMotion_iw
omap <silent> <:camel>ib <plug>CamelCaseMotion_ib
xmap <silent> <:camel>ib <plug>CamelCaseMotion_ib
omap <silent> <:camel>ie <plug>CamelCaseMotion_ie
xmap <silent> <:camel>ie <plug>CamelCaseMotion_ie
