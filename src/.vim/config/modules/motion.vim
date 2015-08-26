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
map - <plug>(easymotion-prefix)
call MakePrefix('camel', '<:prefix>C')

" sneaking
nmap -- <plug>(easymotion-s)
nmap -_ <plug>(easymotion-s2)

" searching
map  -/ <plug>(easymotion-sn)
omap -/ <plug>(easymotion-tn)

" repeating motions
map  -. <plug>(easymotion-repeat)

" better long-distance travel
map -j <plug>(easymotion-j)
map -k <plug>(easymotion-k)
map -h <plug>(easymotion-linebackward)
map -l <plug>(easymotion-lineforward)
map -J <plug>(easymotion-sol-j)
map -K <plug>(easymotion-sol-k)
map -H <plug>(easymotion-linebackward)
map -L <plug>(easymotion-lineforward)

map <silent> <:camel>w <plug>CamelCaseMotion_w
map <silent> <:camel>b <plug>CamelCaseMotion_b
map <silent> <:camel>e <plug>CamelCaseMotion_e

omap <silent> <:camel>iw <plug>CamelCaseMotion_iw
xmap <silent> <:camel>iw <plug>CamelCaseMotion_iw
omap <silent> <:camel>ib <plug>CamelCaseMotion_ib
xmap <silent> <:camel>ib <plug>CamelCaseMotion_ib
omap <silent> <:camel>ie <plug>CamelCaseMotion_ie
xmap <silent> <:camel>ie <plug>CamelCaseMotion_ie
