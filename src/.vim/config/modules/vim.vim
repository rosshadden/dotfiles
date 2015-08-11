" prefix

call MakePrefix('vim', '<:prefix>v')
call MakePrefix('vim', '<:vim>v', 1)


" quit

nmap <:vim:0>q :q<cr>
nmap <:vim:0>Q :q!<cr>

nmap <:vim:1>q :qa<cr>
nmap <:vim:1>Q :qa!<cr>


" write

nmap <:vim:0>w :w<cr>
nmap <:vim:0>W :w!<cr>

nmap <:vim:1>w :wa<cr>
nmap <:vim:1>W :wa!<cr>


" write and quit

nmap <:vim:0>x :wq<cr>
nmap <:vim:0>X :wq!<cr>

nmap <:vim:1>x :wqa<cr>
nmap <:vim:1>X :wqa!<cr>
