" TODO: rename module

""""""""""""""""
" FUNCTIONS
""""""""""""""""

function! s:agWithOptions(arg, bang)
	let tokens  = split(a:arg)
	let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
	let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
	call fzf#vim#ag(query, ag_opts, a:bang ? {} : { 'down': '40%' })
endfunction

autocmd VimEnter * command! -nargs=* -bang Ag call s:agWithOptions(<q-args>, <bang>0)

""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('aoeu', '<:prefix>u')
call MakePrefix('aoeu', '<:aoeu>u', 1)

" line
nnoremap <:aoeu>l :Lines<cr>
nnoremap <:aoeu>L :BLines<cr>

" TODO: spelling

" search files
nnoremap <:aoeu>g :Ag<cr>
nnoremap <:aoeu>G :Ag --hidden<cr>
nnoremap <:aoeu:1>g :Ag<space>
nnoremap <:aoeu:1>G :Ag --hidden<space>

" metavim
" mappings
nnoremap <:aoeu>m :Maps<cr>
