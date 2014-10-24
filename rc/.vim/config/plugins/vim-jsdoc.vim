let g:jsdoc_default_mapping = 0
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_additional_descriptions = 1

autocmd FileType javascript
	\ nmap <silent> <localleader>d <plug>(jsdoc)
