register -e json /usr/bin/nu_plugin_inc
register -e json /usr/bin/nu_plugin_query

use alias.nu *
use functions.nu *
use env.nu *
source plugins.nu

# source ($nu.config-path | path dirname | path join modules | path join plugins.nu)

use lab.nu *
use completions.nu *

use mappings.nu get-mappings
use menus.nu get-menus
use theme.nu get-theme

let-env config = {
	filesize_metric: false
	table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
	use_ls_colors: true
	rm_always_trash: false
	use_grid_icons: true
	footer_mode: "25" # always, never, number_of_rows, auto
	quick_completions: false # set this to false to prevent auto-selecting completions when only one remains
	partial_completions: true # set this to false to prevent partial filling of the prompt
	animate_prompt: false # redraw the prompt every second
	float_precision: 2
	buffer_editor: "nvim"
	use_ansi_coloring: true
	filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
	edit_mode: vi
	max_history_size: 1048576
	sync_history_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
	# shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
	# completion_algorithm: "fuzzy" # prefix, fuzzy

	keybindings: (get-mappings)
	menus: (get-menus)
	color_config: (get-theme)
}
