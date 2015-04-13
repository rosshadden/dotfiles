" better whitespace characters
set listchars=tab:»\ ,trail:·,nbsp:_,extends:>,precedes:<

set linebreak
set breakindent
let &showbreak = "... "

" prefix
call MakePrefix('space', '[prefix]s')

noremap [space]h i<space><esc>l
noremap [space]l a<space><esc>h
" TODO: figure out native maps, instead of relying on vim-unimpaired
map [space]j ]<space>
map [space]k [<space>

" horizontal
map [space]s [space]h[space]l
" vertical
map [space]v [space]j[space]k
