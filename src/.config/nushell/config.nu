register -e json /usr/bin/nu_plugin_inc
register -e json /usr/bin/nu_plugin_query

source alias.nu
source functions.nu
source env.nu

source plugins.nu

# source ($nu.config-path | path dirname | path join scripts | path join plugins.nu)

use lab.nu *

module completions {
	# Custom completions for external commands (those outside of Nushell)
	# Each completions has two parts: the form of the external command, including its flags and parameters
	# and a helper command that knows how to complete values for those flags and parameters
	#
	# This is a simplified version of completions for git branches and git remotes
	def "nu-complete git branches" [] {
		^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
	}

	def "nu-complete git remotes" [] {
		^git remote | lines | each { |line| $line | str trim }
	}

	# Check out git branches and files
	export extern "git checkout" [
		...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
		--conflict: string                              # conflict style (merge or diff3)
		--detach(-d)                                    # detach HEAD at named commit
		--force(-f)                                     # force checkout (throw away local modifications)
		--guess                                         # second guess 'git checkout <no-such-branch>' (default)
		--ignore-other-worktrees                        # do not check if another worktree is holding the given ref
		--ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
		--merge(-m)                                     # perform a 3-way merge with the new branch
		--orphan: string                                # new unparented branch
		--ours(-2)                                      # checkout our version for unmerged files
		--overlay                                       # use overlay mode (default)
		--overwrite-ignore                              # update ignored files (default)
		--patch(-p)                                     # select hunks interactively
		--pathspec-from-file: string                    # read pathspec from file
		--progress                                      # force progress reporting
		--quiet(-q)                                     # suppress progress reporting
		--recurse-submodules: string                    # control recursive updating of submodules
		--theirs(-3)                                    # checkout their version for unmerged files
		--track(-t)                                     # set upstream info for new branch
		-b: string                                      # create and checkout a new branch
		-B: string                                      # create/reset and checkout a branch
		-l                                              # create reflog for new branch
	]

	# Push changes
	export extern "git push" [
		remote?: string@"nu-complete git remotes",      # the name of the remote
		...refs: string@"nu-complete git branches"      # the branch / refspec
		--all                                           # push all refs
		--atomic                                        # request atomic transaction on remote side
		--delete(-d)                                    # delete refs
		--dry-run(-n)                                   # dry run
		--exec: string                                  # receive pack program
		--follow-tags                                   # push missing but relevant tags
		--force-with-lease: string                      # require old value of ref to be at this value
		--force(-f)                                     # force updates
		--ipv4(-4)                                      # use IPv4 addresses only
		--ipv6(-6)                                      # use IPv6 addresses only
		--mirror                                        # mirror all refs
		--no-verify                                     # bypass pre-push hook
		--porcelain                                     # machine-readable output
		--progress                                      # force progress reporting
		--prune                                         # prune locally removed refs
		--push-option(-o): string                       # option to transmit
		--quiet(-q)                                     # be more quiet
		--receive-pack: string                          # receive pack program
		--recurse-submodules: string                    # control recursive pushing of submodules
		--repo: string                                  # repository
		--set-upstream(-u)                              # set upstream for git pull/status
		--signed: string                                # GPG sign the push
		--tags                                          # push tags (can't be used with --all or --mirror)
		--thin                                          # use thin pack
		--verbose(-v)                                   # be more verbose
	]
}

# Get just the extern definitions without the custom completion commands
use completions *

# for more information on themes see
# https://github.com/nushell/nushell/blob/main/docs/How_To_Coloring_and_Theming.md
let theme = {
	# color for nushell primitives
	separator: white
	leading_trailing_space_bg: { attr: n } # no fg, no bg, attr non effectively turns this off
	header: green_bold
	empty: blue
	bool: white
	int: white
	filesize: white
	duration: white
	date: white
	range: white
	float: white
	string: white
	nothing: white
	binary: white
	cellpath: white
	row_index: green_bold
	record: white
	list: white
	block: white
	hints: dark_gray

	# shapes are used to change the cli syntax highlighting
	shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
	shape_binary: purple_bold
	shape_bool: light_cyan
	shape_int: purple_bold
	shape_float: purple_bold
	shape_range: yellow_bold
	shape_internalcall: cyan_bold
	shape_external: cyan
	shape_externalarg: green_bold
	shape_literal: blue
	shape_operator: yellow
	shape_signature: green_bold
	shape_string: green
	shape_string_interpolation: cyan_bold
	shape_datetime: cyan_bold
	shape_list: cyan_bold
	shape_table: blue_bold
	shape_record: cyan_bold
	shape_block: blue_bold
	shape_filepath: cyan
	shape_globpattern: cyan_bold
	shape_variable: purple
	shape_flag: blue_bold
	shape_custom: green
	shape_nothing: light_cyan
}

