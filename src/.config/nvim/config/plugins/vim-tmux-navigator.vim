" use my own mappings, <meta> instead of <control>
let g:tmux_navigator_no_mappings = 1

noremap <silent> <c-h> :TmuxNavigateLeft<cr>
noremap <silent> <c-l> :TmuxNavigateRight<cr>
noremap <silent> <c-k> :TmuxNavigateUp<cr>
noremap <silent> <c-j> :TmuxNavigateDown<cr>
noremap <silent> <c-\> :TmuxNavigatePrevious<cr>

inoremap <silent> <c-h> <c-o>:TmuxNavigateLeft<cr>
inoremap <silent> <c-l> <c-o>:TmuxNavigateRight<cr>
inoremap <silent> <c-k> <c-o>:TmuxNavigateUp<cr>
inoremap <silent> <c-j> <c-o>:TmuxNavigateDown<cr>
inoremap <silent> <c-\> <c-o>:TmuxNavigatePrevious<cr>

vnoremap <silent> <c-h> :<c-w>TmuxNavigateLeft<cr>gv
vnoremap <silent> <c-l> :<c-w>TmuxNavigateRight<cr>gv
vnoremap <silent> <c-k> :<c-w>TmuxNavigateUp<cr>gv
vnoremap <silent> <c-j> :<c-w>TmuxNavigateDown<cr>gv
vnoremap <silent> <c-\> :<c-w>TmuxNavigatePrevious<cr>gv
