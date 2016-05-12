" prefix
call MakePrefix('app', '<:prefix>a')
call MakePrefix('app', '<:app>a', 1)

" quit
nnoremap <:app>q :q<cr>
nnoremap <:app>Q :q!<cr>
nnoremap <:app:1>q :qa<cr>
nnoremap <:app:1>Q :qa!<cr>

" close
nnoremap <:app>c :q<cr>
nnoremap <:app>C :q!<cr>
nnoremap <:app:1>c :qa<cr>
nnoremap <:app:1>C :qa!<cr>

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
noremap <:app:1>r :Reload<cr>

" fix indentation
noremap <:app>i :FixIndentation<cr>

" search history
nnoremap <:app>/ :History/<cr>

" command history
nnoremap <:app>; :History:<cr>
" command list
nnoremap <:app>: :Commands<cr>

" show mappings
nnoremap <:app>m :Maps<cr>

" TODO: yank stack
