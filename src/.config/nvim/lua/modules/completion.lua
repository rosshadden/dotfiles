local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

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

local function border(hl_name)
	return {
		{ "┌", hl_name },
		{ "─", hl_name },
		{ "┐", hl_name },
		{ "│", hl_name },
		{ "┘", hl_name },
		{ "─", hl_name },
		{ "└", hl_name },
		{ "│", hl_name },
	}
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

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	mapping = {
		["<a-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", }),
		["<cr>"] = cmp.mapping.confirm({ select = false }),
		["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<c-a>"] = cmp.mapping.abort(),

		["<c-s>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),

		["<c-e>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
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
		{ name = "path" },
		{ name = "copilot" },
		{ name = "codeium" },
	}, {
		{ name = "calc" },
		{ name = "emoji" },
		{ name = "buffer", keyword_length = 5 },
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
		{ name = "cmdline" },
	}),
})

-- lspkind

lspkind.init({
	symbol_map = {
		Copilot = "",
	},
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg ="#6CC644" })
