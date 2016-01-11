set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = [ 'eslint' ]

let g:syntastic_lua_checkers = [ 'luac', 'luacheck' ]
let g:syntastic_lua_luacheck_args = '--no-unused-args'

noremap coL :SyntasticToggleMode<cr>
