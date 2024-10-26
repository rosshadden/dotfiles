def args [args: list<string>] {
	$args | compact --empty
}

# Open neovim in server mode.
export def edit [] {
	nvim --listen ./nvim.sock
}

# Open project in Godot.
export def open [] {
	godot ...(args [
	]) --editor
}

# Run project.
export def run [
	--headless (-H) # Run in headless mode.
] {
	godot ...(args [
		(if $headless { "--headless" } else {""})
	]) .
}

# Run tests using GUT.
export def test [
	--headless (-H) # Run in headless mode.
	--debug (-d) # Run in debug mode.
] {
	godot ...(args [
		(if $debug { "--debug" } else {""})
		(if $headless { "--headless" } else {""})
		-s addons/gut/gut_cmdln.gd
	])
}

# Create default test config.
# TODO: use actual values
export def "test config" [] {
	{} | to json | save .gutconfig.json
}

# Open tabs and panes in my usual layout.
# TODO: deprecate in favor of making the original fn more versatile
export def pj [] {
	wezterm cli spawn --cwd . -- nu -e "gd edit"
	wezterm cli spawn --cwd . -- nu
		| wezterm cli split-pane --pane-id $in --left nu -e "tigs"
	wezterm cli activate-pane-direction left
	wezterm cli spawn --cwd . -- nu -e "gd open"
	wezterm cli activate-tab --tab-index 0
	wezterm cli kill-pane
}

export def main [] {}
