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

--- Helper function to flatten nested arrays
local function flatten(t, result)
	for _, v in ipairs(t) do
		if type(v) == "table" and not v.src and #v > 0 then
			flatten(v, result)
		else
			table.insert(result, v)
		end
	end
end

--- Add packages.
function pack(...)
	local specs = {}

	for _, arg in ipairs({...}) do
		if type(arg) == "table" and not arg.src and #arg > 0 then
			flatten(arg, specs)
		else
			table.insert(specs, arg)
		end
	end

	return vim.pack.add(specs)
end
