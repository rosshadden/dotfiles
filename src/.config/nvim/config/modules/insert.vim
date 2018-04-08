" newline + indent
inoremap <c-c><cr> <cr><c-o>O

" pad cursor with spaces
inoremap <c-c><space> <space><space><left>

" delete adjacent pairs
inoremap <c-c><bs> <bs><del>

" set a break in undo, so <c-u> in insert mode is less destructive
inoremap <c-u> <c-g>u<c-u>

" fzf completions
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
