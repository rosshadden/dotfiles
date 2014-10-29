let g:unite_source_history_yank_enable = 1

" ack >> grep
if executable('ack')
	let g:unite_source_grep_command = 'ack'
	let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
	let g:unite_source_grep_recursive_opt = ''
endif

" ag > ack
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --hidden'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_rec_async_command = 'ag' .
		\ ' --follow' .
		\ ' --nocolor' .
		\ ' --nogroup' .
		\ ' --hidden' .
		\ ' --ignore ".git"' .
		\ ' -g ""'
endif

" setting `vertical-preview` here doesn't work for some reason
call unite#custom#profile('default', 'context', {
\   'winheight': 24,
\   'vertical-preview': 1,
\ })

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('buffer,file,file_rec,file_rec/async', 'sorters', ['sorter_length', 'sorter_rank'])
call unite#custom#source('file_rec,file_rec/async', 'ignore_globs', split(&wildignore, ','))
call unite#custom#source('file_rec,file_rec/async', 'converters', [])
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 24)
" prettier output
call unite#custom#source('buffer', 'converters', ['converter_file_directory'])

" in-buffer settings
function! s:uniteSettings()
	let b:SuperTabDisabled = 1

	" vertical selecting (`j` and `k` is default in normal mode)
	map <buffer> <c-j> <plug>(unite_select_next_line)
	imap <buffer> <c-j> <plug>(unite_select_next_line)
	map <buffer> <c-k> <plug>(unite_select_previous_line)
	imap <buffer> <c-k> <plug>(unite_select_previous_line)

	" action menu (`a` is default in normal mode)
	map <buffer> <c-a> <plug>(unite_choose_action)
	imap <buffer> <c-a> <plug>(unite_choose_action)
	" TODO: get something like this working: (may depend on https://github.com/Shougo/unite.vim/issues/280)
	vmap <buffer> a <plug>(unite_choose_action)

	" open in vertical split
	map <buffer><expr> - unite#do_action('split')
	map <buffer><expr>  unite#do_action('split')
	imap <buffer><expr>  unite#do_action('split')
	" open in horizontal split
	map <buffer><expr> s unite#do_action('vsplit')
	map <buffer><expr> <c-s> unite#do_action('vsplit')
	imap <buffer><expr> <c-s> unite#do_action('vsplit')
	" open in new tab (`t` is default in normal mode)
	map <buffer><expr> <c-t> unite#do_action('tabopen')
	imap <buffer><expr> <c-t> unite#do_action('tabopen')

	" toggle auto preview
	map <buffer> P <plug>(unite_toggle_auto_preview)
	map <buffer> <c-p> <plug>(unite_toggle_auto_preview)
	imap <buffer> <c-p> <plug>(unite_toggle_auto_preview)

	" exit
	nmap <buffer> <esc> <plug>(unite_exit)

	let unite = unite#get_current_unite()
	if unite.profile_name ==# 'search'
		nmap <silent><buffer><expr> r unite#do_action('replace')
	else
		nmap <silent><buffer><expr> r unite#do_action('rename')
	endif
endfunction
autocmd FileType unite call s:uniteSettings()

" prefix
call MakePrefix('unite', '[prefix]u')
call MakePrefix('unite', '[unite]u', 1)

" open files
	" flat
	nmap [unite:0]f :Unite              -buffer-name=files -vertical-preview -toggle -start-insert file directory file/new directory/new<cr>
	nmap [unite:0]F :UniteWithBufferDir -buffer-name=files -vertical-preview -toggle -start-insert file directory file/new directory/new<cr>
	nmap [unite:1]f :Unite              -buffer-name=files -vertical-preview -toggle -start-insert -no-split file directory file/new directory/new<cr>
	nmap [unite:1]F :UniteWithBufferDir -buffer-name=files -vertical-preview -toggle -start-insert -no-split file directory file/new directory/new<cr>

	" recursive
	nmap [unite:0]p :Unite              -buffer-name=files -vertical-preview -toggle -start-insert file_rec/async:!<cr>
	nmap [unite:0]P :UniteWithBufferDir -buffer-name=files -vertical-preview -toggle -start-insert file_rec/async:!<cr>
	nmap [unite:1]p :Unite              -buffer-name=files -vertical-preview -toggle -start-insert -no-split file_rec/async:!<cr>
	nmap [unite:1]P :UniteWithBufferDir -buffer-name=files -vertical-preview -toggle -start-insert -no-split file_rec/async:!<cr>

