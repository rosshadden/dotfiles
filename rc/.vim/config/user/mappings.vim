" fix Y
map Y y$

" shift is for sucks? (avoids :W style typos, or so I'm told)
map ; :

" U => redo [:redo]
map U :redo<cr>

" L-s => save [:update]
map <leader>s :update<cr>
" L-S => force save [:write]
map <leader>S :write<cr>

" L-w => quit [:quit]
map <leader>w :quit<cr>
" L-W => force quit [:quit!]
map <leader>W :quit!<cr>

" L-x => save and quit [:wq]
map <leader>x :wq<cr>

" L-r => reload file [:edit]
map <leader>r :edit<cr>
map <leader>R :edit!<cr>
" L-L-r => reload config [:Reload]
map [leader:1]r :Reload<cr>

" L-. => repeat last command
map <leader>. @:

" insert/append
	" tab
	noremap <leader>it i<tab>
	noremap <leader>i<tab> i<tab>
	noremap <leader>at a<tab>
	noremap <leader>a<tab> a<tab>

" searching
	" clear highlighted search
	nmap [leader:1]/ :nohlsearch<cr>
	" search for selected word
	vmap <leader>/ "vy/<c-r>v
	vmap <leader>? "vy?<c-r>v

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" use Q for formatting, not Ex mode
map Q gq

" set a break in undo, so CTRL-U in insert mode is less destructive
map <c-u> <c-g>u<c-u>

" switch to alternate file
map <leader>b <c-^>
