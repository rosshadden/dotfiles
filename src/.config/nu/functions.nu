# fzf through shell history, typing result.
# Requires: `xdotool`
def fzf-history [
	--query (-q): string # Optionally start with given query.
] {
	let result = (history | reverse | reduce { $acc + (char nl) + $it } | fzf --prompt "HISTORY> " --query $"($query)")
	xdotool type $result
}

# fzf through files, typing result.
# Requires: `xdotool`, `fd`
def fzf-files [] {
	let result = (fd | fzf --prompt "FILES> ")
	xdotool type $result
}

# Duplicate files to another location.
# Places them in the same folders relative to destination.
def dupe [
	direction: string # whether to dupe `to` or `from` the $directory
	directory: path # the directory to dupe to/from
	...files: path # files to dupe
] {
	if $direction == "to" {
		^cp -r $files $directory
	} {
		for file in $files {
			cp -r $"($directory)/($file)" $file
		}
	}
}

# Attach to existing session, or create new.
# If inside a session already, rename it.
def ta [
	...params: string # Optional name. Defaults to name of current directory.
] {
	let name = (if ($params | length) == 1 { $params } { basename (pwd) })
	let isTmux = "TMUX" in ($nu.env | pivot keys | get keys)
	if $isTmux {
		tmux rename-session $name
		echo "Renaming session to: $name"
	} {
		tmux -u new-session -A -s $name
	}
}

# Attach to existing session using fzf'd list
def tj [
	...params: string # Optional name. Defaults to name of current directory.
] {
	let name = (if ($params | length) == 1 { $params } { tmux list-sessions -F '#{session_name}' | fzf })
	ta $name
}

# Paste from clipboard
def put [
	--flags (-f): string # Optional flags to override default of "--clipboard"
] {
	let flags = (if ($flags | empty?) { "--clipboard" } { $flags })
	xsel -o $flags
}
