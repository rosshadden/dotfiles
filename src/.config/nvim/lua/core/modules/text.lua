--
-- SETTINGS
--

-- spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- disable word wrap
vim.opt.wrap = false

--
-- PLUGINS
--

-- require("mini.pairs").setup()

require("mini.surround").setup {
	mappings = {
		add = "s",
		delete = "ds",
		replace = "cs",
	}
}
