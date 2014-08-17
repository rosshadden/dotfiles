_ = {}


_.each = function(items, fn)
	for i, item in ipairs(items) do
		fn(item, i)
	end
end

_.map = function(items, fn)
	local new = {}
	_.each(items, function(item, i)
		new[i] = fn(item, i)
	end)
	return new
end

_.filter = function(items, fn)
	local new = {}
	_.each(items, function(item, i)
		if fn(item, i) then
			new[i] = item
		end
	end)
	return new
end

_.reduce = function(items, fn, value)
	_.each(items, function(item, i)
		value = fn(value, item, i)
	end)
	return value
end

_.find = function(items, fn)
	for i, item in ipairs(items) do
		local result = fn(item, i)
		if result then return item end
	end
end

_.has = function(items, key)
	return items[key] ~= nil
end


return _
