export def main [] {
	let zoxide_completer = {|spans: list<string>|
		$spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
	}

	let carapace_completer = {|spans: list<string>|
		carapace $spans.0 nushell ...$spans | from json
	}

	let completer = {|spans: list<string>|
		let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

		let spans = (
			if $expanded_alias != null {
				# put the first word of the expanded alias first in the span
				$spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
			} else { $spans }
		)

		match $spans.0 {
			__zoxide_z => $zoxide_completer
			__zoxide_zi => $zoxide_completer
			_ => $carapace_completer
		} | do $in $spans
	}

	{
		external: {
			enable: true
			completer: $completer
		}
	}
}