" current and recent
	" most recently used (mru) files
	nmap [unite:0]r :Unite              -buffer-name=recent -vertical-preview -start-insert -toggle file_mru<cr>
	nmap [unite:0]R :UniteWithBufferDir -buffer-name=recent -vertical-preview -start-insert -toggle file_mru<cr>
	nmap [unite:1]r :Unite              -buffer-name=recent -vertical-preview -start-insert -toggle -no-split file_mru<cr>
	nmap [unite:1]R :UniteWithBufferDir -buffer-name=recent -vertical-preview -start-insert -toggle -no-split file_mru<cr>

	" current buffers
	nmap [unite:0]b :Unite              -buffer-name=buffers -vertical-preview -start-insert -toggle buffer<cr>
	nmap [unite:0]B :UniteWithBufferDir -buffer-name=buffers -vertical-preview -start-insert -toggle buffer<cr>
	nmap [unite:1]b :Unite              -buffer-name=buffers -vertical-preview -start-insert -toggle -no-split buffer<cr>
	nmap [unite:1]B :UniteWithBufferDir -buffer-name=buffers -vertical-preview -start-insert -toggle -no-split buffer<cr>

	" buffer, tab, or files
	nmap [unite:0]a :Unite              -vertical-preview -start-insert buffer tab file_mru directory_mru bookmark<cr>
	nmap [unite:0]A :UniteWithBufferDir -vertical-preview -start-insert buffer tab file_mru directory_mru bookmark<cr>
	nmap [unite:1]a :Unite              -vertical-preview -start-insert -no-split buffer tab file_mru directory_mru bookmark<cr>
	nmap [unite:1]A :UniteWithBufferDir -vertical-preview -start-insert -no-split buffer tab file_mru directory_mru bookmark<cr>

" current file
	" outline
	nmap [unite:0]o :Unite               -buffer-name=outline -vertical-preview -toggle -no-split outline<cr>
	nmap [unite:0]O :UniteWithCursorWord -buffer-name=outline -vertical-preview -toggle -no-split outline<cr>
	nmap [unite:1]o :Unite               -buffer-name=outline -vertical-preview -toggle -no-split -no-split outline<cr>
	nmap [unite:1]O :UniteWithCursorWord -buffer-name=outline -vertical-preview -toggle -no-split -no-split outline<cr>

	" line
	nmap [unite:0]l :Unite               -buffer-name=search -vertical-preview -toggle -no-split -auto-preview -start-insert line<cr>
	nmap [unite:0]L :UniteWithCursorWord -buffer-name=search -vertical-preview -toggle -no-split -auto-preview -start-insert line<cr>

	" changes
	nmap [unite:0]k :Unite               -buffer-name=search -vertical-preview -toggle -no-split -auto-preview change<cr>
	nmap [unite:0]K :UniteWithCursorWord -buffer-name=search -vertical-preview -toggle -no-split -auto-preview change<cr>

" search files
	nmap [unite:0]g :Unite              -vertical-preview -no-empty grep:.<cr>
	nmap [unite:0]G :UniteWithBufferDir -vertical-preview -no-empty grep:.<cr>
	nmap [unite:1]g :Unite              -vertical-preview -no-empty -no-split grep:.<cr>
	nmap [unite:1]G :UniteWithBufferDir -vertical-preview -no-empty -no-split grep:.<cr>
	" TODO: get something like this working:
	" vmap [unite:0]g :UniteWithCursorWord grep:.<cr>

" do all the things
nmap [unite:0]<cr> :Unite -buffer-name=omni -vertical-preview -toggle -start-insert source<cr>
nmap [unite:1]<cr> :Unite -buffer-name=omni -vertical-preview -toggle -start-insert -no-split source<cr>

" yank stack
nmap [unite:0]y :Unite -buffer-name=yank -vertical-preview -toggle history/yank<cr>
nmap [unite:1]y :Unite -buffer-name=yank -vertical-preview -toggle -no-split history/yank<cr>

" command history
nmap [unite:0]; :Unite -buffer-name=commands -vertical-preview -toggle -default-action=execute history/command command<cr>
nmap [unite:1]; :Unite -buffer-name=commands -vertical-preview -toggle -default-action=edit history/command command<cr>

" repeat last entry
nmap [unite:0]. :UniteResume<cr>
nmap [unite:1]. :UniteResume -no-split<cr>

" metavim
	" mappings
	nmap [unite:0]m :Unite mapping<cr>

" external
	" exit
	nmap [unite:0]x :Unite -default-action=sigterm process<cr>
	nmap [unite:0]X :Unite -default-action=sigkill process<cr>
	nmap [unite:1]x :Unite -default-action=sigint  process<cr>
