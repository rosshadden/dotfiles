--- Struct allowing mode-specific keymaps.
--- @class Module
--- @field name string Name of the module.
--- @field seq string Entrypoint key sequence.
--- @field prefix string Mapping prefix.
--- @field group int augroup
Module = {}

--- Create a Mode.
--- @param name string Name of the module.
--- @param seq string? Entrypoint key sequence.
--- @return Module
function Module.new(name, seq)
	local self = setmetatable(Module, Module)
	self.name = name
	self.seq = seq
	self.prefix = "<plug>(" .. self.name .. ")"
	self.group = vim.api.nvim_create_augroup(self.name, {})

	if seq ~= nil then
		map(self.seq, self.prefix, { "x", "n", "o" })
	end

	return self
end

--- Map key in mode.
function Module:map(seq, action, modes, cfg)
	map(self.prefix .. seq, action, modes, cfg)
end

require "modules.app"
require "modules.buffers"
require "modules.debug"
require "modules.files"
require "modules.language"
require "modules.packages"
require "modules.registers"
require "modules.search"
require "modules.spans"
require "modules.tabs"
require "modules.templates"
require "modules.ui"
require "modules.vcs"
require "modules.windows"
