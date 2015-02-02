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


augroup javascript
	" fixes a weird thing where vim things some js files are `sh`
	autocmd BufNewFile,BufRead *.js set filetype=javascript

	" insert debugger
	autocmd FileType javascript
		\ nmap <localleader>d o<esc>cc<esc>Idebugger;<esc>
	autocmd FileType javascript
		\ nmap <localleader>D O<esc>cc<esc>Idebugger;<esc>


	" insert section comment
	autocmd FileType javascript
		\ nmap <localleader>cs o////////////////<esc>yypO// <esc>

	" print version
	autocmd FileType javascript
		\ map <localleader>v :execute PrintVersion('i')<cr> |
		\ map <localleader>V :execute PrintVersion('a')<cr>
augroup END
