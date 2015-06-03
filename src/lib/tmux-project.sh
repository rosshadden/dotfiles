#!/usr/bin/env bash

# @depends `fasd`

project=${1:-$(basename $PWD)}
path=${2:-$(fasd -d $project)}
path=${path:-.}


# TODO: possibly breakout.exe tmux pieces into a file and source it?

# make detached session
# unset TMUX
# tmux new-session -d -s $project -c $path -n dev
tmuxp load project.yaml

# populate detached session from layout
: '
	- windows
	- panes
'

# using:
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

# configure session
tmux rename-session -t project $project
tmux set -t $project set-remain-on-exit on

# open clients on workspaces (possibly specified per-project)
# TODO: [make optional](http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt)
: '
	- project-dev
	- project-sync
	- project-hack(?)
	- project-files(?)
	- project-run
'

exit 0

tmux new-session -d -t $project -s $project-dev
tmux select-window -t $project-dev:dev
i3-msg "workspace 2| dev; exec i3-sensible-terminal -e tmux attach-session -t $project-dev"

tmux new-session -d -t $project -s $project-sync
tmux select-window -t $project-sync:sync
i3-msg "workspace 3| sync; exec i3-sensible-terminal -e tmux attach-session -t $project-sync"

tmux new-session -d -t $project -s $project-run
tmux select-window -t $project-run:run
i3-msg "workspace 9| run; exec i3-sensible-terminal -e tmux attach-session -t $project-run"
