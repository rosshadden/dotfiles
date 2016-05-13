# meta

- trim down as much fat as possible
- look into [these dotfiles](https://github.com/xero/dotfiles) for sexiness
- README
	- improve/update
	- screenshots
- make `update` announce uncommitted changes in `dotfiles` and `sync`
- swap `~/{bin,lib}` and `~/local/{bin,lib}`

## install

- [support arguments](http://wiki.bash-hackers.org/howto/getopts_tutorial)
	- `--anon`
	- `--cli`: non-X mode (no need to install i3 things on a server, for example)
- vet using a `Makefile`
- call `dots update` from systemd service
- possibly make a (generated? githook?) manifest file, to make cleanup easier

# docs

- meta (kind of pun), as in keyboard layout, remapped keys, etc.
- vim setup
- git aliases
- i3 workflow
- tig workflow
- vifm workflow

# apps

## `vim`

- make variable for the vim path, and use it everywhere we have paths to it
	- [like this](http://arusahni.net/blog/2015/04/switching-to-neovim-part-2.html)
- add mapping when searching to jump to the result but clear the highlighting
- figure out where I can use `on_cmd` in `packages.vim`
- conditionally include packages, based on dependencies
	- @ex taskwarrior
- modes
	- `[F] file` mode, for the specific file opened
	- buffer
		- mapping to delete all unused buffers (not just empty)
	- javascript
		- make mappings for opening the test for the current file (and vice versa)
	- ember
	- diff
		- :LineDiff
		- :DiffChanges
		- :git diff
	- sessions
		- fix and/or make stuff that actually works
	- files
		- make a mapping or mode for finding files not in the repo
- plugins
	- see if I can make [this](https://github.com/easymotion/vim-easymotion/issues/248#issuecomment-156444426) happen
		- map `.` in target select mode
	- pluginify my modes
	- remove redundant or unused plugins

## `i3`

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

### i3-blocks-contrib

- screen brightness
- fix keyboard block interaction
- give blocks state
	- combine `df` instances, and cycle with mousewheel

## `tmux`

- Raws, Private Investigator
	- fix prefix not showing in status on first launch
		- probably because of the vim/airline stuff
	- figure out why exiting one session sometimes switches to another
- use `choose-session` to pick a session to link current session to

## `tig`

- spend time making it even more useful
- universalize mappings
- investigate [wiki binds](https://github.com/jonas/tig/wiki/Bindings)
- mappings
	- make h/l go left/right
		- bind the current h/l to something else
	- scrap
	- stash / pop
		- per file
		- all
	- checkout tags
		- the main checkout bind should probably just support tags too

## `ranger`

- make equivalents to `vifm`'s `cw` and `cW`

## `vifm`

- add support for opening with `vim --servername`, for use with tmux sidebar
- add bind to essentially run `fasd`
- revisit binds
- add specific configs, launched with `-c "source /path/to/config"`
	- tmux
		- make explorer open files in vim instance
	- vim
- [bind to mime types](https://github.com/vifm/vifm/issues/150)

## `spacefm`

- plugins

## `copyq`

- make it use my dotfiles theme
- figure out why URLs are duplicated

## `zeal`

- integrate into workflow
- figure out wtf keeps going wrong with the i3 shortcut, and fix it

## `dunst`

- make context menu entry for copying contents to clipboard

# shell

- make `for-in` and `for-of` observe aliases
- add `-n` arg to `copy` to strip out `\n`s
- add `tcd` function, which `cd`s into a dir and renames the tmux session to that
	- should possibly share code with `tp` and `ta`, to determine the session name
- utilize zsh-functional for my wrappers
- wrap aliases and functions in `if [[ -x \`which <cmd>\` ]]` blocks

## zsh

- use [zsh-functional](https://github.com/Tarrasch/zsh-functional) instead of `for-in` and `for-of`
	- contribute to them, adding things mine do, or at least use them in mine
- refactor `.zshrc`
	- modularize
		- make semantic modules instead of a file for aliases and a file for functions (for example)
	- look into [built-in functions](https://github.com/zsh-users/zsh/tree/master/Functions/Zle)
	- look into [better status indicator](http://ivyl.0xcafe.eu/2013/02/03/refining-zsh/#vi_mode_status_indicator)
	- split `features.zsh` into files
- make mapping to insert newline at cursor
- Add `fzf` functions or aliases
- revisit aliases
	- introduce `ls -1`
- make cursor changes update when focus changes (between tmux panes with vim and zsh)

## bash

- make sure bash works, even though I haven't used it in years

# X11

- modularize `.Xresources`
- use something better than `grp:shifts_toggle` in `keys`
- only run `xcape` over `CapsLock`, not `Control_L`
	- for some reason this doesn't work as expected, though I'm not sure why
- look into existing `.Xresources` themes
	- http://www.noobslab.com/
- monitors
	- handle hot-plugging monitors
	- make monitors not enter standby when WE'RE WATCHING A SHOW, FOR CRYING OUT LOUD

# Owmni / Awmni

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

# misc

- make tropes/mappings consistent across programs
