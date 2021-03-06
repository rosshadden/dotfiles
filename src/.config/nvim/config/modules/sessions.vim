""""""""""""""""
" SETTINGS
""""""""""""""""

" opt-in
let g:session_autosave = 'yes'
let g:session_autoload = 'no'

" don't restore help windows
set sessionoptions-=help


""""""""""""""""
" FUNCTIONS
""""""""""""""""

" figure out the name of an applicable session
function! GetSessionName()
	let l:root = ProjectRootGuess()
	return split(l:root, '/')[-1]
endfunction


" open applicable session
function! OpenSession(...)
	let l:cmd = 'OpenSession'

	if a:0 >= 1
		let l:cmd .= ' ' . a:1
	endif

	execute '"' . l:cmd . '"'
endfunction


" save applicable session
function! SaveSession(...)
	let l:cmd = 'SaveSession'

	if a:0 >= 1
		let l:cmd .= ' ' . a:1
	endif

	execute '"' . l:cmd . '"'
endfunction


" delete applicable session
function! DeleteSession(...)
	let l:cmd = 'DeleteSession'

	if a:0 >= 1
		let l:cmd .= ' ' . a:1
	endif

	execute '"' . l:cmd . '"'
endfunction


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('session', '<:prefix>S')

nnoremap <expr><:session><space> OpenSession()

nnoremap <expr><:session>o OpenSession(GetSessionName())
