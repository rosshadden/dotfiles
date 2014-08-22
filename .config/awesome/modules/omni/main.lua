--
local _ = require("modules/_")
local util = require("modules/util")
--


local omni = {}


local plugins = {}
omni.register = function(namespace, plugin)
	plugins[namespace] = plugin
end

omni.open = function()
	local keys = _.map(_.keys(plugins), function(key)
		return key --.. ':'
	end)

	util.prompt(keys, function(value)
		if #value == 0 then return end

		local i, j = value:find('^%g+')
		local pluginName = value:sub(i, j)
		local plugin = plugins[pluginName]
		local arguments = value:sub(j + 2)

		if not plugin then return end
		if not plugin.cancel then plugin.cancel = omni.open end

		if #arguments == 0 and plugin.blank then
			local result = plugin.blank()
			if not result then plugin.cancel() end
		else
			plugin.callback(arguments)
		end
	end)
end


return omni
