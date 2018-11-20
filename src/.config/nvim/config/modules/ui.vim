""""""""""""""""
" SETTINGS
""""""""""""""""

syntax enable
set background=dark

if !has('nvim')
	set t_Co=256
endif

set termguicolors
let base16colorspace=256
let g:base16_color_overrides = { 'ColorColumn': 'bg=dark3' }
let g:base16_transparent_background = 1

scriptencoding utf-8

if has('nvim')
	colorscheme nvim
else
	colorscheme vim
endif

" Stop highlighting pairs
let loaded_matchparen = 1

""""""""""""""""
" VIM-HIGHLIGHTEDYANK
""""""""""""""""

" Set highlight duration
let g:highlightedyank_highlight_duration = 200

""""""""""""""""
" LIGHTLINE
""""""""""""""""

let g:lightline = {
	\ 'colorscheme': 'materia'
\ }
