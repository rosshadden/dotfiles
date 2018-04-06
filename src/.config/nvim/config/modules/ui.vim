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
runtime! colors/vim-airline.vim

" Stop highlighting pairs
let loaded_matchparen = 1

""""""""""""""""
" VIM-HIGHLIGHTEDYANK
""""""""""""""""

" Set highlight duration
let g:highlightedyank_highlight_duration = 200

""""""""""""""""
" VIM-AIRLINE
""""""""""""""""

if IsLoaded('vim-airline')
	" powerline symbols
	let g:airline_powerline_fonts = 1
	" define and use my own 'prefix' mode, for showing the prefixes
	call airline#parts#define_function('prefix', 'GetPrefix')
	" let g:airline_section_a = airline#section#create_left(['mode', 'prefix', 'paste', 'capslock', 'iminsert'])
	let g:airline_section_a = airline#section#create_left([ 'mode', 'paste', 'capslock', 'iminsert' ])
	let g:airline#extensions#branch#enabled = 1

	let theme = $DOTS_THEME
	let theme = (theme) ? theme : substitute(system('cat ~/dotfiles/THEME'), '\n\+$', '', '')
	let g:airline_theme = 'base16_' . theme

	" this makes the base16 theme work
	let g:airline#themes#base16#constant = 1

	" extensions

	" tabline

	let g:airline#extensions#tabline#enabled = 1
	" close 'button'
	let g:airline#extensions#tabline#close_symbol = '✖️'
	" how tab numbers are calculated (0 for # of splits, 1 for tab #)
	let g:airline#extensions#tabline#tab_nr_type = 1
	" quick buffer switch
	let g:airline#extensions#tabline#buffer_idx_mode = 1

	" tmuxline

	let g:airline#extensions#tmuxline#enabled = 1
	let airline#extensions#tmuxline#snapshot_file = g:themesDir . '/tmuxline.conf'
	let g:tmuxline_preset = 'crosshair'

	let airline#extensions#tmuxline#color_template = 'normal'
	" let airline#extensions#tmuxline#color_template = 'insert'
	" let airline#extensions#tmuxline#color_template = 'visual'
	" let airline#extensions#tmuxline#color_template = 'replace'
endif
