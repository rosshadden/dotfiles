##
## SHORTCUTS
##

export def l [dir: glob = "."] {
	ls -la $dir | if ($in | is-empty) {} else { select name type size target mode user group modified }
}

##
## UTILS
##


# Return whether the input is the given type
export def is [
	type: string
]: any -> bool {
	describe --detailed | $in.type == $type
}

# Duplicate files to another location.
# Places them in the same folders relative to destination.
export def dupe [
	direction: string # whether to dupe `to` or `from` the $path
	path: path # the path to dupe to/from
	...files: path # files to dupe
] {
	if $direction == "to" {
		^cp -r $files $path
	} else {
		for file in $files {
			cp -r $"($path)/($file)" $file
		}
	}
	# TODO: mv (d cu down | ls -s $in | get name | to text | fzf -m | str trim | prepend (d cu down) | path  join) .
}

# Paste from clipboard
export def put [
	--no-newline (-n) # trim newline
] {
	wl-paste | if $no_newline { str trim } else {}
}

# type last arg from previous command
# Requires: `xdotool`, `fd`
export def last-arg [] {
	let cmd = (history | last)
	$cmd | split row (char space) | last
}

# Print input and pass it on
export def spy [] {
	do {|input|
		print $input
		$input
	} $in
}


# Render template using `tera-cli`
export def rend [
	template: string
]: [
	string -> string
	record -> string
] {
	let temp_file = mktemp -t rend.XXX.tmp
	$template | save -f $temp_file
	let res = $in
	| if ($in | is string) { from nuon } else {}
	| to json --raw
	| tera --stdin --template $temp_file
	rm $temp_file
	$res
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

# Open
export def pj [] {
	wezterm cli spawn --cwd . -- nu -e nvim
	wezterm cli spawn --cwd . -- nu
		| wezterm cli split-pane --pane-id $in --left nu -e tigs
	wezterm cli activate-pane-direction left
	wezterm cli spawn --cwd . -- nu
	wezterm cli activate-tab --tab-index 0
	wezterm cli kill-pane
}

# Attach to existing session, or create new.
# If inside a session already, rename it.
export def ta [
	name?: string # Optional name. Defaults to name of current directory.
] {
	let name = if ($name | is-empty) { pwd | basename $in } else { $name }
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
	name?: string # Optional name. Defaults to name of current directory.
] {
	let name = if ($name | is-empty) { tmux list-sessions -F '#{session_name}' | fzf } else { $name }
	ta $name
}

# # Change to dir matching zoxide query
# export def --env s [
# 	query: string # Directory query
# ] {
# 	cd (zoxide query $query | str trim)
# }

# Check whether there is a newer nushell
export def nu? [
	--refresh (-r) # Refresh pacman
] {
	if $refresh { paru -Syy }
	let url = "https://github.com/nushell/nushell/releases/latest"
	let current = version | get version
	let latest = http head --redirect-mode manual $url
	| transpose -rd
	| get location
	| split row "/"
	| last

	{
		update?: ($current != $latest)
		current: $current
		latest: $latest
		pacman: (paru -Sl galaxy | rg nushell | detect columns -n -c 2..3 | get column2.0)
	}
}

# Load .env file in current directory.
export def --env dotenv [] {
	open .env
	| lines -s
	| parse -r `^\s*(?<key>[^\s=]+)\s*=\s*(?<value>[^\s].*)$`
	| update value {
		let val = $in
		let parsed = ($val | parse -r "^(['\"`])(.*)\\1")
		if ($parsed | length) == 0 {
			$val
		} else if ($parsed | length) > 0 {
			$parsed.capture1.0
		} else {}
	}
	| transpose --header-row --as-record
	| load-env
}
