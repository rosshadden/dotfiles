" use custom snippets
let g:neosnippet#snippets_directory = g:configDir . '/snippets'

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

nmap <c-s> i<plug>(neosnippet_expand_or_jump)<esc>
imap <c-s> <plug>(neosnippet_expand_or_jump)
smap <c-s> <plug>(neosnippet_expand_or_jump)
xmap <c-s> <plug>(neosnippet_expand_target)
