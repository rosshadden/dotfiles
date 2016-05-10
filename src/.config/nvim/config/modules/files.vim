""""""""""""""""
" FUNCTIONS
""""""""""""""""

" TODO: accept filename arg, to select it in ranger
function! OpenRanger(dir)
	let l:currentPath = expand(a:dir)
	let l:tempFilePath = tempname()
	let l:cmd = 'ranger --choosefiles=' . shellescape(l:tempFilePath) . ' ' . l:currentPath

	if has('nvim')
		let l:rangerCallback = { 'name': 'ranger' , 'tempFilePath': l:tempFilePath }

		function! l:rangerCallback.on_exit(id, code)
			Bdelete!

			if filereadable(self.tempFilePath)
				for l:file in readfile(self.tempFilePath)
					exec 'edit ' . l:file
				endfor

				call delete(self.tempFilePath)
			endif
		endfunction

		enew

		call termopen(l:cmd, l:rangerCallback)

		startinsert
	else
		exec 'silent !' . l:cmd

		if filereadable(l:tempFilePath)
			for l:file in readfile(l:tempFilePath)
				exec 'edit ' . l:file
			endfor

			call delete(l:tempFilePath)
		endif

		redraw!
	endif
endfunction

""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('files', '<:prefix>f')
call MakePrefix('files', '<:files>f', 1)

" file manager
noremap <:files><space> :call OpenRanger('')<CR>
noremap <:files:1><space> :call OpenRanger('%:p:h')<CR>

" recursive
nnoremap <:files>r :Files<cr>
nnoremap <:files:1>r :Files<space>
nnoremap <:files>s :FZF --tiebreak=length,end,index<cr>
nnoremap <:files:1>s :FZF --tiebreak=length,end,index<space>

" git
nnoremap <:files>g :GitFiles<cr>
nnoremap <:files>G :GitFiles?<cr>

" most recently used (mru) files
nnoremap <:files>m :FilesMru<cr>
nnoremap <:files>M :ProjectMru<cr>
