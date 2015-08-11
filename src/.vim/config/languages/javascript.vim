""""""""""""""""
" SETTINGS
""""""""""""""""

" set libraries for othree/javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,underscore'

" vim-jsdoc

let g:jsdoc_allow_input_prompt      = 1 " 0
let g:jsdoc_input_description       = 1 " 1
let g:jsdoc_additional_descriptions = 0 " 0
let g:jsdoc_return                  = 1 " 1
let g:jsdoc_return_type             = 1 " 1
let g:jsdoc_return_description      = 1 " 1
let g:jsdoc_default_mapping         = 0 " 1


""""""""""""""""
" FUNCTIONS
""""""""""""""""

" print project version from `package.json` before/after cursor
function! PrintVersion(direction)
	let l:root = ProjectRootGuess()
	let l:package = join(readfile(l:root . '/package.json'), "\n")

	" let l:version = substitute(l:package, 'version', 'AOEU', '')
	let l:version = matchlist(l:package, '\c"version":\s*"\([0-9.]\+\)",')[1]

	" paste the version at the cursor
	" TODO: figure out why it jumps the cursor to the BOF
	execute 'normal! ' . a:direction . l:version . ''
endfunction


""""""""""""""""
" MAPPINGS
""""""""""""""""

augroup javascript
	autocmd!

	" fixes a weird thing where vim things some js files are `sh`
	autocmd BufNewFile,BufRead *.js set filetype=javascript

	" print version
	autocmd FileType javascript
		\ map <localleader>v :execute PrintVersion('i')<cr> |
		\ map <localleader>V :execute PrintVersion('a')<cr>

	" jsdoc
	autocmd FileType javascript nmap <silent> <localleader>C <plug>(jsdoc)
augroup END
