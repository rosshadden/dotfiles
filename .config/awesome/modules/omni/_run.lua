--
local util = require('modules/util')
--
local omni = require('modules/omni/main')
--


omni.register('run', {
	-- runs given command
	callback = util.run,

	-- open run prompt
	blank = util.menu
})
