local telescope = require("telescope.builtin")
local actions = require("telescope.actions")

require("telescope").setup{
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
	},
	pickers = {
		find_files = {
			find_command = { "fd", "--type", "file", "--hidden", "--strip-cwd-prefix" },
		},
	},
}

-- prefix
vim.keymap.set("n", "<space>T", "<plug><telescope>", { silent = true })

vim.keymap.set("n", "<plug><telescope><space>", telescope.builtin, { silent = true })
