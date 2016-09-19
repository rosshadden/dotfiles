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

	autocmd FileType javascript
		\  map <localleader>d :TernDef<cr>
		\| map <localleader>D :TernDefPreview<cr>
		\| map <localleader>l :TernDoc<cr>
		\| map <localleader>L :TernDocBrowse<cr>
		\| map <localleader>r :TernRefs<cr>
		\| map <localleader>R :TernRename<cr>
		\| map <localleader>t :TernType<cr>
		\| map <localleader>v :execute InsertVersion('a')<cr>
		\| map <localleader>V :execute InsertVersion('i')<cr>
augroup END
