" fix Y
noremap Y y$

" shift is for sucks!
noremap ; :
noremap <leader>; :OverCommandLine<cr>
noremap <leader>: :OverCommandLine<cr>

" U => redo [:redo]
noremap U :redo<cr>

" write
" L-w => write [:write]
noremap <leader>w :write<cr>
" L-W => force save [:write!]
noremap <leader>W :write!<cr>

" save
" L-s => save [:update]
noremap <leader>s :update<cr>
" L-S => force save [:write]
noremap <leader>S :update!<cr>

" reload
" L-r => reload file [:edit]
noremap <leader>r :edit<cr>
noremap <leader>R :edit!<cr>
" L-L-r => reload config [:Reload]
noremap <:leader:1>r :Reload<cr>

" L-. => repeat last command
noremap <leader>. @:

" searching
	" toggle highlighted search
	nnoremap <:leader:1>/ :nohlsearch<cr>
	nnoremap co/ :set hlsearch!<cr>
	" search for selected word
	vnoremap / "vy/<c-r>v
	vnoremap ? "vy?<c-r>v

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" use Q for formatting, not Ex mode
noremap Q gq

" build
noremap <localleader><space> :Make<cr>:cc<cr>
noremap <localleader><localleader><space> :Make!<cr>:cc<cr>
