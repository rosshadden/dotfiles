set foldmethod=syntax
set foldlevelstart=128
set foldcolumn=2

augroup rcFolds
	" support both indent and manual folding
	autocmd BufReadPre * setlocal foldmethod=indent
	autocmd BufWinEnter * if (&foldmethod == 'indent' || &foldmethod == 'syntax') | setlocal foldmethod=manual | endif
augroup END


" prefix
call MakePrefix('folds', '[prefix]z')

nnoremap <silent> [folds]<space> @=(foldlevel('.')?'za':"\<space>")<cr>
vnoremap [folds]<space> zf
nmap [folds]` :set foldlevel=0<cr>
nmap [folds]1 :set foldlevel=1<cr>
nmap [folds]2 :set foldlevel=2<cr>
nmap [folds]3 :set foldlevel=3<cr>
nmap [folds]4 :set foldlevel=4<cr>
nmap [folds]5 :set foldlevel=5<cr>
nmap [folds]6 :set foldlevel=6<cr>
nmap [folds]7 :set foldlevel=7<cr>
nmap [folds]8 :set foldlevel=8<cr>
nmap [folds]9 :set foldlevel=9<cr>
nmap [folds]0 :set foldlevel=128<cr>
nmap [folds]z :call ToggleFold()<cr>

let b:foldlevel=&l:foldlevel
function! ToggleFold()
	if &l:foldmethod == 'syntax'
		set foldmethod=indent
	elseif &l:foldmethod == 'indent'
		set foldmethod=manual
	else
		set foldmethod=syntax
	endif

	echo 'Fold method set to "' . &foldmethod . '"'

	" if &l:foldenable
	" 	let b:foldlevel=&l:foldlevel
	" 	set nofoldenable
	" else
	" 	set foldenable
	" 	set foldlevel = b:foldlevel
	" endif
endfunction
