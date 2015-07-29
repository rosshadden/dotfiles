syntax enable
set t_Co=256
set background=dark
" set background=light

" access colors present in 256 colorspace
let base16colorspace=256
colorscheme base16-default


""""""""""""""""
" VIM-AIRLINE
""""""""""""""""

" powerline symbols
let g:airline_powerline_fonts = 1
" define and use my own 'prefix' mode, for showing the prefixes
call airline#parts#define_function('prefix', 'GetPrefix')
" let g:airline_section_a = airline#section#create_left(['mode', 'prefix', 'paste', 'capslock', 'iminsert'])
let g:airline_section_a = airline#section#create_left(['mode', 'paste', 'capslock', 'iminsert'])
let g:airline#extensions#branch#enabled = 1
let g:airline_theme = 'airlineish'

" this makes the base16 theme work
let g:airline#themes#base16#constant = 1

" if !exists('g:airline_symbols')
" 	let g:airline_symbols = {}
" endif
" let g:airline_symbols.space = "\ua0"


" extensions

	" tabline

	let g:airline#extensions#tabline#enabled = 1
	" close 'button'
	let g:airline#extensions#tabline#close_symbol = 'â'
	" how tab numbers are calculated (0 for # of splits, 1 for tab #)
	let g:airline#extensions#tabline#tab_nr_type = 1
	" quick buffer switch
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	nmap <leader>1 <Plug>AirlineSelectTab1
	nmap <leader>2 <Plug>AirlineSelectTab2
	nmap <leader>3 <Plug>AirlineSelectTab3
	nmap <leader>4 <Plug>AirlineSelectTab4
	nmap <leader>5 <Plug>AirlineSelectTab5
	nmap <leader>6 <Plug>AirlineSelectTab6
	nmap <leader>7 <Plug>AirlineSelectTab7
	nmap <leader>8 <Plug>AirlineSelectTab8
	nmap <leader>9 <Plug>AirlineSelectTab9


	" promptline

	let g:airline#extensions#promptline#enabled = 1
	let airline#extensions#promptline#snapshot_file = '~/dotfiles/src/themes/promptline.sh'

	" let airline#extensions#promptline#color_template = 'normal'
	let airline#extensions#promptline#color_template = 'insert'
	" let airline#extensions#promptline#color_template = 'visual'
	" let airline#extensions#promptline#color_template = 'replace'

	let g:promptline_preset = {
		\'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }), '$USER' ],
		\'b' : [ promptline#slices#cwd() ],
		\'warn' : [ promptline#slices#last_exit_code() ],
		\'x' : [ promptline#slices#git_status() ],
		\'y' : [ '$(git rev-parse --short HEAD 2>/dev/null)', promptline#slices#vcs_branch() ],
		\'z' : [ '%*' ],
	\ }


	" tmuxline

	let g:airline#extensions#tmuxline#enabled = 1
	let airline#extensions#tmuxline#snapshot_file = '~/dotfiles/src/themes/tmuxline.conf'
	let g:tmuxline_preset = 'crosshair'

	let airline#extensions#tmuxline#color_template = 'normal'
	" let airline#extensions#tmuxline#color_template = 'insert'
	" let airline#extensions#tmuxline#color_template = 'visual'
	" let airline#extensions#tmuxline#color_template = 'replace'
