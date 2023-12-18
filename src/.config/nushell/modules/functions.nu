##
## SHORTCUTS
##

export def l [dir: string = "."] {
	ls -la $dir | if ($in | is-empty) {} else { select name type size target mode user group modified }
}

##
## UTILS
##

# Duplicate files to another location.
# Places them in the same folders relative to destination.
export def dupe [
	direction: string # whether to dupe `to` or `from` the $directory
	directory: path # the directory to dupe to/from
	...files: path # files to dupe
] {
	if $direction == "to" {
		^cp -r $files $directory
	} else {
		for file in $files {
			cp -r $"($directory)/($file)" $file
		}
	}
}

# Paste from clipboard
export def put [
	--flags (-f): string # Optional flags to override default of "--clipboard"
] {
	let flags = (if ($flags | is-empty) { "--clipboard" } else { $flags })
	xsel -o $flags
}

# type last arg from previous command
# Requires: `xdotool`, `fd`
export def last-arg [] {
	let cmd = (history | last)
	$cmd | split row (char space) | last
}

##
## APPS
##

# fzf through files, typing result.
# Requires: `fd`
export def fzf-files [] {
	fd --type f --hidden | fzf --prompt "FILES> "
}

# fzf through directories, navigating to result
# Requires: `fd`
export def --env fzf-cd [] {
	cd (fd --type d --hidden | fzf --prompt "FOLDERS> " | str trim)
}

# fzf through shell history, typing result.
# Requires: `xdotool`
export def fzf-history [
	--query (-q): string # Optionally start with given query.
] {
	(history | get command | reverse | to text | fzf --prompt "HISTORY> " --query $"($query)")
}

# Attach to existing session, or create new.
# If inside a session already, rename it.
export def ta [
	...params: string # Optional name. Defaults to name of current directory.
] {
	let name = (if ($params | length) == 1 { $params } else { basename (pwd) | str trim })
	let isTmux = "TMUX" in ($env | transpose keys | get keys)
	if $isTmux {
		tmux rename-session $name
		echo "Renaming session to: $name"
	} else {
		tmux -u new-session -A -s $name
	}
}

# Attach to existing session using fzf'd list
export def tj [
	...params: string # Optional name. Defaults to name of current directory.
] {
	let name = (if ($params | length) == 1 { $params } else { tmux list-sessions -F '#{session_name}' | fzf })
	ta $name
}

export def zshtory [] {
	bat ~/.zsh_history | str replace -a ': \d+:\d+;' ""
}

# # Change to dir matching zoxide query
# export def --env s [
# 	query: string # Directory query
# ] {
# 	cd (zoxide query $query | str trim)
# }
