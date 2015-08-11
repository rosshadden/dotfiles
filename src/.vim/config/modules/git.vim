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
