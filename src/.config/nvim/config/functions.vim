" make prefixes
" TODO: automate the 'mode' creation
function! MakePrefix(name, key, ...)
	" accept `mode` number as an optional third argument
	let l:mode = (a:0 >= 1) ? a:1 : 0

	let l:doOverride = (a:0 == 0 || a:1 != 0)
	let l:prefixLong = '<:' . a:name . ':' . l:mode . '>'

	" map the long form of the prefix, <:prefix:n>
	execute 'map ' . l:prefixLong . ' <nop>'
	if l:doOverride == 1
		execute 'map ' . a:key . ' ' . PressPrefix(l:prefixLong)
	endif

	if l:mode == 0
		let l:prefix = '<:' . a:name . '>'
		execute 'map ' . l:prefix . ' <nop>'
		execute 'map ' . l:prefixLong . ' ' . PressPrefix(l:prefix)
	endif

	" map the short prefix, <:prefix>
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
	let [ l:lnum1, l:col1 ] = getpos("'<")[1:2]
	let [ l:lnum2, l:col2 ] = getpos("'>")[1:2]
	let l:lines = getline(l:lnum1, l:lnum2)
	let l:lines[-1] = l:lines[-1][: l:col2 - (&selection ==? 'inclusive' ? 1 : 2)]
	let l:lines[0] = l:lines[0][l:col1 - 1:]
	return join(l:lines, "\n")
endfunction


function! FixSettings()
	set tabstop=2 shiftwidth=2
endfunction


" https://github.com/junegunn/vim-plug/issues/146#issuecomment-70376031

function! IsInstalled(plugin)
	return isdirectory(g:plugs[a:plugin].dir)
endfunction

function! IsLoaded(plugin)
	return stridx(&rtp, g:plugs[a:plugin].dir) >= 0
endfunction
