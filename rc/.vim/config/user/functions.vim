" make prefixes
" TODO: automate the "mode" creation
function! MakePrefix(name, key, ...)
	" accept `mode` number as an optional third argument
	let l:mode = (a:0 >= 1) ? a:1 : 0

	let l:doOverride = (a:0 == 0 || a:1 != 0)
	let l:prefixLong = '[' . a:name . ':' . l:mode . ']'

	" map the long form of the prefix, [prefix:n]
	execute 'map ' . l:prefixLong . ' <nop>'
	if l:doOverride == 1
		execute 'map ' . a:key . ' ' . PressPrefix(l:prefixLong)
	endif

	if l:mode == 0
		let l:prefix = '[' . a:name . ']'
		execute 'map ' . l:prefix . ' <nop>'
		execute 'map ' . l:prefixLong . ' ' . PressPrefix(l:prefix)
	endif

	" map the short prefix, [prefix]
	if l:doOverride == 0
		execute 'map ' . l:prefix . ' ' . PressPrefix(a:key)
	endif
endfunction

function! GetPrefix(...)
	if exists('w:prefix')
		return w:prefix
	end
	return ''
endfunction

function! PressPrefix(prefix)
	return a:prefix
	" return ':execute "let w:prefix = \"' . a:prefix . '\""<cr>' . a:prefix
endfunction


function! GetVisualSelection()
	" Why is this not a built-in Vim script function?!
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][col1 - 1:]
	return join(lines, "\n")
endfunction


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

autocmd FileType javascript
	\ map <localleader>v :execute PrintVersion('i')<cr> |
	\ map <localleader>V :execute PrintVersion('a')<cr>
