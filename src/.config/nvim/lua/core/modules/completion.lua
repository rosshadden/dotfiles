local cmp = require "cmp"

vim.opt.completeopt = { "menu", "menuone", "preview", "noselect", "noinsert", }

local hasPriorWords = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- generic completion
cmp.setup({
	-- completion = { autocomplete = false, },
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	-- NOTE: cmp-cmdline has a weird bug, so this bypasses it for now
	experimental = {
		native_menu = true,
	},

	mapping = {
		["<a-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", }),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<plug>(vsnip-expand-or-jump)", "")
			elseif hasPriorWords() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<s-tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- search completion
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- command completion
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
