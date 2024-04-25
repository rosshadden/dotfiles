local polyword = require "polyword"

--
-- SETUP
--

require("mini.bracketed").setup()
require("mini.extra").setup()
require("mini.indentscope").setup()
require("mini.operators").setup()

require("mini.ai").setup({
	custom_textobjects = {
		-- current line/row
		r = MiniExtra.gen_ai_spec.line(),

		-- entire buffer
		e = function()
			local from = { line = 1, col = 1 }
			local to = {
				line = vim.fn.line('$'),
				col = math.max(vim.fn.getline('$'):len(), 1)
			}
			return { from = from, to = to, vis_mode = 'V' }
		end
	}
})

--
-- FUNCTIONS
--

local make_textobject = function(keys, fn)
	vim.keymap.set("x", keys, fn, { silent = true })
	vim.keymap.set("o", keys, function() vim.api.nvim_feedkeys("v" .. keys, "x", true) end, { silent = true })
end

--
-- MAPPINGS
--

-- polyword

-- prefix
vim.keymap.set("n", "<space>m", "<plug><polyword>", { silent = true })

-- miniword
vim.keymap.set("", "<plug><polyword>w", function() polyword.miniword("w") end, { silent = true })
vim.keymap.set("", "<plug><polyword>b", function() polyword.miniword("b") end, { silent = true })
vim.keymap.set("", "<plug><polyword>e", function() polyword.miniword("e") end, { silent = true })
vim.keymap.set("", "<plug><polyword>ge", function() polyword.miniword("ge") end, { silent = true })
vim.keymap.set("o", "im", function() polyword.miniword("iw") end, { silent = true })
vim.keymap.set("o", "am", function() polyword.miniword("aw") end, { silent = true })

-- megaword
vim.keymap.set("", "<plug><polyword>W", function() polyword.megaword("w") end, { silent = true })
vim.keymap.set("", "<plug><polyword>B", function() polyword.megaword("b") end, { silent = true })
vim.keymap.set("", "<plug><polyword>E", function() polyword.megaword("e") end, { silent = true })
vim.keymap.set("", "<plug><polyword>gE", function() polyword.megaword("ge") end, { silent = true })
vim.keymap.set("o", "iM", function() polyword.megaword("iw") end, { silent = true })
vim.keymap.set("o", "aM", function() polyword.megaword("aw") end, { silent = true })

-- transform
vim.keymap.set("", "<plug><polyword>c", function() polyword.transform("camel") end, { silent = true })
vim.keymap.set("", "<plug><polyword>C", function() polyword.transform("pascal") end, { silent = true })
vim.keymap.set("", "<plug><polyword>s", function() polyword.transform("snake") end, { silent = true })
vim.keymap.set("", "<plug><polyword>S", function() polyword.transform("snake-upper") end, { silent = true })
vim.keymap.set("", "<plug><polyword>k", function() polyword.transform("kebab") end, { silent = true })
vim.keymap.set("", "<plug><polyword>K", function() polyword.transform("kebab-upper") end, { silent = true })
