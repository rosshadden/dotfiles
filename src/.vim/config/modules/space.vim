""""""""""""""""
" SETTINGS
""""""""""""""""

" better whitespace characters
set listchars=tab:»\ ,trail:·,nbsp:_,extends:>,precedes:<

set linebreak
set breakindent
let &showbreak = "... "

" strip whitepsace
let g:strip_whitespace_on_save = 1

" blacklist files
let g:better_whitespace_filetypes_blacklist = ['unite', 'vimfiler']

" set the colors
highlight ExtraWhitespace ctermfg=white ctermbg=blue


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('space', '[prefix]s')

" up, down, left, right
noremap [space]h i<space><esc>l
noremap [space]l a<space><esc>h
" TODO: figure out native maps, instead of relying on vim-unimpaired
map [space]j ]<space>
map [space]k [<space>

" horizontal
map [space]s [space]h[space]l
" vertical
map [space]v [space]j[space]k

" easy toggles
map coW :ToggleWhitespace<cr>
map coS :ToggleStripWhitespaceOnSave<cr>
