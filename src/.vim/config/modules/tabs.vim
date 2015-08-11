" prefix
call MakePrefix('tabs', '<:prefix>t')
call MakePrefix('tabs', '<:tabs>t', 1)

" relative navigation
nnoremap n :tabnext<cr>
nnoremap p :tabprevious<cr>

" fast tab navigation
nnoremap ` :tabfirst<cr>
nnoremap 1 1gt
nnoremap 2 2gt
nnoremap 3 3gt
nnoremap 4 4gt
nnoremap 5 5gt
nnoremap 6 6gt
nnoremap 7 7gt
nnoremap 8 8gt
nnoremap 9 9gt
nnoremap 0 :tablast<cr>

" new
noremap <:tabs>n :tabnew<cr>
noremap <:tabs>N :$tabnew<cr>
noremap <:tabs>p :-tabnew<cr>
noremap <:tabs>P :0tabnew<cr>

" duplicate
noremap <:tabs:1>n :tabnew %<cr>
noremap <:tabs:1>N :$tabnew %<cr>
noremap <:tabs:1>p :-tabnew %<cr>
noremap <:tabs:1>P :0tabnew %<cr>

" close
noremap <:tabs>c :tabclose<cr>
noremap <:tabs>C :tabclose!<cr>

" close others
noremap <:tabs>o :tabonly<cr>
noremap <:tabs>O :tabonly!<cr>

" NOTE: technically <:tabs>g and <:tabs>l are the same,
" though semantically the former is for absolute navigation and the latter for relative
" goto [n:+1]
noremap <:tabs>g :<c-u>exe (v:count == 0) ? "tabnext" : "tabnext ".v:count1<cr>
" move to <:n:end>
noremap <:tabs>m :<c-u>exe "tabmove ".v:count<cr>

" next [n:+1]
noremap <:tabs>l :<c-u>exe (v:count == 0) ? "tabnext" : "tabnext ".v:count1<cr>
" previous <:n::1>
noremap <:tabs>h :<c-u>exe (v:count == 0) ? "tabprevious" : "tabprevious ".v:count1<cr>

" move <:n:1> left
noremap <:tabs>H :<c-u>exe "tabmove -".v:count1<cr>
" move <:n:1> right
noremap <:tabs>L :<c-u>exe "tabmove +".v:count1<cr>
