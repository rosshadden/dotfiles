" prefix
call MakePrefix('tabs', '[prefix]t')
call MakePrefix('tabs', '[tabs]t', 1)

" fast tab switching
map . :tabnext<cr>
map , :tabprevious<cr>
map ` :tabfirst<cr>
map 1 1gt
map 2 2gt
map 3 3gt
map 4 4gt
map 5 5gt
map 6 6gt
map 7 7gt
map 8 8gt
map 9 9gt
map 0 :tablast<cr>

" new, at [n:+1]
map [tabs]n :tabnew<cr>

" duplicate
map [tabs:1]n :tabnew %<cr>

" close
map [tabs]c :tabclose<cr>
map [tabs]C :tabclose!<cr>
" TODO: ease off
map [tabs]w :tabclose<cr>
map [tabs]W :tabclose!<cr>

" close others
map [tabs]o :tabonly<cr>
map [tabs]O :tabonly!<cr>

" NOTE: technically [tabs]g and [tabs]l are the same,
" though semantically the former is for absolute navigation and the latter for relative
" goto [n:+1]
map [tabs]g :<c-u>exe (v:count == 0) ? "tabnext" : "tabnext ".v:count1<cr>
" next [n:+1]
map [tabs]l :<c-u>exe (v:count == 0) ? "tabnext" : "tabnext ".v:count1<cr>
" previous [n::1]
map [tabs]h :<c-u>exe (v:count == 0) ? "tabprevious" : "tabprevious ".v:count1<cr>
" first
map [tabs]f :tabfirst<cr>
" last
map [tabs]F :tablast<cr>

" move [n:1] left
map [tabs]H :<c-u>exe "tabmove -".v:count1<cr>

" move [n:1] right
map [tabs]L :<c-u>exe "tabmove +".v:count1<cr>

" move to [n:end]
map [tabs]m :<c-u>exe "tabmove ".v:count<cr>
