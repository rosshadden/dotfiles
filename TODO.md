# meta

- combine startup.sh and i3 startup section
- move gtk-vikb into repo as submodule with build script
- split `lib` into `lib` and `src`
- look into [these dotfiles](https://github.com/xero/dotfiles) for sexiness

## dots

- make `upgrade/U`, for things like submodules
- make `update` announce uncommitted changes in `dotfiles` and `sync`
- make `dots-get`, which will return requested settings/paths/variables
- move `THEME` into a more general place with more, like a toml file

### install

- support arguments
	- `--cli`: non-X mode (no need to install i3 things on a server, for example)
- vet using a `Makefile`
- call `dots update` from systemd service
- possibly make a (generated? githook?) manifest file, to make cleanup easier
	- add a clause to `update` that creates new links and removes old

## docs

- improve/update
- screenshots
- meta (kind of pun), as in keyboard layout, remapped keys, etc.
- vim setup
- git aliases
- wm workflow
- tig workflow

# apps

## vim

- modes
	- tests
		- make mappings for opening the test for the current file (and vice versa)
	- buffer
		- mapping to delete all unused/hidden buffers (not just empty)
	- diff
		- :LineDiff
		- :DiffChanges
		- :git diff
	- sessions
		- fix and/or make stuff that actually works
- [pluginify my modes](https://stevelosh.com/blog/2011/09/writing-vim-plugins/#s6-mapping-keys-the-right-way)

## i3

- make playerctl player changeable
- modes
	- break out modes into separate files
		- add a generated help notification for each mode, on `?`
- universalize the media/resize/move increments and whatnot
	- make sure there are mappings for both big and small increments
- integrate todoist

## tmux

- use `choose-session` to pick a session to link current session to

### tp

- break `tp` and friends into separate repo
- use `j -sl | fzf +s --tac` to give a list of recent dirs
- add option to `ta` and `tp` to `j`ump to the directory and make the session name the destination dir
	- should possibly share code with `tp` and `ta`, to determine the session name
- universalize all of the `tl`, `ta`, `tp`, etc things, into one binary
	- `t p`, `t l`, etc.

## tig

- fix opening files in neovim (again)
- mappings
	- scrap
	- stash / pop
		- per file
		- all
	- checkout tags
		- the main checkout bind should probably just support tags too
		- add tags to the list branch
	- add mappings to wiki

## copyq

- make it use my dotfiles theme
- figure out why URLs are duplicated

# shell

- add `-n` arg to `copy` to strip out `\n`s

## for-{in,of}

- break out into separate repo

# X11

- [modularize `.Xresources`](https://wiki.archlinux.org/index.php/x_resources#Include_files)
- look into [existing `.Xresources` themes](http://www.noobslab.com/)

## keys

- vet breaking out into separate repo

# awmni / owmni

- client-agnostic back-end, which should work with X and terminals alike
- clients
	- rofi
	- fzf
	- pick
	- selecta
	- dmenu
- plugins
	- git
		- `git branch | cut -c 3- | owmni <blah blah> | xargs git checkout`
		- `git branch -r | cut -c 10- | fzf | xargs git checkout`
	- i3
	- copyq
	- zeal
	- todoist
	- apps
		- open (`.desktop` files)
		- run (`/usr/bin`, etc., or maybe everything in `$PATH`)
		- kill
		- switch-to (like `rofi`'s window mode)
	- media
	- computer
	- fasd
	- files
		- recursive list of files
			- all
			- respecting .gitignore
		- files in current folder
			- all
			- respecting .gitignore
	- projects
		- open tmux panes on certain workspaces, etc
	- windows
	- pidgin / finch
		- initiate IMs
		- switch to opened IMs
		- send a message
	- email (mutt?)
	- grunt
