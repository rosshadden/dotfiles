augroup templates
	autocmd BufNewFile *.sh 0r ~/.vim/templates/template.sh | normal Gdd
	autocmd BufNewFile *.html 0r ~/.vim/templates/template.html | normal Gdd10G
augroup END
