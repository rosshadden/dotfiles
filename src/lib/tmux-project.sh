#!/usr/bin/env bash

# @depends `tmux`
# @depends `tmuxp`
# @depends `fasd`
# @depends `fasd_cd`
# @depends `i3-msg`

# TODO: [handle options](http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt)
# TODO: make a "kill" or "clean" project, which kills tmux sessions
# TODO: support "filling" current session, instead of making a new session

project=${1:-$(basename $PWD)}
path=${2:-$(fasd -d $project)}
path=${path:-.}


# start in target dir
[[ $1 ]] && cd $path


# create session
# TODO: allow per-project window list overrides
# TODO: allow per-project windows/panes/commands (basically arbitrary json config)
tmuxp load -d project.json

# configure session
tmux rename-session -t project $project
# tmux set -t $project set-remain-on-exit on

# attach to session
# TODO: make optional
tmux attach-session -t $project


exit 0


# open clients on matching workspaces
# TODO: make optional
# TODO: obeying above per-project list
: '
	- project-dev
	- project-sync
	- project-hack(?)
	- project-files(?)
	- project-run
'

tmux new-session -d -t $project -s $project-dev
tmux select-window -t $project-dev:dev
i3-msg "workspace 2| dev; exec i3-sensible-terminal -e tmux attach-session -t $project-dev"

tmux new-session -d -t $project -s $project-sync
tmux select-window -t $project-sync:sync
i3-msg "workspace 3| sync; exec i3-sensible-terminal -e tmux attach-session -t $project-sync"

tmux new-session -d -t $project -s $project-run
tmux select-window -t $project-run:run
i3-msg "workspace 9| run; exec i3-sensible-terminal -e tmux attach-session -t $project-run"


# project handling:
: '
	- scratch
		- PRO: this would handle arbitrary non-preallocated projects
		- http://spin.atomicobject.com/2015/03/08/dev-project-workspace-tmux/
		- https://wiki.archlinux.org/index.php/Tmux#Clients_simultaneously_interacting_with_various_windows_of_a_session
	- [tmuxifier](https://github.com/jimeh/tmuxifier)
	- [tmuxp](https://github.com/tony/tmuxp)
	- ~~[tmuxinator](https://github.com/tmuxinator/tmuxinator)~~
	- ~~[teamocil](https://github.com/remiprev/teamocil)~~
'
