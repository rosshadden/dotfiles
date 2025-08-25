export def main [] {
	[

		# complete hint (word)
		{
			mode: vi_insert
			modifier: alt
			keycode: char_i
			event: { send: historyHintWordComplete }
		}

		# complete hint (full)
		{
			mode: vi_insert
			modifier: alt
			keycode: char_e
			event: { send: historyHintComplete }
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
			modifier: control
			keycode: backspace
			event: { edit: backspaceWord }
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
			modifier: control
			keycode: char_u
			event: { edit: cutFromStart }
		}

		{
			mode: [ vi_normal vi_insert ]
			modifier: alt
			keycode: enter
			event: { edit: insertString, value: (char nl) }
		}

		{
			mode: vi_insert
			modifier: control
			keycode: char_d
			event: { send: ctrlD }
		}

		{
			name: reload_config
			mode: [ vi_insert emacs ]
			modifier: none
			keycode: f5
			event: {
				send: executeHostCommand
				cmd: "source $nu.config-path"
			}
		}

		{
			name: fzf-cd
			mode: [ vi_insert emacs ]
			modifier: alt
			keycode: char_c
			event: {
				send: executeHostCommand
				cmd: "fzf-cd"
			}
		}

		{
			name: zoxide-query
			mode: [ vi_insert emacs ]
			modifier: alt
			keycode: char_s
			event: {
				send: executeHostCommand
				cmd: "zoxide query -i | cd $in"
			}
		}

		# qol

		# input first word of prior command
		{
			mode: vi_insert
			modifier: alt
			keycode: "char_,"
			event: {
				send: executeHostCommand
				cmd: "commandline edit --insert (history | last | get command | parse --regex `^(?P<val>[^ ]+)` | get val.0)"
			}
		}

		# input last word of prior command
		{
			mode: vi_insert
			modifier: alt
			keycode: char_.
			event: {
				send: executeHostCommand
				cmd: "commandline edit --insert (history | last | get command | parse --regex `(?P<val>[^ ]+)$` | get val.0)"
			}
		}

		# menus

		{
			mode: [ vi_normal vi_insert emacs ]
			modifier: alt
			keycode: char_/
			event: {
				until: [
					{ send: menu, name: commands_menu }
					{ send: menuPageNext }
				]
			}
		}

		{
			mode: [ vi_normal vi_insert emacs ]
			modifier: alt
			keycode: char_v
			event: {
				until: [
					{ send: menu, name: vars_menu }
					{ send: menuPageNext }
				]
			}
		}

		{
			mode: [ vi_insert emacs ]
			modifier: control
			keycode: char_t
			event: { send: menu, name: files_menu }
		}

		{
			name: ide_completion_menu
			modifier: alt
			keycode: space
			mode: [emacs vi_normal vi_insert]
			event: {
				until: [
					{ send: menu name: ide_completion_menu }
					{ send: menunext }
					{ edit: complete }
				]
			}
		}

	]
}
