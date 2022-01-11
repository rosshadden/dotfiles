--
-- SETTINGS
--

vim.opt.termguicolors = true

vim.cmd "colorscheme base16-paraiso"

-- TODO: slow as hell
-- require("mini.starter").setup()

--
-- FUNCTIONS
--

-- highlight on yank
vim.cmd [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
]]
