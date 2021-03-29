""""""""""""""""
" SETTINGS
""""""""""""""""

let g:vimspector_enable_mappings = 'HUMAN'

""""""""""""""""
" MAPPINGS
""""""""""""""""

" prefix
call MakePrefix('debug', '<:prefix>G')

" inspect
" the word under the cursor
nmap <:debug>i <Plug>VimspectorBalloonEval
" the visually selected text
xmap <:debug>i <Plug>VimspectorBalloonEval

" navigate the stack
nmap <:debug>k <Plug>VimspectorUpFrame
nmap <:debug>j <Plug>VimspectorDownFrame

" connect
nmap <:debug>c :call vimspector#Launch()<cr>
