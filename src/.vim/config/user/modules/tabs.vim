" prefix
call MakePrefix('tabs', '[prefix]t')
call MakePrefix('tabs', '[tabs]t', 1)

" relative navigation
nmap n :tabnext<cr>
nmap p :tabprevious<cr>

" fast tab navigation
nmap ` :tabfirst<cr>
nmap 1 1gt
nmap 2 2gt
nmap 3 3gt
nmap 4 4gt
nmap 5 5gt
nmap 6 6gt
nmap 7 7gt
nmap 8 8gt
nmap 9 9gt
nmap 0 :tablast<cr>

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

" move [n:1] left
map [tabs]H :<c-u>exe "tabmove -".v:count1<cr>

" move [n:1] right
map [tabs]L :<c-u>exe "tabmove +".v:count1<cr>

" move to [n:end]
map [tabs]m :<c-u>exe "tabmove ".v:count<cr>
