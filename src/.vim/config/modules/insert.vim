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
