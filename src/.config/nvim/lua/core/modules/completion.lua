local cmp = require "cmp"
local luasnip = require "luasnip"

--
-- SETTINGS
--

vim.opt.completeopt = { "menu", "menuone", "preview", "noselect", "noinsert", }

-- vim-vsnip
require("luasnip.loaders.from_vscode").lazy_load()

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
-- PLUGINS
--

-- generic completion
cmp.setup({
	-- completion = { autocomplete = false, },
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	experimental = {
		ghost_text = true,
	},

	mapping = {
		["<a-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", }),
		["<cr>"] = cmp.mapping.confirm({ select = false }),
		["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<c-e>"] = cmp.mapping.abort(),

		["<c-s>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),

		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif hasPriorWords() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<s-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.expand_or_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<c-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif hasPriorWords() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<c-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, { "i", "s" }),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
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

-- codeium
vim.g.codeium_disable_bindings = true
vim.keymap.set("i", "<c-b>", function () return vim.fn["codeium#Accept"]() end, { expr = true })
vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
vim.keymap.set("i", "<m-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
vim.keymap.set("i", "<m-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
