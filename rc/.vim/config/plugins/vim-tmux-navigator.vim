" use my own mappings, <meta> instead of <control>
let g:tmux_navigator_no_mappings = 1

map <silent> <m-h> :TmuxNavigateLeft<cr>
map <silent> <m-l> :TmuxNavigateRight<cr>
map <silent> <m-k> :TmuxNavigateUp<cr>
map <silent> <m-j> :TmuxNavigateDown<cr>
map <silent> <m-\> :TmuxNavigatePrevious<cr>

map <silent> <m-h> :echo 'hi'<cr>

map <silent> <c-h> :TmuxNavigateLeft<cr>
map <silent> <c-l> :TmuxNavigateRight<cr>
map <silent> <c-k> :TmuxNavigateUp<cr>
map <silent> <c-j> :TmuxNavigateDown<cr>
map <silent> <c-\> :TmuxNavigatePrevious<cr>
