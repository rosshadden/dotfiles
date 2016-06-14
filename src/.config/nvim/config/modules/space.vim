""""""""""""""""
" SETTINGS
""""""""""""""""

" show invisibles
set list

" better whitespace characters
set listchars=tab:»\ ,trail:·,nbsp:_,extends:>,precedes:<

set linebreak
set breakindent
" let &showbreak = '... '
" let &showbreak = '… '
let &showbreak = '↪️ '

" strip whitepsace
let g:strip_whitespace_on_save = 1

" blacklist files
let g:better_whitespace_filetypes_blacklist = [ 'diff', 'gitcommit', 'qf', 'help', 'pandoc' ]

" set the colors
highlight ExtraWhitespace ctermfg=white ctermbg=blue


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('space', '<:prefix>s')

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" up, down, left, right
noremap <:space>h i<space><esc>l
noremap <:space>l a<space><esc>h
" TODO: figure out native maps, instead of relying on vim-unimpaired
map <:space>j ]<space>
map <:space>k [<space>

" horizontal
map <:space>s <:space>h<:space>l
" vertical
map <:space>v <:space>j<:space>k

" convert between tabs and spaces
map <:space>t :Space2Tab<cr>
map <:space>T :Tab2Space<cr>

" easy toggles
noremap coW :ToggleWhitespace<cr>
noremap coS :ToggleStripWhitespaceOnSave<cr>
