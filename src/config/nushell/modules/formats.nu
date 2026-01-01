# Convert Godot TSCN entry to record.
def to_record []: string -> record {
	$in
	| parse "[{type} {params}]"
	| update params {
		split row (char space)
		| each { from ini }
		| reduce -f {} {|row, acc| $acc | merge deep $row }
		| get ""
	}
	| get 0
}

# Convert Godot TSCN file to NUON.
export def "from tscn" []: string -> list<record> {
	$in | lines -s
	| reduce -f [] {|line, entries|
		if ($line | str starts-with ";") { return $entries }

		if ($line | str starts-with "[") {
			# entry
			return ($entries | append ($line | to_record))
		} else {
			# field
			let new_field = $line | from ini | get ""
			let last = $entries | last | upsert fields {|entry|
				$entry.fields? | default {} | merge deep $new_field
			}
			let index = ($entries | length) - 1
			return ($entries | update $index $last)
		}
		$entries
	}
}
