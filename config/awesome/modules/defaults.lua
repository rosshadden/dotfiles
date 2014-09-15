--
local apps = require('modules/apps')
--


local defaults = {}


defaults.web = apps.getCmd('chrome')
defaults.terminal = apps.getCmd('terminator')
defaults.files = apps.getCmd('spacefm')
defaults.editor = os.getenv('EDITOR') or 'vim'
defaults.edit = defaults.terminal .. ' -e ' .. defaults.editor
defaults.calculator = 'qalculate-gtk'

defaults.term = {}
defaults.term.editor = defaults.editor
defaults.term.files = 'vifm'
defaults.term.calculator = 'qalc'


return defaults
