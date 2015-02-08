" more natural splits

set splitbelow
set splitright


" prefix

call MakePrefix('buffers', '[prefix]b')
call MakePrefix('buffers', '[buffers]b', 1)


" navigation

nmap j <c-w>j
nmap k <c-w>k
nmap h <c-w>h
nmap l <c-w>l

nmap [buffers]n :bnext<cr>
nmap [buffers]p :bprevious<cr>

nmap [buffers]N :blast<cr>
nmap [buffers]P :bfirst<cr>


" split buffer [h, j, k, l]

nmap [buffers]j :rightbelow new<cr>
nmap [buffers]k :leftabove new<cr>
nmap [buffers]h :leftabove vnew<cr>
nmap [buffers]l :rightbelow vnew<cr>


" clone buffer [h, j, k, l]

nmap [buffers:1]j :rightbelow split<cr>
nmap [buffers:1]k :leftabove split<cr>
nmap [buffers:1]h :leftabove vsplit<cr>
nmap [buffers:1]l :rightbelow vsplit<cr>


" close buffer

nmap c :bdelete<cr>
nmap [buffers]c :bdelete<cr>
nmap [buffers]C :bdelete!<cr>
