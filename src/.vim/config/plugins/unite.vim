""""""""""""""""
" SETTINGS
""""""""""""""""

let g:unite_source_history_yank_enable = 1
let g:unite_force_overwrite_statusline = 0
let g:unite_matcher_fuzzy_max_input_length = 32

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('buffer,file,file_rec,file_rec/async', 'sorters', ['sorter_selecta'])
call unite#custom#source('file_rec,file_rec/async', 'ignore_globs', split(&wildignore, ','))
call unite#custom#source('file_rec,file_rec/async', 'converters', [])
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 32)
" prettier output
call unite#custom#source('buffer', 'converters', ['converter_file_directory'])

call unite#custom#profile('default', 'context', {
	\ 'winheight': 20,
	\ 'start_insert': 1,
	\ 'auto_preview': 0,
	\ 'vertical_preview': 1,
\ })


""""""""""""""""
" EXTERNAL
""""""""""""""""

" ack >> grep
if executable('ack')
	let g:unite_source_grep_command = 'ack'
	let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
	let g:unite_source_grep_recursive_opt = ''
endif

" ag > ack
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --column'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_rec_async_command = 'ag --nocolor --nogroup --hidden --follow --ignore ".git" -g ""'
endif


""""""""""""""""
" ACTIONS
""""""""""""""""

function! s:uniteSettings()
	" always make `a` append to prompt
	map <buffer> a <plug>(unite_append_enter)

	" [s] open in horizontal split
	map <buffer><expr> s unite#do_action('vsplit')
	map <buffer><expr> <c-s> unite#do_action('vsplit')
	imap <buffer><expr> <c-s> unite#do_action('vsplit')
	" [-] open in vertical split
	map <buffer><expr> - unite#do_action('split')
	map <buffer><expr>  unite#do_action('split')
	imap <buffer><expr>  unite#do_action('split')
	" [t] open in new tab (`t` is default in normal mode)
	map <buffer><expr> <c-t> unite#do_action('tabopen')
	imap <buffer><expr> <c-t> unite#do_action('tabopen')

	" select next/previous lines just like insert mode
	nmap <buffer> <c-n> <plug>(unite_loop_cursor_down)
	nmap <buffer> <c-p> <plug>(unite_loop_cursor_up)

	" toggle auto preview
	map <buffer> P p<plug>(unite_toggle_auto_preview)

	let unite = unite#get_current_unite()
	if unite.profile_name ==# 'search'
		nmap <silent><buffer><expr> r unite#do_action('replace')
	else
		nmap <silent><buffer><expr> r unite#do_action('rename')
	endif
endfunction
autocmd FileType unite call s:uniteSettings()


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('unite', '[prefix]u')
call MakePrefix('unite', '[unite]u', 1)

" open files
	call unite#custom#profile('files', 'context', {
		\ 'unique': 1,
		\ 'candidate_icon': '>',
	\ })

	" flat
	nmap [unite:0]f :Unite -buffer-name=files -no-split directory file file/new directory/new<cr>
	nmap [unite:0]F :UniteWithBufferDir -buffer-name=files -no-split directory file file/new directory/new<cr>
	nmap [unite:1]f :Unite -buffer-name=files -no-vertical-preview directory file file/new directory/new<cr>
	nmap [unite:1]F :UniteWithBufferDir -buffer-name=files -no-vertical-preview directory file file/new directory/new<cr>
	vmap [unite:0]f :<c-u>execute ':Unite -buffer-name=files -no-split directory file file/new directory/new -input=' . GetVisualSelection()<cr>
	vmap [unite:0]F :<c-u>execute ':UniteWithBufferDir -buffer-name=files -no-split directory file file/new directory/new -input=' . GetVisualSelection()<cr>
	vmap [unite:1]f :<c-u>execute ':Unite -buffer-name=files -no-vertical-preview directory file file/new directory/new -input=' . GetVisualSelection()<cr>
	vmap [unite:1]F :<c-u>execute ':UniteWithBufferDir -buffer-name=files -no-vertical-preview directory file file/new directory/new -input=' . GetVisualSelection()<cr>

	" recursive
	nmap [unite:0]p :Unite              -buffer-name=files -no-split file_rec/async:!<cr>
	nmap [unite:0]P :UniteWithBufferDir -buffer-name=files -no-split file_rec/async:!<cr>
	nmap [unite:1]p :Unite              -buffer-name=files -no-vertical-preview file_rec/async:!<cr>
	nmap [unite:1]P :UniteWithBufferDir -buffer-name=files -no-vertical-preview file_rec/async:!<cr>
	vmap [unite:0]p :<c-u>execute ':Unite              -buffer-name=files -no-split file_rec/async -input=' . GetVisualSelection():!<cr>
	vmap [unite:0]P :<c-u>execute ':UniteWithBufferDir -buffer-name=files -no-split file_rec/async -input=' . GetVisualSelection():!<cr>
	vmap [unite:1]p :<c-u>execute ':Unite              -buffer-name=files -no-vertical-preview file_rec/async -input=' . GetVisualSelection():!<cr>
	vmap [unite:1]P :<c-u>execute ':UniteWithBufferDir -buffer-name=files -no-vertical-preview file_rec/async -input=' . GetVisualSelection():!<cr>

