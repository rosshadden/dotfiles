use alias.nu *
use completions.nu *
use functions.nu *

use mappings.nu
use menus.nu
use theme.nu

use bin/eos
use bin/hyprmon

source plugins/mod.nu

$env.config.float_precision = 4
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.show_banner = false
$env.config.use_kitty_protocol = true
$env.config.highlight_resolved_externals = true

$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 5_000_000
$env.config.history.isolation = true

$env.config.completions = (completions)
$env.config.keybindings = (mappings)
$env.config.menus = (menus)
$env.config.color_config = (theme)

$env.config.hooks.env_change.PWD = [
	{|before, after|
		zoxide add .
	}
]

export use ~/local/config.nu *
