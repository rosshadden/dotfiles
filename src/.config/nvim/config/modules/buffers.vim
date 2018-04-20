""""""""""""""""
" SETTINGS
""""""""""""""""

" more natural splits
set splitbelow
set splitright

""""""""""""""""
" FUNCTIONS
""""""""""""""""

function! CleanEmptyBuffers()
	let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0')
	if !empty(buffers)
		exec 'bwipeout ' . join(buffers, ' ')
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
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-h> <c-w>h
nnoremap <m-l> <c-w>l

nnoremap <silent> <:buffers><space> :Buffers<cr>

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
nnoremap <a-c> :bdelete<cr>
nnoremap <silent> <:buffers>c :bdelete<cr>
nnoremap <silent> <:buffers>C :bdelete!<cr>
nnoremap <silent> <:buffers:1>c :bufdo bdelete<cr>
nnoremap <silent> <:buffers:1>C :bufdo bdelete!<cr>

" delete all empty buffers
nnoremap <silent> <:buffers>r :call CleanEmptyBuffers()<cr>

" PROMPTS

" current buffers
nnoremap <:buffers>s :Buffers<cr>
