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

local function normalize_package(pkg)
  if type(pkg) == 'string' then
    return { src = pkg:match('^https?://') and pkg or ('https://github.com/' .. pkg) }
  elseif type(pkg) == 'table' then
    -- { "user/repo", opts = { ... } }
    if pkg[1] and type(pkg[1]) == 'string' then
      local out = {
        src = pkg[1]:match('^https?://') and pkg[1] or ('https://github.com/' .. pkg[1])
      }
      if pkg.opts then
        for k, v in pairs(pkg.opts) do out[k] = v end
      end
      if pkg.deps then out.deps = pkg.deps end
      return out
    elseif pkg.src then
      return vim.deepcopy(pkg)
    else
      error("invalid package spec")
    end
  else
    error("invalid package spec")
  end
end

function pack(...)
  local args = { ... }
  local final = {}
  local seen = {}

  local function add(pkg)
    pkg = normalize_package(pkg)

    if seen[pkg.src] then return end
    seen[pkg.src] = true

    if pkg.deps then
      for _, dep in ipairs(pkg.deps) do
        add(dep)  -- raw strings like "user/repo" get normalized here
      end
    end

    table.insert(final, pkg)
  end

  for _, pkg in ipairs(args) do
    add(pkg)
  end

  vim.pack.add(final)
end
