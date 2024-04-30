local gitsigns = require("gitsigns")

--
-- SETUP
--

gitsigns.setup()

--
-- SETUP
--

vim.keymap.set("n", "[h", function()
	if vim.wo.diff then
		vim.cmd.normal({'[h', bang = true})
	else
		gitsigns.nav_hunk('prev')
	end
end, { silent = true })

vim.keymap.set("n", "]h", function()
	if vim.wo.diff then
		vim.cmd.normal({']h', bang = true})
	else
		gitsigns.nav_hunk('next')
	end
end, { silent = true })
