augroup javascript
	" insert debugger
	autocmd FileType javascript
		\ nmap <localleader>d o<esc>cc<esc>Idebugger;<esc>
	autocmd FileType javascript
		\ nmap <localleader>D O<esc>cc<esc>Idebugger;<esc>


	" insert section comment
	autocmd FileType javascript
		\ nmap <localleader>cs o////////////////<esc>yypO// <esc>
augroup END
