local group = vim.api.nvim_create_augroup("templates", {})

vim.api.nvim_create_autocmd("BufNewFile", {
	group = group,
	pattern = "*.sh",
	command = [[
		0r ~/.vim/templates/template.sh | normal Gdd
	]],
})

vim.api.nvim_create_autocmd("BufNewFile", {
	group = group,
	pattern = "*.html",
	command = [[
		0r ~/.vim/templates/template.html | normal Gdd10G
	]],
})
