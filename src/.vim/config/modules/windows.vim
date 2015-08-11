""""""""""""""""
" SETTINGS
""""""""""""""""

" vim-windowswap
" prevent default bindings
let g:windowswap_map_keys = 0


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('windows', '<:prefix>w')
call MakePrefix('windows', '<:windows>w', 1)
call MakePrefix('resize', '<:prefix>r')

" navigation
nnoremap <:windows>n :wnext<cr>
nnoremap <:windows>p :wprevious<cr>

" split window [h, j, k, l]
noremap <:windows>j :botright new<cr>
noremap <:windows>k :topleft new<cr>
noremap <:windows>h :topleft vnew<cr>
noremap <:windows>l :botright vnew<cr>

" clone window [h, j, k, l]
noremap <:windows:1>j :botright split<cr>
noremap <:windows:1>k :topleft split<cr>
noremap <:windows:1>h :topleft vsplit<cr>
noremap <:windows:1>l :botright vsplit<cr>

" move window [H, J, K, L]
" NOTE: this is not expected, but all vim can natively do
noremap <:windows>J <c-w>J
noremap <:windows>K <c-w>K
noremap <:windows>H <c-w>H
noremap <:windows>L <c-w>L

" close window
noremap <:windows>c :close<cr>
noremap <:windows>C :close!<cr>

" move window to a new tab
noremap <:windows>t <c-w>T

" close all other windows
noremap <:windows>o <c-w>O


""""""""""""""""
" PLUGINS
""""""""""""""""

" vim-windowswap
nnoremap <silent> <:windows>Y :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <:windows>P :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <:windows>S :call WindowSwap#EasyWindowSwap()<CR>

" obvious-resize
let g:obvious_resize_default = 10
noremap <silent> <:resize>j :<c-u>ObviousResizeDown<cr>
noremap <silent> <:resize>k :<c-u>ObviousResizeUp<cr>
noremap <silent> <:resize>h :<c-u>ObviousResizeLeft<cr>
noremap <silent> <:resize>l :<c-u>ObviousResizeRight<cr>
