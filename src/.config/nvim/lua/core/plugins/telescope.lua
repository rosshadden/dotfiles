local telescope = require("telescope.builtin")
local actions = require("telescope.actions")

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>T", "<plug><telescope>", { silent = true })

vim.keymap.set("n", "<plug><telescope><space>", telescope.builtin, { silent = true })

--
-- SETUP
--

require("telescope").setup {
	defaults = {
		mappings = {
			n = {
				q = actions.close,
			},
			i = {
				["<a-n>"] = actions.cycle_history_next,
				["<a-p>"] = actions.cycle_history_prev,
				["<c-j>"] = actions.select_horizontal,
				["<c-k>"] = actions.select_horizontal,
				["<c-h>"] = actions.select_vertical,
				["<c-l>"] = actions.select_vertical,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden", -- added
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
}

