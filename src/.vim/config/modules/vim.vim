" prefix
call MakePrefix('vim', '<:prefix>v')
call MakePrefix('vim', '<:vim>v', 1)


" quit
nnoremap <:vim:0>q :q<cr>
nnoremap <:vim:0>Q :q!<cr>
nnoremap <:vim:1>q :qa<cr>
nnoremap <:vim:1>Q :qa!<cr>


" write
nnoremap <:vim:0>w :w<cr>
nnoremap <:vim:0>W :w!<cr>
nnoremap <:vim:1>w :wa<cr>
nnoremap <:vim:1>W :wa!<cr>


" write and quit
nnoremap <:vim:0>x :wq<cr>
nnoremap <:vim:0>X :wq!<cr>
nnoremap <:vim:1>x :wqa<cr>
nnoremap <:vim:1>X :wqa!<cr>


" reload
noremap <:vim:0>r :edit<cr>
noremap <:vim:0>R :edit!<cr>
noremap <:vim:1>r :FixSettings<cr>
noremap <:vim:1>R :Reload<cr>
