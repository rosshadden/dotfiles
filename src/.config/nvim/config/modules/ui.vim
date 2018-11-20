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

""""""""""""""""
" TMUXLINE
""""""""""""""""

let g:tmuxline_preset = {
	\'a': '#S',
	\'b': '#W',
	\'win': '#I #W',
	\'cwin': '#I #W',
	\'y': '%a',
	\'z': '#h'
\ }

let g:tmuxline_separators = {
	\ 'left': '█▓░ ',
	\ 'left_alt': '',
	\ 'right': ' ░▓█',
	\ 'right_alt': '',
	\ 'space': ' '
\ }

	" \ 'left': '█▓▒░ ',
	" \ 'left': '',
	" \ 'left_alt': '',
	" \ 'right': '',
	" \ 'right_alt': '',
	" \ 'space': ' '

let g:tmuxline_theme = {
	\ 'a': [ 255, 13 ],
	\ 'b': [ 255, 10 ],
	\ 'c': [ 244, 236 ],
	\ 'x': [ 244, 236 ],
	\ 'y': [ 255, 10 ],
	\ 'z': [ 255, 13 ],
	\ 'win': [ 255, 236 ],
	\ 'cwin': [ 255, 13 ],
	\ 'bg': [ 244, 236 ],
\ }