" current and recent
	" most recently used (mru) files
	nmap [unite:0]r :Unite              -buffer-name=recent -no-split file_mru<cr>
	nmap [unite:0]R :UniteWithBufferDir -buffer-name=recent -no-split file_mru<cr>
	nmap [unite:1]r :Unite              -buffer-name=recent -no-vertical-preview file_mru<cr>
	nmap [unite:1]R :UniteWithBufferDir -buffer-name=recent -no-vertical-preview file_mru<cr>
	vmap [unite:0]r :<c-u>execute ':Unite              -buffer-name=recent -no-split file_mru -input=' . GetVisualSelection()<cr>
	vmap [unite:0]R :<c-u>execute ':UniteWithBufferDir -buffer-name=recent -no-split file_mru -input=' . GetVisualSelection()<cr>
	vmap [unite:1]r :<c-u>execute ':Unite              -buffer-name=recent -no-vertical-preview file_mru -input=' . GetVisualSelection()<cr>
	vmap [unite:1]R :<c-u>execute ':UniteWithBufferDir -buffer-name=recent -no-vertical-preview file_mru -input=' . GetVisualSelection()<cr>

	" current buffers
	nmap [unite:0]b :Unite              -buffer-name=buffers -no-split buffer<cr>
	nmap [unite:0]B :UniteWithBufferDir -buffer-name=buffers -no-split buffer<cr>
	nmap [unite:1]b :Unite              -buffer-name=buffers -no-vertical-preview buffer<cr>
	nmap [unite:1]B :UniteWithBufferDir -buffer-name=buffers -no-vertical-preview buffer<cr>
	vmap [unite:0]b :<c-u>execute ':Unite              -buffer-name=buffers -no-split buffer -input=' . GetVisualSelection()<cr>
	vmap [unite:0]B :<c-u>execute ':UniteWithBufferDir -buffer-name=buffers -no-split buffer -input=' . GetVisualSelection()<cr>
	vmap [unite:1]b :<c-u>execute ':Unite              -buffer-name=buffers -no-vertical-preview buffer -input=' . GetVisualSelection()<cr>
	vmap [unite:1]B :<c-u>execute ':UniteWithBufferDir -buffer-name=buffers -no-vertical-preview buffer -input=' . GetVisualSelection()<cr>

	" current... tabs? buffers?
	nmap [unite:0]t :Unite              -buffer-name=buffers -no-split tab buffer_tab<cr>
	nmap [unite:0]T :UniteWithBufferDir -buffer-name=buffers -no-split tab buffer_tab<cr>
	nmap [unite:1]t :Unite              -buffer-name=buffers -no-vertical-preview tab buffer_tab<cr>
	nmap [unite:1]T :UniteWithBufferDir -buffer-name=buffers -no-vertical-preview tab buffer_tab<cr>
	vmap [unite:0]t :<c-u>execute ':Unite              -buffer-name=buffers -no-split tab buffer_tab -input=' . GetVisualSelection()<cr>
	vmap [unite:0]T :<c-u>execute ':UniteWithBufferDir -buffer-name=buffers -no-split tab buffer_tab -input=' . GetVisualSelection()<cr>
	vmap [unite:1]t :<c-u>execute ':Unite              -buffer-name=buffers -no-vertical-preview tab buffer_tab -input=' . GetVisualSelection()<cr>
	vmap [unite:1]T :<c-u>execute ':UniteWithBufferDir -buffer-name=buffers -no-vertical-preview tab buffer_tab -input=' . GetVisualSelection()<cr>

	" buffer, tab, or files
	nmap [unite:0]a :Unite              -no-split buffer tab file_mru directory_mru bookmark<cr>
	nmap [unite:0]A :UniteWithBufferDir -no-split buffer tab file_mru directory_mru bookmark<cr>
	nmap [unite:1]a :Unite              -no-vertical-preview buffer tab file_mru directory_mru bookmark<cr>
	nmap [unite:1]A :UniteWithBufferDir -no-vertical-preview buffer tab file_mru directory_mru bookmark<cr>
	vmap [unite:0]a :<c-u>execute ':Unite              -no-split buffer tab file_mru directory_mru bookmark -input=' . GetVisualSelection()<cr>
	vmap [unite:0]A :<c-u>execute ':UniteWithBufferDir -no-split buffer tab file_mru directory_mru bookmark -input=' . GetVisualSelection()<cr>
	vmap [unite:1]a :<c-u>execute ':Unite              -no-vertical-preview buffer tab file_mru directory_mru bookmark -input=' . GetVisualSelection()<cr>
	vmap [unite:1]A :<c-u>execute ':UniteWithBufferDir -no-vertical-preview buffer tab file_mru directory_mru bookmark -input=' . GetVisualSelection()<cr>

