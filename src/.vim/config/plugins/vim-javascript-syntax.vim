" enable js code folding
if neobundle#tap('vim-javascript-syntax')
	function! neobundle#tapped.hooks.on_source(bundle)
		" TODO: preserve my own foldlevel

		autocmd FileType javascript
			\ call JavaScriptFold() |
			\ set foldlevelstart=128

	endfunction

	call neobundle#untap()
endif
