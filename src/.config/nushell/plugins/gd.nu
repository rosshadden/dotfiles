def args [args: list<string>] {
	$args | compact --empty
}

# Open neovim in server mode.
export def edit [] {
	nvim --listen ./nvim.sock
}

# Godot binray.
export def --wrapped bin [...args] {
	godot ...$args
}

# Open project in Godot.
export def open [] {
	godot --editor
}

# Open project picker.
export def projects [] {
	godot --project-manager
}

# Run project.
export def run [
	--headless (-H) # Run in headless mode.
] {
	godot ...(args [
		(if $headless { "--headless" } else { "" })
	]) .
}

# Run tests using GUT.
export def test [
	--gui (-g) # Run in headlessless mode.
	--debug (-d) # Run in debug mode.
	--verbose (-v) # Run in verbose mode.
] {
	godot ...(args [
		(if $debug { "--debug" } else { "" })
		(if $gui { "" } else { "--headless" })
		(if $verbose { "--verbose" } else { "" })
		-s addons/gut/gut_cmdln.gd
	])
}

# Run tests when updated.
# TODO: support flags
export def "test watch" [] {
	watch test {
		test --debug | tee {}
	}
}

# Create default test config.
# TODO: use actual values
export def "test config" [] {
	{} | to json | save .gutconfig.json
}

# Open tabs and panes in my usual layout.
# TODO: deprecate in favor of making the original `pj` more versatile
export def --env dev [
	query?: string # Zoxide query
] {
	if $query != null { zoxide query $query | cd $in }

	wezterm cli spawn --cwd . -- nu -e "gd edit"
	wezterm cli spawn --cwd . -- nu
		| wezterm cli split-pane --pane-id $in --left -- nu -e "tigs"
	wezterm cli activate-pane-direction left
	wezterm cli spawn --cwd . -- nu -e "gd open"
		| wezterm cli split-pane --pane-id $in --bottom -- nu
	wezterm cli activate-tab --tab-index 0
	wezterm cli kill-pane
}

export def main [] {}
