" newline + indent
imap <c-c><enter> <cr><esc>O

" delete adjacent pairs
imap <c-c><bs> <bs><del>

" delete succeeding characters
imap <c-c>l <esc>ld$a

" delete preceding characters
imap <c-c>h <esc>ld0i

" set a break in undo, so CTRL-U in insert mode is less destructive
imap <c-u> <c-g>u<c-u>
