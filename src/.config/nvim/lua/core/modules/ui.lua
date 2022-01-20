--
-- SETTINGS
--

-- line numbers
vim.opt.number = true

-- colorscheme
require("base16-colorscheme").setup("paraiso")

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
