#!/usr/bin/env bash

# @depends `fasd`

project=${1:-$(basename $PWD)}
path=${2:-$(fasd -d $project)}
path=${path:-.}


# TODO: possibly breakout.exe tmux pieces into a file and source it?

# make detached session
unset TMUX
tmux new-session -d -s $project -c $path -n dev

# populate detached session from layout
: '
	- windows
		- maybe even name them and turn off the auto-name
	- panes
'

# using:
: '
	- scratch
		- PRO: this would handle arbitrary non-preallocated projects
		- http://spin.atomicobject.com/2015/03/08/dev-project-workspace-tmux/
		- https://wiki.archlinux.org/index.php/Tmux#Clients_simultaneously_interacting_with_various_windows_of_a_session
	- [tmuxinator](https://github.com/tmuxinator/tmuxinator)
	- [tmuxifier](https://github.com/jimeh/tmuxifier)
	- [teamocil](https://github.com/remiprev/teamocil)
	- [tmuxp](https://github.com/tony/tmuxp)
'

# configure session
tmux set -t $project set-remain-on-exit on

# open windows
tmux new-window -d -t $project -c $path -n sync
tmux new-window -d -t $project -c $path -n run

# immunize
# TODO: WHY??!?!?
tmux send-keys -t $project:dev 'zsh' ENTER
tmux send-keys -t $project:sync 'zsh' ENTER
tmux send-keys -t $project:run 'zsh' ENTER

# run commands
tmux send-keys -t $project:dev 'vim' ENTER
tmux send-keys -t $project:sync 'tig' ENTER

# open clients on workspaces (possibly specified per-project)
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
