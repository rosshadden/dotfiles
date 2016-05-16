#!/usr/bin/env bash

tmuxline=~/dotfiles/lib/themes/tmuxline.conf

# tmuxline
[ -f $tmuxline ] && tmux source $tmuxline

# prepend prefix
tmux set -g status-left "#{prefix_highlight}$(tmux show -gvq status-left)"
