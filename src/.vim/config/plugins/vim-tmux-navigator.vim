" use my own mappings, <meta> instead of <control>
let g:tmux_navigator_no_mappings = 1

noremap <silent> <c-h> :TmuxNavigateLeft<cr>
noremap <silent> <c-l> :TmuxNavigateRight<cr>
noremap <silent> <c-k> :TmuxNavigateUp<cr>
noremap <silent> <c-j> :TmuxNavigateDown<cr>
noremap <silent> <c-\> :TmuxNavigatePrevious<cr>

inoremap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
inoremap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
inoremap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
inoremap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
inoremap <silent> <c-\> <esc>:TmuxNavigatePrevious<cr>

snoremap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
snoremap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
snoremap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
snoremap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
snoremap <silent> <c-\> <esc>:TmuxNavigatePrevious<cr>

xnoremap <silent> <c-h> <esc>:TmuxNavigateLeft<cr>
xnoremap <silent> <c-l> <esc>:TmuxNavigateRight<cr>
xnoremap <silent> <c-k> <esc>:TmuxNavigateUp<cr>
xnoremap <silent> <c-j> <esc>:TmuxNavigateDown<cr>
xnoremap <silent> <c-\> <esc>:TmuxNavigatePrevious<cr>
