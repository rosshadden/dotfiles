""""""""""""""""
" SETTINGS
""""""""""""""""

" tabs! (not to be confused with tabs)
set tabstop=2 shiftwidth=2


""""""""""""""""
" FUNCTIONS
""""""""""""""""

let g:lastTab = 1

augroup tabs
	autocmd!
	autocmd TabLeave * let g:lastTab = tabpagenr()
augroup END


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('tabs', '<:prefix>t')
call MakePrefix('tabs', '<:tabs>t', 1)

" relative navigation
nnoremap <silent> n :tabnext<cr>
nnoremap <silent> <m-n> :tabnext<cr>
nnoremap <silent> p :tabprevious<cr>
nnoremap <silent> <m-p> :tabprevious<cr>

" fast tab navigation
nnoremap <silent> ` :tabfirst<cr>
nnoremap <silent> <m-`> :tabfirst<cr>
nnoremap 1 1gt
nnoremap <m-1> 1gt
nnoremap 2 2gt
nnoremap <m-2> 2gt
nnoremap 3 3gt
nnoremap <m-3> 3gt
nnoremap 4 4gt
nnoremap <m-4> 4gt
nnoremap 5 5gt
nnoremap <m-5> 5gt
nnoremap 6 6gt
nnoremap <m-6> 6gt
nnoremap 7 7gt
nnoremap <m-7> 7gt
nnoremap 8 8gt
nnoremap <m-8> 8gt
nnoremap 9 9gt
nnoremap <m-9> 9gt
nnoremap <silent> 0 :tablast<cr>
nnoremap <silent> <m-0> :tablast<cr>

" alt-tab (pun)
nnoremap <tab> :exe 'tabnext' . g:lastTab<cr>
nnoremap <m-tab> :exe 'tabnext' . g:lastTab<cr>

" new
noremap <silent> <:tabs>n :tabnew<cr>
noremap <silent> <:tabs>N :$tabnew<cr>
noremap <silent> <:tabs>p :-tabnew<cr>
noremap <silent> <:tabs>P :0tabnew<cr>

" duplicate
noremap <silent> <:tabs:1>n :tabnew %<cr>
noremap <silent> <:tabs:1>N :$tabnew %<cr>
noremap <silent> <:tabs:1>p :-tabnew %<cr>
noremap <silent> <:tabs:1>P :0tabnew %<cr>

" close
noremap <silent> <:tabs>c :tabclose<cr>
noremap <silent> <:tabs>C :tabclose!<cr>

" close others
noremap <silent> <:tabs>o :tabonly<cr>
noremap <silent> <:tabs>O :tabonly!<cr>

" NOTE: technically <:tabs>g and <:tabs>l are the same,
" though semantically the former is for absolute (numbered) navigation and the latter for relative
" goto [n:+1]
noremap <silent> <:tabs>g :<c-u>exe (v:count == 0) ? "tabnext" : "tabnext ".v:count1<cr>
" move to <:n:end>
noremap <silent> <:tabs>m :<c-u>exe "tabmove ".v:count<cr>

" next [n:+1]
noremap <silent> <:tabs>l :<c-u>exe (v:count == 0) ? "tabnext" : "tabnext ".v:count1<cr>
" previous <:n::1>
noremap <silent> <:tabs>h :<c-u>exe (v:count == 0) ? "tabprevious" : "tabprevious ".v:count1<cr>

" move <:n:1> left
noremap <silent> <:tabs>H :<c-u>exe "tabmove -".v:count1<cr>
" move <:n:1> right
noremap <silent> <:tabs>L :<c-u>exe "tabmove +".v:count1<cr>
