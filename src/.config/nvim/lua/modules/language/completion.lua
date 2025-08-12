local completion = Module.new("completion")

pack "neovim/nvim-lspconfig"

local mini_completion = require "mini.completion"
local mini_snippets = require "mini.snippets"

--
-- FUNCTIONS
--

--- Get lib paths for input packages.
--- @param pkgs string[]
local function libs(pkgs)
	for p, pkg in ipairs(pkgs) do
		pkgs[p] = vim.fn.stdpath "data" .. "/site/pack/core/opt/" .. pkg
	end
	return pkgs
end

--
-- SETUP
--

-- lsp

local servers = {
	"bashls",
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

vim.lsp.config("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = { "E501" },
				},
			},
		},
	},
})

vim.lsp.config("emmylua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				requirePattern = {
					"lua/?.lua",
					"lua/?/init.lua",
				}
			},
			workspace = {
				checkThirdParty = false,
				library = {
					"/usr/share/nvim/runtime/lua",
					vim.env.VIMRUNTIME .. "/lua",
					unpack(libs({
						"dial.nvim",
						"hop.nvim",
						"mini.nvim",
						"nvim-treesitter",
						"nvim-treesitter-textobjects",
						"snacks.nvim",
					})),
				},
			},
		},
	},
})

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

--
-- MAPPINGS
--

map("<localleader>=", vim.lsp.buf.format)
map("<m-f>", call(feedkeys, "<c-x><c-f>"), "i")

local function completion_mappings()
	-- Use enter to accept completions.
	map("<cr>", function()
		return pumvisible() and "<c-y>" or "<cr>"
	end, "i", { expr = true })

	-- Use <c-n> to navigate to the next completion or:
	-- - Trigger LSP completion.
	-- - If there"s no one, fallback to vanilla omnifunc.
	map("<c-n>", function()
		if pumvisible() then
			feedkeys "<c-n>"
		else
			if next(vim.lsp.get_clients { bufnr = 0 }) then
				vim.lsp.completion.get()
			else
				if vim.bo.omnifunc == "" then
					feedkeys "<c-x><c-n>"
				else
					feedkeys "<c-x><c-o>"
				end
			end
		end
	end, "i")

	-- Inside a snippet, use backspace to remove the placeholder.
	map("<bs>", "<c-o>s", "s")
end

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
			completion_mappings()
		end
	end,
})
