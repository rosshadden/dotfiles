" strip whitepsace
let g:strip_whitespace_on_save = 1

" blacklist files
let g:better_whitespace_filetypes_blacklist = ['unite', 'vimfiler']

" set the colors
highlight ExtraWhitespace ctermfg=white ctermbg=blue

" easy toggles
map coW :ToggleWhitespace<cr>
map coS :ToggleStripWhitespaceOnSave<cr>
