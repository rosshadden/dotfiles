# meta

- move gtk-vikb into repo as submodule with build script
- split `lib` into `lib` and `src`
- look into [these dotfiles]( https://github.com/xero/dotfiles ) for sexiness
- consider moving systemd stuff to sync, or vice versa
- move startup things to systemd
- make tropes/mappings consistent across programs

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
- i3 workflow
- tig workflow
- ranger workflow

# apps

## vim

- figure out where I can use `on_cmd` in `packages.vim`
- conditionally include packages, based on dependencies
	- @ex taskwarrior (even though I've since removed this)
- modes
	- javascript
		- make mappings for opening the test for the current file (and vice versa)
			- hopefully use `portkey`, but it'll need a global default file
	- buffer
		- mapping to delete all unused/hidden buffers (not just empty)
	- files
		- mapping that uses `ranger` to insert a (relative) path to the selected file
		- make a mapping or mode for finding files not in the repo
	- diff
		- :LineDiff
		- :DiffChanges
		- :git diff
	- sessions
		- fix and/or make stuff that actually works
	- ember? or nah
- plugins
	- [pluginify my modes]( http://stevelosh.com/blog/2011/09/writing-vim-plugins/#mapping-keys-the-right-way )
	- pluginify `ranger` stuff
	- pluginify other stuff
	- see if I can make [this]( https://github.com/easymotion/vim-easymotion/issues/248#issuecomment-156444426 ) happen
		- map `.` in target select mode

## i3

- make tmux mode support apps
	- `[tmux]d` for dotfiles
	- `[tmux]m` for music/media/muse, whatever
- make the 2nd `i3lock` thing blur my background
- fix and add backgrounds
- add clipboard management
- modes
	- break out modes into separate files
		- add a generated help notification for each mode, on `?`
- get current tag
	- open tmux session for current tag
- universalize the media/resize/move increments and whatnot
	- make sure there are mappings for both big and small increments
- integrate `tp`
- integrate dunst
- integrate todoist

## tmux

- make function that evenly resizes panes
- rewrite or change tmux-urlview, to use `fzf`
- Raws, Private Investigator
	- fix prefix not showing in status on first launch
		- probably because of the vim/airline stuff
- use `choose-session` to pick a session to link current session to

### tp

- break `tp` and friends into separate repo
- use `j -sl | fzf +s --tac` to give a list of recent dirs
- add `tcd` function, which `cd`s into a dir and renames the tmux session to that
	- should possibly share code with `tp` and `ta`, to determine the session name
- universalize all of the `tl`, `ta`, `tp`, etc things, into one binary

## tig

- spend time making it even more useful
- universalize mappings
- fix opening files in neovim
- investigate [wiki binds]( https://github.com/jonas/tig/wiki/Bindings )
- mappings
	- scrap
	- stash / pop
		- per file
		- all
	- checkout tags
		- the main checkout bind should probably just support tags too
		- add tags to the list branch
	- add mappings to [wiki]( https://github.com/jonas/tig/wiki/Bindings )

## ranger

- support an easier deletion, like how `vifm` does it using `trash-cli`
- mapping to rename with vim

## fzf

- either:
	- make a binary, like `f` or `r`
	- or, make a consistent prefix, like `fcd`, `f-cd`, or `fzf-cd`
- make convenient wrappers
	- `cd`
	- `j`
- maybe this is all `awmni`'s responsibility...

## copyq

- make it use my dotfiles theme
- figure out why URLs are duplicated

## zeal

- integrate into workflow
- figure out wtf keeps going wrong with the i3 shortcut, and fix it

## dunst

- make context menu entry for copying contents to clipboard

# shell

- wrap aliases and functions in `if [[ -x \`which <cmd>\` ]]` blocks
- make things more modular
- handle zsh- and bash- specific things better
	- `shell/features.sh`, and `shell/features.zsh`
- revisit aliases
	- introduce `ls -1`
- add `-n` arg to `copy` to strip out `\n`s

## zsh

- vet using zplug for loading local modules
- refactor `.zshrc`
	- make semantic modules instead of a file for aliases and a file for functions (for example)
	- split `features.zsh` into files
	- look into [built-in functions]( https://github.com/zsh-users/zsh/tree/master/Functions/Zle )
	- look into [better status indicator]( http://ivyl.0xcafe.eu/2013/02/03/refining-zsh/#vi_mode_status_indicator )
- make mapping to insert newline at cursor

## for-{in,of}

- break out into separate repo

# X11

- [modularize `.Xresources`]( https://wiki.archlinux.org/index.php/x_resources#Include_files )
- look into [existing `.Xresources` themes]( http://www.noobslab.com/ )

## keys

- vet breaking out into separate repo
- use something better than `grp:shifts_toggle` in `keys`
- only run `xcape` over `CapsLock`, not `Control_L`
	- for some reason this doesn't work as expected, though I'm not sure why

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
