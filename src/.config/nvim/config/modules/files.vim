""""""""""""""""
" SETTINGS
""""""""""""""""

" make fzf use current pane
let g:fzf_layout = { 'window': 'enew' }

" jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Seamless splits
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-k': 'leftabove split',
	\ 'ctrl-j': 'rightbelow split',
	\ 'ctrl-h': 'leftabove vsplit',
	\ 'ctrl-l': 'rightbelow vsplit',
\ }

""""""""""""""""
" FUNCTIONS
""""""""""""""""

" TODO: make argument optional
function! OpenRanger(selectFile)
	let l:tempFilePath = tempname()
	let l:cmd = 'ranger --choosefiles=' . shellescape(l:tempFilePath)

	let l:file = expand('%:f:h')
	if a:selectFile == 1 && l:file != ''
		let l:cmd .= ' --selectfile=' . shellescape(l:file)
	endif

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

" allow `:Ag` to be called with options (like `--hidden`)
function! s:agWithOptions(arg, bang)
	let tokens  = split(a:arg)
	let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
	let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
	call fzf#vim#ag(query, ag_opts, a:bang ? {} : { 'down': '40%', 'prompt': 'foo' })
endfunction

augroup files
	autocmd!
	autocmd VimEnter * command! -nargs=* -bang Ag call s:agWithOptions(<q-args>, <bang>0)
augroup END

""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('files', '<:prefix>f')
call MakePrefix('files', '<:files>f', 1)

" file manager
noremap <silent> <:files><space> :call OpenRanger(1)<cr>
noremap <silent> <:files:1><space> :call OpenRanger(0)<cr>

" recursive
nnoremap <:files>r :FZF -m --tiebreak=length,end,index<cr>
nnoremap <:files:1>r :FZF -m --tiebreak=length,end,index<space>
nnoremap <:files>R :Files<cr>
nnoremap <:files:1>R :Files<space>

" most recently used (mru) files
nnoremap <:files>m :FilesMru<cr>
nnoremap <:files>M :ProjectMru<cr>

" search files
nnoremap <:files>s :Ag<cr>
nnoremap <:files>S :Ag --hidden<cr>
nnoremap <:files:1>s :Ag<space>
nnoremap <:files:1>S :Ag --hidden<space>

" line
nnoremap <:files>l :Lines<cr>
nnoremap <:files>L :BLines<cr>
