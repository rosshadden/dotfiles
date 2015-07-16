set foldmethod=syntax
set foldlevelstart=128
set foldcolumn=0

" prefix
call MakePrefix('folds', '[prefix]f')

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

" toggle folds
nnoremap <silent> [folds]<space> @=(foldlevel('.')?'za':"\<space>")<cr>
vnoremap [folds]<space> zf
nmap cof [folds]<space>
nmap coF :call ToggleFold()<cr>

vnoremap [folds]a za
vnoremap [folds]A zA

let b:foldlevel = &l:foldlevel
function! ToggleFold()
	if &l:foldmethod == 'syntax'
		set foldmethod=indent
	elseif &l:foldmethod == 'indent'
		set foldmethod=manual
	else
		set foldmethod=syntax
	endif

	echo 'Fold method set to "' . &foldmethod . '"'
endfunction
