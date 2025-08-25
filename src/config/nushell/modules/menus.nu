export def main [] {
	[

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
				selected_text: { attr: r }
				description_text: yellow
				match_text: { attr: u }
				selected_match_text: { attr: ur }
			}
		}

		{
			name: ide_completion_menu
			only_buffer_difference: false
			marker: "| "
			type: {
				layout: ide
				min_completion_width: 0,
				max_completion_width: 50,
				max_completion_height: 10, # will be limited by the available lines in the terminal
				padding: 0,
				border: true,
				cursor_offset: 0,
				description_mode: "prefer_right"
				min_description_width: 0
				max_description_width: 50
				max_description_height: 10
				description_offset: 1
				# If true, the cursor pos will be corrected, so the suggestions match up with the typed text
				#
				# C:\> str
				#      str join
				#      str trim
				#      str split
				correct_cursor_pos: false
			}
			style: {
				text: green
				selected_text: { attr: r }
				description_text: yellow
				match_text: { attr: u }
				selected_match_text: { attr: ur }
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

		{
			name: files_menu
			only_buffer_difference: true
			marker: "# "
			type: {
				layout: list
			}
			style: {
				text: green
				selected_text: green_reverse
				description_text: yellow
			}
			source: { |buffer, position|
				fd --type f --hidden | rg $buffer
				| lines
				| each { |it| { value: $it } }
			}
		}

	]
}
