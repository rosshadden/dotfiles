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
	\ 'split': 0,
	\ 'start_insert': 0,
	\ 'auto_preview': 0,
	\ 'vertical_preview': 0,
\ })


""""""""""""""""
" EXTERNAL
""""""""""""""""

if executable('ag')
	" ag > ack
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--hidden --vimgrep'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_rec_async_command = ['ag', '--follow', '--hidden', '--nocolor', '--nogroup', '--ignore', '.git', '-g', '']
elseif executable('ack')
	" ack >> grep
	let g:unite_source_grep_command = 'ack'
	let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
	let g:unite_source_grep_recursive_opt = ''
	let g:unite_source_rec_async_command = ['ack', '-f', '--nofilter']
endif


""""""""""""""""
" ACTIONS
""""""""""""""""

function! s:uniteSettings()
	" RESET

	nunmap <buffer> <space>
	nunmap <buffer> <c-h>
	nunmap <buffer> <c-l>
	nunmap <buffer> <c-k>
	iunmap <buffer> <c-h>
	iunmap <buffer> <c-l>

	" PROMPT

	" append to prompt
	nmap <buffer><expr> a unite#smart_map('a', '<plug>(unite_append_enter)')

	" LIST

	" go back
	nmap <buffer><expr> <bs> unite#smart_map('<bs>', '<plug>(unite_exit)')
	nmap <buffer><expr> h unite#smart_map('h', '<plug>(unite_exit)')
	imap <buffer><expr> h unite#smart_map('h', '<plug>(unite_exit)')
	nmap <buffer><expr> H unite#smart_map('H', '<plug>(unite_exit_all)')
	imap <buffer><expr> H unite#smart_map('H', '<plug>(unite_exit_all)')

	" select next/previous lines just like insert mode
	nmap <buffer> <c-n> <plug>(unite_loop_cursor_down)
	nmap <buffer> <c-p> <plug>(unite_loop_cursor_up)

	" toggle previews
	nnoremap <buffer><expr> p unite#smart_map('p', unite#do_action('preview'))
	inoremap <buffer><expr> p unite#smart_map('p', unite#do_action('preview'))
	nmap <buffer><expr> P unite#smart_map('P', 'p<plug>(unite_toggle_auto_preview)')
	imap <buffer><expr> P unite#smart_map('P', 'p<plug>(unite_toggle_auto_preview)')

	" CANDIDATES

	" select
	nmap <buffer><expr> t unite#smart_map('t', '<plug>(unite_toggle_mark_current_candidate)')
	imap <buffer><expr> t unite#smart_map('t', '<plug>(unite_toggle_mark_current_candidate)')
	nmap <buffer><expr> T unite#smart_map('T', '<plug>(unite_toggle_mark_current_candidate_up)')
	imap <buffer><expr> T unite#smart_map('T', '<plug>(unite_toggle_mark_current_candidate_up)')
	vmap <buffer> t <plug>(unite_toggle_mark_selected_candidates)

	" quick match
	nmap <buffer> x <plug>(unite_quick_match_jump)
	imap <buffer><expr> x unite#smart_map('x', '<plug>(unite_quick_match_jump)')

	let unite = unite#get_current_unite()
	if unite.profile_name ==# 'search'
		nnoremap <silent><buffer><expr> r unite#smart_map('r', unite#do_action('replace'))
	else
		nnoremap <silent><buffer><expr> r unite#smart_map('r', unite#do_action('rename'))
	endif

	" OPEN

	" default
	nnoremap <buffer><expr> l unite#smart_map('l', unite#do_action('default'))
	inoremap <buffer><expr> l unite#smart_map('l', unite#do_action('default'))

	" choose
	nnoremap <buffer><expr> oc unite#do_action('choose')

	" open without closing unite
	nnoremap <buffer><expr> op unite#do_action('persist_open')

	" open in new tab
	nnoremap <buffer><expr> ot unite#do_action('tabopen')

	" open in horizontal split
	nnoremap <buffer><expr> os unite#do_action('vsplit')
	nnoremap <buffer><expr> ol unite#do_action('right')
	nnoremap <buffer><expr> oh unite#do_action('left')

	" open in vertical split
	nnoremap <buffer><expr> o- unite#do_action('split')
	nnoremap <buffer><expr> oj unite#do_action('below')
	nnoremap <buffer><expr> ok unite#do_action('above')

	" open or switch to existing
	nnoremap <buffer><expr> o<space>c unite#do_action('switch')
	nnoremap <buffer><expr> o<space>t unite#do_action('tabswitch')
	nnoremap <buffer><expr> o<space>s unite#do_action('vsplitswitch')
	nnoremap <buffer><expr> o<space>- unite#do_action('splitswitch')

	" open `vimfiler`
	nnoremap <buffer><expr> of unite#do_action('vimfiler')
	nnoremap <buffer><expr> oF unite#do_action('tabvimfiler')

	" SETTINGS

	" toggle fuzzy matching
	" TODO: does not work
	nnoremap <buffer><expr> cof unite#mappings#set_current_matchers(
		\ empty(unite#mappings#get_current_matchers())
		\ ? ['matcher_fuzzy']
		\ : []
	\ )
