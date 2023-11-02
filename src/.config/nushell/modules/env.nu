export-env {
	# make gpg open in-terminal dialog
	$env.GPG_TTY = (tty | str trim)

	$env.FZF_DEFAULT_COMMAND = "fd --type file --hidden --follow"
	$env.FZF_DEFAULT_OPTS = ([
			"--cycle"
			"--bind 'alt-enter:print-query,tab:toggle-up,ctrl-y:execute-silent(echo {} | copy)'"
			"--preview 'bat --line-range :500 {}'"
		] | str join " ")

	##
	## settings
	##

	$env.EDITOR = "nvim"
	$env.BROWSER = "thorium-browser"
	# $env.KEYBOARD = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-event-kbd"
	$env.KEYBOARD = "/dev/input/by-id/usb-Razer_Razer_BlackWidow_Ultimate-if01-event-kbd"

	##
	## apps
	##

	# nodejs
	$env.N_PREFIX = "~/local"

	# steam
	$env.STEAM_COMPAT_DATA_PATH = "/media/data/games/proton/"

	# godot
	$env.GODOT_BIN = "/usr/bin/godot"

	# sensible pagers
	$env.PAGER = "less -FRSX"
	$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
	$env.MANROFFOPT = "-c"

	# pass
	$env.PASSWORD_STORE_ENABLE_EXTENSIONS = "true" # [sic]
}
