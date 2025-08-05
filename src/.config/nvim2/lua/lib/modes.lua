--- Struct allowing mode-specific keymaps.
Mode = {
	name = "",
	seq = "",
	prefix = "",
}

--- Create a Mode.
function Mode.new(name, seq)
	local self = setmetatable(Mode, Mode)
	self.name = name
	self.seq = seq
	self.prefix = "<plug>(" .. self.name .. ")"
	map(self.seq, self.prefix)
	return self
end

--- Map key in mode.
function Mode:map(seq, action, cfg)
	map(self.prefix .. seq, action, cfg)
end
