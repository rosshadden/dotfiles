""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('git', '<:prefix>g')
call MakePrefix('git', '<:git>g', 1)

nnoremap <:git><space> :Tig<cr>
nnoremap <:git:1><space> :Tig!<cr>

nnoremap <:git>b :Tig blame<cr>
nnoremap <:git>B :Tig refs<cr>
nnoremap <:git>l :Tig log<cr>
nnoremap <:git>s :Tig status<cr>
nnoremap <:git>S :Tig show<cr>
nnoremap <:git>y :Tig stash<cr>

nnoremap <:git>r :GitFiles<cr>
nnoremap <:git>R :GitFiles?<cr>

""""""""""""""""
" PLUGINS
""""""""""""""""

" vim-gitgutter

" don't map keys
let g:gitgutter_map_keys = 0

" go to next/prev changed hunk
nmap ]H <plug>GitGutterNextHunk
nmap [H <plug>GitGutterPrevHunk

" preview changed hunk
nmap <:prefix>Hp <plug>GitGutterPreviewHunk

" stage changed hunk
nmap <:prefix>Hs <plug>GitGutterStageHunk

" revert changed hunk
nmap <:prefix>Hr <plug>GitGutterRevertHunk
