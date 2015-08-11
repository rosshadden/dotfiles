" more natural splits

set splitbelow
set splitright


function! CleanEmptyBuffers()
	let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
	if !empty(buffers)
		exe 'bw '.join(buffers, ' ')
	endif
endfunction


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

nnoremap <:buffers>n :bnext<cr>
nnoremap <:buffers>p :bprevious<cr>

nnoremap <:buffers>N :blast<cr>
nnoremap <:buffers>P :bfirst<cr>


" split buffer [h, j, k, l]

nnoremap <:buffers>j :rightbelow new<cr>
nnoremap <:buffers>k :leftabove new<cr>
nnoremap <:buffers>h :leftabove vnew<cr>
nnoremap <:buffers>l :rightbelow vnew<cr>


" clone buffer [h, j, k, l]

nnoremap <:buffers:1>j :rightbelow split<cr>
nnoremap <:buffers:1>k :leftabove split<cr>
nnoremap <:buffers:1>h :leftabove vsplit<cr>
nnoremap <:buffers:1>l :rightbelow vsplit<cr>


" close buffer

nnoremap <:buffers>c :bdelete<cr>
nnoremap <:buffers>C :bdelete!<cr>
nnoremap <:buffers:1>c :bufdo bdelete<cr>
nnoremap <:buffers:1>C :bufdo bdelete!<cr>


" delete all empty buffers
nnoremap <:buffers>r :call CleanEmptyBuffers()<cr>
