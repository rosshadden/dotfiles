" prefix
call MakePrefix('app', '<:prefix>a')
call MakePrefix('app', '<:app>a', 1)


" quit
nnoremap <:app:0>q :q<cr>
nnoremap <:app:0>Q :q!<cr>
nnoremap <:app:1>q :qa<cr>
nnoremap <:app:1>Q :qa!<cr>


" write
nnoremap <:app:0>w :w<cr>
nnoremap <:app:0>W :w!<cr>
nnoremap <:app:1>w :wa<cr>
nnoremap <:app:1>W :wa!<cr>


" write and quit
nnoremap <:app:0>x :wq<cr>
nnoremap <:app:0>X :wq!<cr>
nnoremap <:app:1>x :wqa<cr>
nnoremap <:app:1>X :wqa!<cr>


" reload
noremap <:app:0>r :edit<cr>
noremap <:app:0>R :edit!<cr>
noremap <:app:1>r :FixSettings<cr>
noremap <:app:1>R :Reload<cr>
