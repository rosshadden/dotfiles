" newline + indent
imap <c-i><enter> <cr><esc>O

" delete adjacent pairs
imap <c-i><bs> <bs><del>

" delete succeeding characters
imap <c-i>l <esc>ld$a

" delete preceding characters
imap <c-i>h <esc>ld0i

" set a break in undo, so CTRL-U in insert mode is less destructive
imap <c-u> <c-g>u<c-u>
