" vim-windowswap
" prevent default bindings
let g:windowswap_map_keys = 0


" prefix
call MakePrefix('windows', '[prefix]w')
call MakePrefix('windows', '[windows]w', 1)

" navigation
nmap [windows]n :wnext<cr>
nmap [windows]p :wprevious<cr>

" split window [h, j, k, l]
map [windows]h :topleft vnew<cr>
map [windows]l :botright vnew<cr>
map [windows]j :botright new<cr>
map [windows]k :topleft new<cr>

" clone window [h, j, k, l]
map [windows:1]h :topleft vsplit<cr>
map [windows:1]l :botright vsplit<cr>
map [windows:1]j :botright split<cr>
map [windows:1]k :topleft split<cr>

" move window [H, J, K, L]
" NOTE: this is not expected, but all vim can natively do
map [windows]H <c-w>H
map [windows]L <c-w>L
map [windows]J <c-w>J
map [windows]K <c-w>K

" close window
map [windows]c :close<cr>
map [windows]C :close!<cr>

" move window to a new tab
map [windows]t <c-w>T

" close all other windows
map [windows]o <c-w>O


" vim-windowswap
nnoremap <silent> [windows]Y :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> [windows]P :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> [windows]S :call WindowSwap#EasyWindowSwap()<CR>
