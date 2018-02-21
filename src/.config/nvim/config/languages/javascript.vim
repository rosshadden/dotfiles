""""""""""""""""
" SETTINGS
""""""""""""""""

" javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,chai,jquery'

" vim-jsdoc
let g:jsdoc_enable_es6 = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_return_description = 0
let g:jsdoc_param_description_separator = ' - '

" tern
let g:tern_map_keys = 1
let g:tern#command = [ 'tern' ]
let g:tern#arguments = [ '--persistent' ]
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'
let g:tern#filetypes = [ 'javascript', 'javascript.jsx', 'typescript' ]

""""""""""""""""
" FUNCTIONS
""""""""""""""""

" print project version from `package.json` before/after cursor
function! InsertVersion(command)
	let l:root = ProjectRootGuess()
	let l:package = join(readfile(l:root . '/package.json'), "\n")

	let l:version = matchlist(l:package, '\c"version":\s*"\([0-9.]\+\)",')[1]

	" paste the version at the cursor
	" TODO: figure out why it jumps the cursor to the BOF
	execute 'normal! ' . a:command . l:version . ''
endfunction

""""""""""""""""
" MISC
""""""""""""""""

augroup javascript
	autocmd!

	autocmd FileType javascript,typescript
		\| map <localleader>v :execute InsertVersion('a')<cr>
		\| map <localleader>V :execute InsertVersion('i')<cr>
		\| map <localleader>s :'<,'>sort /^import.\+ \zs['"]/<cr>
augroup END
