pack "nvim-mini/mini.nvim"

--
-- CLASSES
--

--- Struct allowing mode-specific keymaps.
--- @class Module
--- @field name string Name of the module.
--- @field seq string Entrypoint key sequence.
--- @field prefix string Mapping prefix.
--- @field group int augroup
Module = {}
Module.__index = Module

--- Create a Mode.
--- @param name string Name of the module.
--- @param seq string? Entrypoint key sequence.
--- @return Module
function Module.new(name, seq)
	local self = setmetatable({}, Module)
	self.name = name
	self.seq = seq or ""
	self.prefix = "<plug>(" .. self.name .. ")"
	self.group = vim.api.nvim_create_augroup(self.name, {})

	if seq ~= nil then
		map(self.seq, self.prefix, { "x", "n", "o" }, { desc = self.name .. " module" })
	end

	return self
end

--- Map key in mode.
function Module:map(seq, action, modes, cfg)
	map(self.prefix .. seq, action, modes, cfg)
end
