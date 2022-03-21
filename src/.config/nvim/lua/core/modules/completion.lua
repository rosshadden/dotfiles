local cmp = require "cmp"

--
-- SETTINGS
--

vim.opt.completeopt = { "menu", "menuone", "preview", "noselect", "noinsert", }

-- vim-vsnip
vim.g.vsnip_snippet_dir = "~/.config/nvim/snippets"

--
-- FUNCTIONS
--

local hasPriorWords = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

--
-- MAPPINGS
--

-- vim.keymap.set({ "i", "s" }, "<c-s>", [[vsnip#available(1) ? "<plug>(vsnip-expand-or-jump)" : "<c-s>"]], { silent = true, expr = true })

--
-- PLUGINS
--

-- generic completion
cmp.setup({
	-- completion = { autocomplete = false, },
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	experimental = {
		ghost_text = true,
		-- NOTE: cmp-cmdline has a weird bug, so this bypasses it for now
		view = { entries = "native" },
	},

	mapping = {
		["<a-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", }),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),

		["<c-s>"] = cmp.mapping(function(fallback)
			if vim.fn["vsnip#available"](1) == 1 then
				feedkey("<plug>(vsnip-expand-or-jump)", "")
			else
				fallback()
			end
		end, { "i", "s" }),

		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif hasPriorWords() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<s-tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, { "i", "s" }),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
	}, {
		{ name = "neorg" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "path" },
		{ name = "emoji" },
	}),
})

-- search completion
cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})

-- command completion
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
