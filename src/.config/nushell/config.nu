register /usr/bin/nu_plugin_inc
register /usr/bin/nu_plugin_query

use alias.nu *
use functions.nu *
use env.nu *
use path.nu *
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
	case_sensitive_completions: false
	partial_completions: true # set this to false to prevent partial filling of the prompt
	completion_algorithm: "prefix" # prefix, fuzzy
	float_precision: 2
	buffer_editor: "nvim"
	use_ansi_coloring: true
	filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
	edit_mode: vi
	max_history_size: 1048576
	sync_history_on_enter: false # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
	history_file_format: "sqlite" # "sqlite" or "plaintext"
	shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
	disable_table_indexes: false # set to true to remove the index column from tables
	cd_with_abbreviations: false # set to true to allow you to do things like cd s/o/f and nushell expand it to cd some/other/folder
	case_sensitive_completions: false # set to true to enable case-sensitive completions
	enable_external_completion: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
	max_external_completion_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
	show_banner: false

	# # A strategy of managing table view in case of limited space.
	# table_trim: {
	# 	methodology: wrapping, # truncating
	# 	# A strategy which will be used by 'wrapping' methodology
	# 	wrapping_try_keep_words: true,
	# 	# A suffix which will be used with 'truncating' methodology
	# 	# truncating_suffix: "..."
	# }

	keybindings: (get-mappings)
	menus: (get-menus)
	color_config: (get-theme)
}
