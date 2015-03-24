" opt-in
let g:session_autosave = 'yes'
let g:session_autoload = 'no'


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
		l:cmd .= ' '
		l:cmd .= a:1
	endif
endfunction


" save applicable session
function! SaveSession(...)
	execute 'SaveSession ' . a:1
endfunction


" delete applicable session
function! DeleteSession(...)
	execute 'DeleteSession ' . a:1
endfunction


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('session', '[prefix]S')

nmap <expr>[session]<space> OpenSession()

nmap <expr>[session]o OpenSession(GetSessionName())
