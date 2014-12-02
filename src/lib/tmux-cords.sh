#!/usr/bin/env bash

section=$1
# action=$2

case $section in
	# buffers
	buffer)
		read -r -n 1 -t 10 action
		tmux display "[$action]"

		case $action in
			j) tmux split-window -v -c "#{pane_current_path}" ;;
			k) tmux split-window -v -c "#{pane_current_path}"; tmux swap-pane -U ;;
			h) tmux split-window -h -c "#{pane_current_path}"; tmux swap-pane -U ;;
			l) tmux split-window -h -c "#{pane_current_path}" ;;
		esac
	;;
	o) tmux new-window -n imap -t 10 offlineimap.sh -o ;;
	m) tmux new-window -n mod ncmpcpp ;;
	w) tmux new-window -n vw vimwiki ;;
esac
