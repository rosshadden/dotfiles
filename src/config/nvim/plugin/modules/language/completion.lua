local completion = Module.new("completion", "<space>C")

pack "neovim/nvim-lspconfig"
pack "zbirenbaum/copilot.lua"

local mini_completion = require "mini.completion"
local mini_snippets = require "mini.snippets"

--
-- SETTINGS
--

vim.opt.wildmode = "noselect:lastused,full"
vim.opt.wildoptions = "pum,fuzzy"

--
-- SETUP
--

-- lsp

local servers = {
	"bashls",
	"copilot",
	"csharp_ls",
	"emmylua_ls",
	"gdscript",
	"gdshader_lsp",
	"gopls",
	"jsonls",
	"julials",
	"nickel_ls",
	"nim_langserver",
	"nushell",
	"ols",
	"pylsp",
	"rust_analyzer",
	"sourcekit",
	"taplo",
	"ts_ls",
	"v_analyzer",
	"zls",
}
vim.lsp.enable(servers)

vim.lsp.config("*", {
	capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		mini_completion.get_lsp_capabilities()
	),
})
vim.lsp.inline_completion.enable()

-- snippets

mini_completion.setup({
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = false,
	},
	mappings = {
		force_twostep = "<a-space>",
		force_fallback = "<ca-space>",
	},
})

mini_snippets.setup({
	snippets = {
		mini_snippets.gen_loader.from_file("~/.config/nvim/snippets/global.lua"),
		mini_snippets.gen_loader.from_lang(),
	},
	mappings = {
		expand = "<c-.>",
		jump_next = "<right>",
		jump_prev = "<left>",
	},
})
mini_snippets.start_lsp_server({ match = false })

require("copilot").setup({})

--
-- MAPPINGS
--

completion:map("f", function()
	vim.opt.completeopt:append({ "fuzzy" })
end)

-- file completion
map("<a-f>", call(feedkeys, "<c-x><c-f>"), "i")

-- better command-line history (or at least different)
map("<up>", "<end><c-u><up>", "c")
map("<down>", "<end><c-u><down>", "c")

local mini_map = require("mini.keymap").map_multistep
mini_map("i", "<cr>", { "pmenu_accept", "minipairs_cr" })

local next_steps = { {
	condition = function() return pumvisible() end,
	action = function() feedkeys "<c-n>" end,
}, {
	-- trigger lsp completion if available
	condition = function() return next(vim.lsp.get_clients { bufnr = 0 }) end,
	action = function() vim.lsp.completion.get() end,
}, {
	condition = function() return vim.bo.omnifunc == "" end,
	action = function() feedkeys "<c-x><c-n>" end,
}, {
	condition = function() return true end,
	action = function() feedkeys "<c-x><c-o>" end,
} }
mini_map("i", "<c-n>", next_steps)

-- Inside a snippet, use backspace to remove the placeholder.
map("<bs>", "<c-o>s", "s")

-- inline completions

map("<tab>", function()
	if not vim.lsp.inline_completion.get() then
		return "<tab>"
	end
end, "i", {
	expr = true,
	replace_keycodes = true,
	desc = "Get the current inline completion",
})

map("<left>", function()
	if not pumvisible() then
		return "<left>"
	end
	vim.lsp.inline_completion.select({ count = -1 })
end, "i", {
	expr = true,
	replace_keycodes = true,
	desc = "Get the previous inline completion",
})

map("<right>", function()
	if not pumvisible() then
		return "<right>"
	end
	vim.lsp.inline_completion.select()
end, "i", {
	expr = true,
	replace_keycodes = true,
	desc = "Get the next inline completion",
})

--
-- EVENTS
--

-- enable lsp completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = completion.group,
	callback = function(event)
		vim.bo[event.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then return end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})

-- trigger completion when typing in command mode
vim.api.nvim_create_autocmd("CmdlineChanged", {
	group = completion.group,
	desc = "automatically show command completion",
	pattern = ":",
	callback = call(vim.fn.wildtrigger),
})
