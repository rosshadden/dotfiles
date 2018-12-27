""""""""""""""""
" SETTINGS
""""""""""""""""

let g:polyglot_disabled = [ 'javascript', 'markdown', 'nim', 'typescript' ]

" TODO: move to clojure file
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
