" take me to your leader
" for single letter mappings
let mapleader=','
call MakePrefix('leader', '<leader>')
call MakePrefix('leader', '<:leader><leader>', 1)

" localleader
" for filetype-specific mappings
let maplocalleader='_'
call MakePrefix('localleader', '<localleader>')
call MakePrefix('localleader', '<:localleader><localleader>', 1)

" prefix
" for grouped/corded mappings
call MakePrefix('prefix', '<space>')
call MakePrefix('prefix', '<:prefix><space>', 1)

" reset prefixes, and then escape like normal
" execute 'noremap <esc> ' . PressPrefix('')
