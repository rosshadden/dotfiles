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
	use_grid_icons: true
	footer_mode: "25" # always, never, number_of_rows, auto
	float_precision: 2
	buffer_editor: "nvim" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
	use_ansi_coloring: true
	edit_mode: vi # emacs, vi
	shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
	show_banner: false # true or false to enable or disable the banner
	render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

	ls: {
		use_ls_colors: true # use the LS_COLORS environment variable to colorize output
		clickable_links: true # enable or disable clickable links. Your terminal has to support links.
	}
	rm: {
		always_trash: false # always act as if -t was given. Can be overridden with -p
	}
	cd: {
		abbreviations: true # allows `cd s/o/f` to expand to `cd some/other/folder`
	}
	table: {
		mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
		index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
		trim: {
			methodology: wrapping # wrapping or truncating
			wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
			truncating_suffix: "..." # A suffix used by the 'truncating' methodology
		}
	}
	# explore: {
	# 	highlight: { bg: 'yellow', fg: 'black' }
	# 	status_bar: { bg: '#C4C9C6', fg: '#1D1F21' }
	# 	command_bar: { fg: '#C4C9C6' }
	# 	split_line: '#404040'
	# 	cursor: true
	# 	# selected_column: 'blue'
	# 	# selected_row: { fg: 'yellow', bg: '#C1C2A3' }
	# 	# selected_cell: { fg: 'white', bg: '#777777' }
	# 	# line_shift: false,
	# 	# line_index: false,
	# 	# line_head_top: false,
	# 	# line_head_bottom: false,
	# }
	history: {
		max_size: 1048576 # Session has to be reloaded for this to take effect
		sync_on_enter: false # Enable to share history between multiple sessions, else you have to close the session to write history to file
		file_format: "sqlite" # "sqlite" or "plaintext"
	}
	completions: {
		case_sensitive: false # set to true to enable case-sensitive completions
		quick: false	# set this to false to prevent auto-selecting completions when only one remains
		partial: true	# set this to false to prevent partial filling of the prompt
		algorithm: "prefix"	# prefix or fuzzy
		external: {
			enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
			max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
			completer: null # check 'carapace_completer' above as an example
		}
	}
	filesize: {
		metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
		format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
	}

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

	hooks: {
		pre_prompt: [{
			$nothing # replace with source code to run before the prompt is shown
		}]
		pre_execution: [{
			$nothing # replace with source code to run before the repl input is run
			# print $"(history | last | get command_line)"
		}]
		env_change: {
			PWD: [{|before, after|
				$nothing # replace with source code to run if the PWD environment is different since the last repl input
			}]
		}
		display_output: {
			if (term size).columns >= 100 { table -e } else { table }
		}
	}
}
