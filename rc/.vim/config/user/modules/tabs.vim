" prefix
call MakePrefix('tabs', '[prefix]t')
call MakePrefix('tabs', '[tabs]t', 1)

" new, at [n:+1]
map [tabs]n :tabnew<cr>
" duplicate
map [tabs]d :tabnew %<cr>
" close
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
map [tabs:1]h :<c-u>exe "tabmove -".v:count1<cr>
" move [n:1] right
map [tabs:1]l :<c-u>exe "tabmove +".v:count1<cr>
" move to [n:end]
map [tabs:1]m :<c-u>exe "tabmove ".v:count<cr>
