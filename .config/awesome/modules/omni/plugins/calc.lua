--
local defaults = require('modules/defaults')
local util = require('modules/util')
--
local omni = require('modules/omni/main')
--


local calculate = function(expression)
	if expression == '' or expression == ':open' then
		return util.run(defaults.calculator)
	end

	local cmd = defaults.term.calculator
	cmd = cmd .. ' ' .. expression

	local result = util.exec(cmd)
	log(result)
end


omni.register('calc', {
	callback = calculate,

	blank = function()
		omni.prompt('calc:', commands, calculate)
	end,

	commands = {
		open = function(expression)
			local cmd = defaults.calculator
			if expression then cmd = cmd .. ' ' .. expression end
			util.run(cmd)
		end
	}
})
