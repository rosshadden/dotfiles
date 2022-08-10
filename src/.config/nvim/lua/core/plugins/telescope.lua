local ts = require("telescope")
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

ts.setup {
	defaults = {
		mappings = {
			n = {
				["<c-c>"] = actions.close,
				["q"] = actions.close,
			},
			i = {
				["<a-n>"] = actions.cycle_history_next,
				["<a-p>"] = actions.cycle_history_prev,
				["<a-t>"] = actions.select_tab,
				["<a-h>"] = actions.select_vertical,
				["<a-j>"] = actions.select_horizontal,
				["<a-k>"] = actions.select_horizontal,
				["<a-l>"] = actions.select_vertical,
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
			find_command = { "fd", "-H" },
		},
	},
}

ts.load_extension("fzf")
