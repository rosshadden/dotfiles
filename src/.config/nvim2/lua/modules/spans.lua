local mini_extra = require "mini.extra"

--
-- SETUP
--

require "mini.indentscope".setup()

require "mini.operators".setup({
	replace = {
		prefix = "g.",
	},
})

require "mini.ai".setup({
	custom_textobjects = {
		-- current line/row
		r = mini_extra.gen_ai_spec.line(),

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
