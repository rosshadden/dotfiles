--
-- SETTINGS
--

-- spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- disable word wrap
vim.opt.wrap = false

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>S", "<plug><surround>", { silent = true })

--
-- PLUGINS
--

-- require("mini.pairs").setup()

require("mini.surround").setup {
	mappings = {
		add = "s",
		delete = "ds",
		replace = "cs",
		find = "<plug><surround>l",
		find_left = "<plug><surround>h",
		highlight = "<plug><surround><space>",
		update_n_lines = "<plug><surround>c",
	}
}
