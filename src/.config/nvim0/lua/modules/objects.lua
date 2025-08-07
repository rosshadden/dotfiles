local spider = require("spider")

--
-- SETUP
--

require("mini.bracketed").setup()
require("mini.extra").setup()
require("mini.indentscope").setup()
require("mini.splitjoin").setup()

require("mini.operators").setup({
	replace = {
		prefix = 'g.',
	},
})

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

-- spider

-- prefix
vim.keymap.set("n", "<space>s", "<plug><spider>", { silent = true })

vim.keymap.set({ "n", "o", "x" }, "<plug><spider>w", function() spider.motion("w") end, { silent = true })
vim.keymap.set({ "n", "o", "x" }, "<plug><spider>b", function() spider.motion("b") end, { silent = true })
vim.keymap.set({ "n", "o", "x" }, "<plug><spider>e", function() spider.motion("e") end, { silent = true })
