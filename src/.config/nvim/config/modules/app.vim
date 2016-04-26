" prefix
call MakePrefix('app', '<:prefix>a')
call MakePrefix('app', '<:app>a', 1)

" quit
nnoremap <:app>q :q<cr>
nnoremap <:app>Q :q!<cr>
nnoremap <:app:1>q :qa<cr>
nnoremap <:app:1>Q :qa!<cr>

" write
nnoremap <:app>w :w<cr>
nnoremap <:app>W :w!<cr>
nnoremap <:app:1>w :wa<cr>
nnoremap <:app:1>W :wa!<cr>

" write and quit
nnoremap <:app>x :wq<cr>
nnoremap <:app>X :wq!<cr>
nnoremap <:app:1>x :wqa<cr>
nnoremap <:app:1>X :wqa!<cr>

" reload
noremap <:app>r :edit<cr>
noremap <:app>R :edit!<cr>
noremap <:app:1>r :FixSettings<cr>
noremap <:app:1>R :Reload<cr>

" update plugins
noremap <:app>u :Unite neobundle/update<cr>

" yank stack
nnoremap <:app>y :Unite -buffer-name=yank history/yank<cr>

" command history
nnoremap <:app>; :Unite -buffer-name=commands -default-action=execute history/command command<cr>
nnoremap <:app:1>; :Unite -buffer-name=commands -default-action=edit history/command command<cr>
