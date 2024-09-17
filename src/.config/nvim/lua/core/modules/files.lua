local lf = require("lf")
local mini_files = require("mini.files")
local mini_pick = require("mini.pick")
local telescope = require("telescope.builtin")

--
-- SETUP
--

mini_files.setup()
mini_pick.setup()

lf.setup {
	border = "rounded",
	default_actions = {
		["<a-l>"] = "vsplit",
		["<a-h>"] = "vsplit",
		["<a-j>"] = "split",
		["<a-k>"] = "split",
		["<a-t>"] = "tab drop",
	},
}

--
-- MAPPINGS
--

-- prefix
vim.keymap.set("n", "<space>f", "<plug><files>", { silent = true })

-- open file browser at file's cwd
vim.keymap.set("n", "<plug><files><space>", function()
	lf.start()
end, { silent = true })
-- open file browser at git root dir
vim.keymap.set("n", "<plug><files><a-space>", function()
	lf.start({ dir = "gwd" })
end, { silent = true })

-- pick
vim.keymap.set("n", "<plug><files><tab>", function()
	mini_files.open()
end, { silent = true })

-- choose
vim.keymap.set("n", "<plug><files>c", telescope.find_files, { silent = true })

-- git
vim.keymap.set("n", "<plug><files>g", telescope.git_files, { silent = true })

-- search
vim.keymap.set("n", "<plug><files>s", telescope.live_grep, { silent = true })
