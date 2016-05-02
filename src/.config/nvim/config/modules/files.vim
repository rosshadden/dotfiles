""""""""""""""""
" SETTINGS
""""""""""""""""

if dein#tap('unite.vim')
	call unite#custom#profile('files', 'context', {
		\ 'candidate_icon': '>',
		\ 'start_insert': 1,
		\ 'unique': 1,
	\ })
endif


""""""""""""""""
" MAPPINGS
""""""""""""""""

call MakePrefix('files', '<:prefix>f')
call MakePrefix('files', '<:files>f', 1)

" flat
nnoremap <:files>s :Unite -buffer-name=files directory file file/new directory/new<cr>
nnoremap <:files>S :UniteWithBufferDir -buffer-name=files directory file file/new directory/new<cr>

" recursive
if has('nvim')
	nnoremap <:files>r :Unite              -buffer-name=files -start-insert file_rec/neovim:!<cr>
	nnoremap <:files>R :UniteWithBufferDir -buffer-name=files -start-insert file_rec/neovim:!<cr>
else
	nnoremap <:files>r :Unite              -buffer-name=files -start-insert file_rec/async:!<cr>
	nnoremap <:files>R :UniteWithBufferDir -buffer-name=files -start-insert file_rec/async:!<cr>
endif

" git
nnoremap <:files>g :Unite              -buffer-name=files -start-insert file_rec/git:--cached:--others:--exclude-standard<cr>
nnoremap <:files>G :UniteWithBufferDir -buffer-name=files -start-insert file_rec/git:--cached:--others:--exclude-standard<cr>

" most recently used (mru) files
nnoremap <:files>m :Unite              -buffer-name=recent file_mru<cr>
nnoremap <:files>M :UniteWithBufferDir -buffer-name=recent file_mru<cr>
nnoremap <:files:1>m :Unite              -buffer-name=recent -silent -force-immediately file_mru:UniteFirst<cr>
nnoremap <:files:1>M :UniteWithBufferDir -buffer-name=recent -silent -force-immediately file_mru<cr>
