" more natural splits
set splitbelow
set splitright


" prefix
call MakePrefix('buffers', '[prefix]b')
call MakePrefix('buffers', '[buffers]b', 1)

" split buffer [h, j, k, l]
map [buffers]j :rightbelow new<cr>
map [buffers]k :leftabove new<cr>
map [buffers]h :leftabove vnew<cr>
map [buffers]l :rightbelow vnew<cr>

" clone buffer [h, j, k, l]
map [buffers:1]j :rightbelow split<cr>
map [buffers:1]k :leftabove split<cr>
map [buffers:1]h :leftabove vsplit<cr>
map [buffers:1]l :rightbelow vsplit<cr>

" close buffer
map [buffers]c :bdelete<cr>
map [buffers]C :bdelete!<cr>
" TODO: ease off
map [buffers]w :bdelete<cr>
map [buffers]W :bdelete!<cr>
