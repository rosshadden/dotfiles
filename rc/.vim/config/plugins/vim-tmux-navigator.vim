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
