--- Get lib paths for input packages.
--- @param pkgs string[]
local function libs(pkgs)
	for p, pkg in ipairs(pkgs) do
		pkgs[p] = vim.fn.stdpath "data" .. "/site/pack/core/opt/" .. pkg
	end
	return pkgs
end

--- @type vim.lsp.Config
local result = {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				requirePattern = {
					"lua/?.lua",
					"lua/?/init.lua",
					"lsp/?.lua",
					"lsp/?/init.lua",
					"plugin/?.lua",
					"plugin/?/init.lua",
				}
			},
			workspace = {
				checkThirdParty = false,
				library = {
					"/usr/share/nvim/runtime/lua",
					vim.env.VIMRUNTIME .. "/lua",
					vim.env.VIMRUNTIME .. "/plugin",
					vim.env.VIMRUNTIME .. "/lsp",
					unpack(libs({
						"dial.nvim",
						"hop.nvim",
						"mini.nvim",
						"nvim-treesitter",
						"nvim-treesitter-textobjects",
						"persistence.nvim",
						"snacks.nvim",
					})),
				},
			},
		},
	},
}
return result
