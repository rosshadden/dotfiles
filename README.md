# dotfiles

A collection of dotfiles and scripts that I use between computers.

See the [TODO](TODO.md) for things I have in mind.

## My environment

- [Arch Linux](https://www.archlinux.org/)
- [`i3`](https://i3wm.org/)
- [`neovim`](https://neovim.io/)
- [`zsh`](https://wiki.archlinux.org/index.php/zsh)
- [`tmux`](https://tmux.github.io/)
- [`termite`](https://wiki.archlinux.org/index.php/Termite)

## Dependencies

- `zsh`
	- [`zplug`](https://zplug.sh/) - package manager
- [`neovim`](https://neovim.io/)
	- [`npm:tern`](https://github.com/ternjs/tern) - code analyzer
	- [`npm:jsctags`](https://github.com/ramitos/jsctags) - JavaScript tags
	- [`npm:livedown`](https://github.com/shime/vim-livedown) - live previews of markdown files in vim
	- [`ctags`](https://www.archlinux.org/packages/extra/i686/ctags/) - exuberant ctags
- [`tmux`](https://github.com/tmux/tmux)
	- [`tmuxp`](https://github.com/tony/tmuxp) - powers ./bin/tp
	- [`urlview`](https://github.com/sigpipe/urlview)
	- [`fpp`](https://github.com/facebook/PathPicker)
- [`tig`](https://github.com/jonas/tig)
- [`fzf`](https://github.com/junegunn/fzf)
- [`pidgin`](https://pidgin.im/)
	- `python-dbus` - powers `./lib/purple.py`
	- [`gtk-theme-numix-ocean`](https://github.com/aaronjamesyoung/Numix-Ocean)
- [`ranger`](https://github.com/hut/ranger)
	- installed optional dependencies:
		- `atool`
		- `highlight`
		- `libcaca`
		- `mediainfo`
		- `poppler`
		- `python-chardet`
		- `transmission-cli`
		- `w3m`
- fonts
	- `ttf-fantasque-sans` - main font
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
