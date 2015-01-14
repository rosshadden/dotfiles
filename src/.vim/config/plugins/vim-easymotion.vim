" use same column for j/k motions
let g:EasyMotion_startofline = 0

" use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1

" prefer the home row
let g:EasyMotion_keys = 'ASONETUHIDPGCRYFLJBWMK;XVZQ'

" jump to first search result with `<enter>`
let g:EasyMotion_enter_jump_first = 1


" prefix
map <leader>f <plug>(easymotion-prefix)

" vim-sneak
nmap s <plug>(easymotion-s2)
nmap S <plug>(easymotion-t2)

" Replace Vim default search
" TODO: doesn't work?
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" better long-distance travel
map <leader>l <plug>(easymotion-lineforward)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
map <leader>h <plug>(easymotion-linebackward)