" current file
	call unite#custom#profile('outline', 'context', {
		\ 'start_insert': 1,
		\ 'auto_preview': 1,
	\ })

	" outline
	nmap [unite:0]o :Unite               -buffer-name=outline -no-split outline<cr>
	nmap [unite:0]O :UniteWithCursorWord -buffer-name=outline -no-split outline<cr>
	nmap [unite:1]o :Unite               -buffer-name=outline -no-vertical-preview outline<cr>
	nmap [unite:1]O :UniteWithCursorWord -buffer-name=outline -no-vertical-preview outline<cr>
	vmap [unite:0]o :<c-u>execute ':Unite               -buffer-name=outline -no-split outline -input=' . GetVisualSelection()<cr>
	vmap [unite:0]O :<c-u>execute ':UniteWithCursorWord -buffer-name=outline -no-split outline -input=' . GetVisualSelection()<cr>
	vmap [unite:1]o :<c-u>execute ':Unite               -buffer-name=outline -no-vertical-preview outline -input=' . GetVisualSelection()<cr>
	vmap [unite:1]O :<c-u>execute ':UniteWithCursorWord -buffer-name=outline -no-vertical-preview outline -input=' . GetVisualSelection()<cr>

	" line
	call unite#custom#profile('line', 'context', {
		\ 'auto_preview': 1,
		\ 'split': 0,
	\ })
	nmap [unite:0]l :Unite               -buffer-name=line line<cr>
	nmap [unite:0]L :UniteWithCursorWord -buffer-name=line line<cr>
	vmap [unite:0]l :<c-u>execute ':Unite               -buffer-name=line line -input=' . GetVisualSelection()<cr>
	vmap [unite:0]L :<c-u>execute ':UniteWithCursorWord -buffer-name=line line -input=' . GetVisualSelection()<cr>

	" changes
	call unite#custom#profile('changes', 'context', {
		\ 'auto_preview': 1,
		\ 'split': 0,
		\ 'start_insert': 0,
	\ })
	nmap [unite:0]k :Unite               -buffer-name=changes change<cr>
	nmap [unite:0]K :UniteWithCursorWord -buffer-name=changes change<cr>
	vmap [unite:0]k :<c-u>execute ':Unite               -buffer-name=changes change -input=' . GetVisualSelection()<cr>
	vmap [unite:0]K :<c-u>execute ':UniteWithCursorWord -buffer-name=changes change -input=' . GetVisualSelection()<cr>

	" jump list
	call unite#custom#profile('jump', 'context', {
		\ 'auto_preview': 1,
		\ 'split': 0,
		\ 'start_insert': 0,
	\ })
	nmap [unite:0]j :Unite               -buffer-name=jump jump<cr>
	nmap [unite:0]J :UniteWithCursorWord -buffer-name=jump jump<cr>
	vmap [unite:0]j :<c-u>execute ':Unite               -buffer-name=jump jump -input=' . GetVisualSelection()<cr>
	vmap [unite:0]J :<c-u>execute ':UniteWithCursorWord -buffer-name=jump jump -input=' . GetVisualSelection()<cr>

	" spelling
	call unite#custom#profile('spelling', 'context', {
		\ 'auto_preview': 1,
		\ 'start_insert': 0,
	\ })
	nmap [unite:0]s :Unite               -buffer-name=spelling spell_suggest<cr>
	nmap [unite:0]S :UniteWithCursorWord -buffer-name=spelling spell_suggest<cr>
	nmap [unite:1]s :Unite               -buffer-name=spelling -force-immediately spell_suggest<cr>
	nmap [unite:1]S :UniteWithCursorWord -buffer-name=spelling -force-immediately spell_suggest<cr>
	vmap [unite:0]s :<c-u>execute ':Unite               -buffer-name=spelling spell_suggest -input=' . GetVisualSelection()<cr>
	vmap [unite:0]S :<c-u>execute ':UniteWithCursorWord -buffer-name=spelling spell_suggest -input=' . GetVisualSelection()<cr>

