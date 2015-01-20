" use my own mappings, <meta> instead of <control>
let g:tmux_navigator_no_mappings = 1

map <silent> <c-h> :TmuxNavigateLeft<cr>
map <silent> <c-l> :TmuxNavigateRight<cr>
map <silent> <c-k> :TmuxNavigateUp<cr>
map <silent> <c-j> :TmuxNavigateDown<cr>
map <silent> <c-\> :TmuxNavigatePrevious<cr>

imap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
imap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
imap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
imap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
imap <silent> <c-\> <esc>:TmuxNavigatePrevious<cr>

smap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
smap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
smap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
smap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
smap <silent> <c-\> <esc>:TmuxNavigatePrevious<cr>

xmap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
xmap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
xmap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
xmap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
xmap <silent> <c-\> <esc>:TmuxNavigatePrevious<cr>