endfunction

augroup unite
	autocmd!
	autocmd FileType unite call s:uniteSettings()
augroup END


""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('unite', '<:prefix>u')
call MakePrefix('unite', '<:unite>u', 1)

" current file
	call unite#custom#profile('outline', 'context', {
		\ 'auto_preview': 1,
	\ })

	" outline
	nnoremap <:unite>o :Unite               -buffer-name=outline outline<cr>
	nnoremap <:unite>O :UniteWithCursorWord -buffer-name=outline outline<cr>

	" line
	call unite#custom#profile('line', 'context', {
		\ 'auto_preview': 1,
		\ 'split': 0,
	\ })
	nnoremap <:unite>l :Unite               -buffer-name=line line<cr>
	nnoremap <:unite>L :UniteWithCursorWord -buffer-name=line line<cr>

	" changes
	call unite#custom#profile('changes', 'context', {
		\ 'auto_preview': 1,
		\ 'split': 0,
	\ })
	nnoremap <:unite>k :Unite               -buffer-name=changes change<cr>
	nnoremap <:unite>K :UniteWithCursorWord -buffer-name=changes change<cr>

	" jump list
	call unite#custom#profile('jump', 'context', {
		\ 'auto_preview': 1,
		\ 'split': 0,
	\ })
	nnoremap <:unite>j :Unite               -buffer-name=jump jump<cr>
	nnoremap <:unite>J :UniteWithCursorWord -buffer-name=jump jump<cr>

	" spelling
	call unite#custom#profile('spelling', 'context', {
		\ 'auto_preview': 1,
	\ })
	nnoremap <:unite>s :Unite               -buffer-name=spelling spell_suggest<cr>
	nnoremap <:unite:1>s :Unite               -buffer-name=spelling -force-immediately spell_suggest<cr>

" search files
	call unite#custom#profile('find', 'context', {
		\ 'empty': 0,
	\ })
	nnoremap <:unite>g :Unite              -buffer-name=find grep:.<cr>
	nnoremap <:unite>G :UniteWithBufferDir -buffer-name=find grep:.<cr>

" do all the things
nnoremap <:unite><cr> :Unite -buffer-name=omni source<cr>

" resume last buffer
nnoremap <:unite>. :UniteResume -no-start-insert -vertical-preview<cr>

" metavim
	" mappings
	nnoremap <:unite>m :Unite mapping<cr>

" external
	" exit
	nnoremap <:unite>x :Unite -default-action=sigterm process<cr>
	nnoremap <:unite>X :Unite -default-action=sigkill process<cr>
	nnoremap <:unite:1>x :Unite -default-action=sigint  process<cr>
