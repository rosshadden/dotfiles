--- Map wrapper.
function map(seq, action, cfg)
	cfg = cfg or {}

	local modes = cfg.modes or "n"
	local options = {
		silent = (cfg.silent ~= nil) and cfg.silent or true,
		noremap = (cfg.noremap ~= nil) and cfg.noremap or false,
		desc = cfg.desc,
		expr = cfg.expr,
		nowait = cfg.nowait,
		unique = cfg.unique,
		replace_keycodes = cfg.replace_keycodes,
		callback = cfg.callback,
		buffer = cfg.buffer,
	}

	vim.keymap.set(modes, seq, action, options)
end
