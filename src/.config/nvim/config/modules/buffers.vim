""""""""""""""""
" SETTINGS
""""""""""""""""

" more natural splits
set splitbelow
set splitright


function! CleanEmptyBuffers()
	let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
	if !empty(buffers)
		exe 'bw '.join(buffers, ' ')
	endif
endfunction


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix

call MakePrefix('buffers', '<:prefix>b')
call MakePrefix('buffers', '<:buffers>b', 1)

" switch to alternate buffer
noremap <leader>b <c-^>

" navigation
nnoremap j <c-w>j
nnoremap k <c-w>k
nnoremap h <c-w>h
nnoremap l <c-w>l

nnoremap <silent> <:buffers>n :bnext<cr>
nnoremap <silent> <:buffers>p :bprevious<cr>

nnoremap <silent> <:buffers>N :blast<cr>
nnoremap <silent> <:buffers>P :bfirst<cr>

" split buffer [h, j, k, l]
nnoremap <silent> <:buffers>j :rightbelow new<cr>
nnoremap <silent> <:buffers>k :leftabove new<cr>
nnoremap <silent> <:buffers>h :leftabove vnew<cr>
nnoremap <silent> <:buffers>l :rightbelow vnew<cr>

" clone buffer [h, j, k, l]
nnoremap <silent> <:buffers:1>j :rightbelow split<cr>
nnoremap <silent> <:buffers:1>k :leftabove split<cr>
nnoremap <silent> <:buffers:1>h :leftabove vsplit<cr>
nnoremap <silent> <:buffers:1>l :rightbelow vsplit<cr>

" close buffer
nnoremap <silent> <:buffers>c :Bdelete<cr>
nnoremap <silent> <:buffers>C :Bdelete!<cr>
nnoremap <silent> <:buffers:1>c :bufdo Bdelete<cr>
nnoremap <silent> <:buffers:1>C :bufdo Bdelete!<cr>

" delete all empty buffers
nnoremap <silent> <:buffers>r :call CleanEmptyBuffers()<cr>

" PROMPTS

" current buffers
nnoremap <silent> <:buffers>s :Unite              -buffer-name=buffers buffer<cr>
nnoremap <silent> <:buffers>S :UniteWithBufferDir -buffer-name=buffers buffer<cr>

" current... tabs? buffers?
nnoremap <silent> <:buffers>t :Unite              -buffer-name=buffers tab buffer_tab<cr>
nnoremap <silent> <:buffers>T :UniteWithBufferDir -buffer-name=buffers tab buffer_tab<cr>

" buffer, tab, or files
nnoremap <silent> <:buffers>a :Unite              -buffer-name=buffers buffer tab file_mru directory_mru bookmark<cr>
nnoremap <silent> <:buffers>A :UniteWithBufferDir -buffer-name=buffers buffer tab file_mru directory_mru bookmark<cr>