" search files
	call unite#custom#profile('find', 'context', {
		\ 'start_insert': 0,
		\ 'empty': 0,
	\ })
	nmap [unite:0]g :Unite              -buffer-name=find -no-split grep:.<cr>
	nmap [unite:0]G :UniteWithBufferDir -buffer-name=find -no-split grep:.<cr>
	nmap [unite:1]g :Unite              -buffer-name=find -no-vertical-preview grep<cr>
	nmap [unite:1]G :UniteWithBufferDir -buffer-name=find -no-vertical-preview grep<cr>
	vmap [unite:0]g :<c-u>execute ':Unite              -buffer-name=find -no-split grep:. -input=' . GetVisualSelection()<cr>
	vmap [unite:0]G :<c-u>execute ':UniteWithBufferDir -buffer-name=find -no-split grep:. -input=' . GetVisualSelection()<cr>
	vmap [unite:1]g :<c-u>execute ':Unite              -buffer-name=find -no-vertical-preview grep -input=' . GetVisualSelection()<cr>
	vmap [unite:1]G :<c-u>execute ':UniteWithBufferDir -buffer-name=find -no-vertical-preview grep -input=' . GetVisualSelection()<cr>

" do all the things
nmap [unite:0]<cr> :Unite -buffer-name=omni -no-split source<cr>
vmap [unite:0]<cr> :<c-u>execute ':Unite -buffer-name=omni -no-split source -input=' . GetVisualSelection()<cr>
nmap [unite:1]<cr> :Unite -buffer-name=omni -no-vertical-preview source<cr>
vmap [unite:1]<cr> :<c-u>execute ':Unite -buffer-name=omni -no-vertical-preview source -input=' . GetVisualSelection()<cr>

" vim
	" yank stack
	call unite#custom#profile('yank', 'context', {
		\ 'start_insert': 0,
	\ })
	nmap [unite:0]y :Unite -buffer-name=yank -no-split history/yank<cr>
	vmap [unite:0]y :<c-u>execute ':Unite -buffer-name=yank -no-split history/yank -input=' . GetVisualSelection()<cr>
	nmap [unite:1]y :Unite -buffer-name=yank -no-vertical-preview history/yank<cr>
	vmap [unite:1]y :<c-u>execute ':Unite -buffer-name=yank -no-vertical-preview history/yank -input=' . GetVisualSelection()<cr>

	" command history
	call unite#custom#profile('commands', 'context', {
		\ 'start_insert': 0,
	\ })
	nmap [unite:0]; :Unite -buffer-name=commands -default-action=execute history/command command<cr>
	vmap [unite:0]; :<c-u>execute ':Unite -buffer-name=commands -default-action=execute history/command command -input=' . GetVisualSelection()<cr>
	nmap [unite:1]; :Unite -buffer-name=commands -default-action=edit history/command command<cr>
	vmap [unite:1]; :<c-u>execute ':Unite -buffer-name=commands -default-action=edit history/command command -input=' . GetVisualSelection()<cr>

" resume last buffer
nmap [unite:0]. :UniteResume -no-start-insert -no-split -vertical-preview<cr>
vmap [unite:0]. :<c-u>execute ':UniteResume -no-start-insert -no-split -vertical-preview -input=' . GetVisualSelection()<cr>
nmap [unite:1]. :UniteResume -no-start-insert -split -no-vertical-preview<cr>
vmap [unite:1]. :<c-u>execute ':UniteResume -no-start-insert -no-vertical-preview -input=' . GetVisualSelection()<cr>

" metavim
	" mappings
	nmap [unite:0]m :Unite -no-split mapping<cr>
	vmap [unite:0]m :<c-u>execute ':Unite -no-split mapping -input=' . GetVisualSelection()<cr>
	nmap [unite:1]m :Unite mapping<cr>
	vmap [unite:1]m :<c-u>execute ':Unite mapping -input=' . GetVisualSelection()<cr>

" external
	" exit
	nmap [unite:0]x :Unite -default-action=sigterm process<cr>
	nmap [unite:0]X :Unite -default-action=sigkill process<cr>
	nmap [unite:1]x :Unite -default-action=sigint  process<cr>
	vmap [unite:0]x :<c-u>execute ':Unite -default-action=sigterm process -input=' . GetVisualSelection()<cr>
	vmap [unite:0]X :<c-u>execute ':Unite -default-action=sigkill process -input=' . GetVisualSelection()<cr>
	vmap [unite:1]x :<c-u>execute ':Unite -default-action=sigint  process -input=' . GetVisualSelection()<cr>
