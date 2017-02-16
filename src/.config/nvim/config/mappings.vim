" fix Y
noremap Y y$

" shift is for sucks!
noremap ; :
noremap <leader>; ;

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

" SEARCHING
" TODO: breakout.exe

" toggle highlighted search
nnoremap <:leader:1>/ :nohlsearch<cr>
nnoremap co/ :set hlsearch!<cr>

" search for visually-selected word
vnoremap / "vy/<c-r>v
vnoremap ? "vy?<c-r>v

" search for current word
nnoremap g/ gd``

" find result and clear highlight
cnoremap <a-cr> <cr>:nohlsearch<cr>

" FORMATTING

" use Q for formatting, not Ex mode
noremap Q gq

" BUILD

noremap <localleader><space> :Make<cr>:cc<cr>
noremap <localleader><localleader><space> :Make!<cr>:cc<cr>
