# dotfiles

A collection of dotfiles and scripts that I use between computers.

See the [TODO](TODO.md) for things I have in mind.

## My environment

- [Arch Linux](https://www.archlinux.org/)
- [`i3`](https://i3wm.org/)
- [`neovim`](https://neovim.io/)
- [`zsh`](https://wiki.archlinux.org/index.php/zsh)
- [`tmux`](https://tmux.github.io/)
- [`wezterm`](https://wezfurlong.org/wezterm/)

## Dependencies

- [`nushell`](https://nushell.sh)
- [`i3`](https://i3wm.org/)
	- `xdotool`
	- [`rofimoji`](https://github.com/fdw/rofimoji)
- [`neovim`](https://neovim.io/)
- [`tmux`](https://github.com/tmux/tmux)
	- [`tmuxp`](https://github.com/tony/tmuxp) - powers ./bin/tp
	- [`urlview`](https://github.com/sigpipe/urlview)
	- [`fpp`](https://github.com/facebook/PathPicker)
- [`tig`](https://github.com/jonas/tig)
- [`fzf`](https://github.com/junegunn/fzf)
- [`lf`](https://github.com/gokcehan/lf)
	- installed optional dependencies:
		- `atool`
		- `bat`
		- `highlight`
		- `libcaca`
		- `mediainfo`
		- `poppler`
		- `python-chardet`
		- `w3m`
- fonts
	- `ttf-fantasque-sans-mono` - main font
	- `otf-fira-code` - x11 font
	- `ttf-font-icons` - mix of non-overlapping fonts from Font Awesome and Ionicons

## Vim stuff

- text objects
	- uris [ au, iu ]
	- pasted text [ gb ]
	- variable segment [ iv, av ]
	- entire buffer [ ie, ae ]
	- lines [ ir, ar ]
	- indents [ ii, ai ]
