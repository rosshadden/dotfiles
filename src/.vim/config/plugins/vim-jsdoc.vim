let g:jsdoc_allow_input_prompt      = 1 " 0
let g:jsdoc_input_description       = 1 " 1
let g:jsdoc_additional_descriptions = 0 " 0
let g:jsdoc_return                  = 1 " 1
let g:jsdoc_return_type             = 1 " 1
let g:jsdoc_return_description      = 1 " 1
let g:jsdoc_default_mapping         = 0 " 1

autocmd FileType javascript
	\ nmap <silent> <localleader>C <plug>(jsdoc)
