" newline + indent
inoremap <c-c><cr> <cr><esc>O

" pad cursor with spaces
inoremap <c-c><space> <space><space><left>

" delete adjacent pairs
inoremap <c-c><bs> <bs><del>

" delete succeeding characters
inoremap <c-c>l <esc>ld$a

" delete preceding characters
inoremap <c-c>h <esc>ld0i

" set a break in undo, so CTRL-U in insert mode is less destructive
inoremap <c-u> <c-g>u<c-u>

" make <s-bs> work like <c-w>
inoremap <s-f7> <c-w>

" fzf completions
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