let $config = {
	filesize_metric: false
	table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
	use_ls_colors: true
	rm_always_trash: false
	color_config: $theme
	use_grid_icons: true
	footer_mode: "25" # always, never, number_of_rows, auto
	quick_completions: true # set this to false to prevent auto-selecting completions when only one remains
	partial_completions: true # set this to false to prevent partial filling of the prompt
	animate_prompt: false # redraw the prompt every second
	float_precision: 2
	use_ansi_coloring: true
	filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
	edit_mode: vi
	max_history_size: 1048576
	sync_history_on_enter: false # Enable to share the history between multiple sessions, else you have to close the session to persist history to file

	menus: [
		# Configuration for default nushell menus
		# Note the lack of souce parameter
		{
			name: completion_menu
			only_buffer_difference: false
			marker: "| "
			type: {
				layout: columnar
				columns: 4
				col_width: 20	 # Optional value. If missing all the screen width is used to calculate column width
				col_padding: 2
			}
			style: {
					text: green
				selected_text: green_reverse
				description_text: yellow
			}
		}
		{
			name: history_menu
			only_buffer_difference: true
			marker: "? "
			type: {
				layout: list
				page_size: 10
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
		}
		{
			name: help_menu
			only_buffer_difference: true
			marker: "? "
			type: {
				layout: description
				columns: 4
				col_width: 20	 # Optional value. If missing all the screen width is used to calculate column width
				col_padding: 2
				selection_rows: 4
				description_rows: 10
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
		}
		# Example of extra menus created using a nushell source
		# Use the source field to create a list of records that populates
		# the menu
		{
			name: commands_menu
			only_buffer_difference: false
			marker: "# "
			type: {
				layout: columnar
				columns: 4
				col_width: 20
				col_padding: 2
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.commands
				| where command =~ $buffer
				| each { |it| {value: $it.command description: $it.usage} }
			}
		}
		{
			name: vars_menu
			only_buffer_difference: true
			marker: "# "
			type: {
				layout: list
				page_size: 10
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.vars
				| where name =~ $buffer
				| sort-by name
				| each { |it| {value: $it.name description: $it.type} }
			}
		}
		{
			name: commands_with_description
			only_buffer_difference: true
			marker: "# "
			type: {
				layout: description
				columns: 4
				col_width: 20
				col_padding: 2
				selection_rows: 4
				description_rows: 10
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				$nu.scope.commands
				| where command =~ $buffer
				| each { |it| {value: $it.command description: $it.usage} }
			}
		}
	]

	keybindings: [

		{
			mode: vi_insert
			modifier: control
			keycode: char_e
			event: {
				until: [
					{ send: historyHintComplete }
					{ send: menuRight }
					{ edit: moveToLineEnd }
				]
			}
		}

		{
			mode: vi_normal
			modifier: none
			keycode: char_~
			event: { edit: capitalizeChar }
		}

		{
			mode: vi_insert
			modifier: control
			keycode: char_w
			event: { edit: cutWordLeft }
		}

		{
			mode: vi_insert
			modifier: alt
			keycode: char_b
			event: { edit: moveWordLeft }
		}

		{
			mode: vi_insert
			modifier: alt
			keycode: char_f
			event: { edit: moveWordRight }
		}

		{
			mode: vi_insert
			modifier: control
			keycode: char_a
			event: { edit: moveToLineStart }
		}

		{
			mode: vi_insert
			modifier: alt
			keycode: backspace
			event: { edit: backspaceWord }
		}

		{
			mode: vi_insert
			modifier: control
			keycode: char_u
			event: { edit: cutFromStart }
		}

		{
			mode: [ vi_normal vi_insert ]
			modifier: alt
			keycode: enter
			event: {
				until: [
					{ edit: insertString, value: "\n" }
				]
			}
		}

		{
			mode: vi_insert
			modifier: control
			keycode: char_d
			event: { send: ctrlD }
		}

		{
			name: reload_config
			mode: [ emacs, vi_insert ]
			modifier: none
			keycode: f5
			event: {
				send: executeHostCommand
				cmd: $"source ($nu.config-path)"
			}
		}

		{
			name: fzf-cd
			mode: [ emacs, vi_insert ]
			modifier: alt
			keycode: char_c
			event: {
				send: executeHostCommand
				cmd: "fzf-cd"
			}
		}

		# {
		# 	name: fzf-files
		# 	mode: [ emacs, vi_insert ]
		# 	modifier: control
		# 	keycode: char_t
		# 	event: {
		# 		edit: insertString
		# 		value: "(fzf-files)"
		# 	}
		# }

		# {
		# 	name: fzf-history
		# 	mode: [ emacs, vi_insert ]
		# 	modifier: control
		# 	keycode: char_r
		# 	event: [
		# 		{ edit: clear }
		# 		{
		# 			edit: insertString
		# 			value: "fzf-history"
		# 		}
		# 		{ send: enter }
		# 		{
		# 			edit: insertString
		# 			value: "fzf-history"
		# 		}
		# 	]
		# }

		{
			name: zoxide-query
			mode: [ emacs, vi_insert ]
			modifier: alt
			keycode: char_s
			event: {
				send: executeHostCommand
				cmd: "cd (zoxide query -i | str trim)"
			}
		}

	]
}
