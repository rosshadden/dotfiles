""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('git', '<:prefix>g')
call MakePrefix('git', '<:git>g', 1)
call MakePrefix('hunk', '<:prefix>h')

nnoremap <:git><space> :Tig<cr>
nnoremap <:git:1><space> :Tig!<cr>

nnoremap <:git>r :GitFiles<cr>
nnoremap <:git>R :GitFiles?<cr>

nnoremap <:git>b :exec 'Tig blame -C ' . expand('%:f') . ' +' . line('.')<cr>

nnoremap <:git>l :exec 'Tig log ' . expand('%:f')<cr>
nnoremap <:git:1>l :Tig log<cr>
nnoremap <:git>L :exec 'Tig log ' . expand('%:h')<cr>
nnoremap <:git:1>L :Tig log<cr>

nnoremap <:git>s :exec 'Tig show ' . expand('%:f')<cr>
nnoremap <:git:1>s :Tig show<cr>
nnoremap <:git>S :exec 'Tig show ' . expand('%:h')<cr>
nnoremap <:git:1>S :Tig show<cr>

nnoremap <:git>y :Tig stash<cr>

nnoremap <:git:1>r :Tig refs<cr>

""""""""""""""""
" PLUGINS
""""""""""""""""

" vim-gitgutter

" don't map keys
let g:gitgutter_map_keys = 0

" motions
omap ih <plug>GitGutterTextObjectInnerPending
omap ah <plug>GitGutterTextObjectOuterPending
xmap ih <plug>GitGutterTextObjectInnerVisual
xmap ah <plug>GitGutterTextObjectOuterVisual

" go to next/prev changed hunk
nmap <:hunk>j <plug>GitGutterNextHunk
nmap <:hunk>k <plug>GitGutterPrevHunk

" preview changed hunk
nmap <:hunk>p <plug>GitGutterPreviewHunk

" stage changed hunk
nmap <:hunk>s <plug>GitGutterStageHunk

" revert changed hunk
nmap <:hunk>u <plug>GitGutterRevertHunk
