#!/usr/bin/env bash

namespace=$1
action=$2


bind() {
	for key in $keys; do
		tmux bind -n $key run "~/lib/tmux-cords.sh $namespace $key"
	done

	# allow exiting with escape
	tmux bind -n Escape run "~/lib/tmux-cords.sh $namespace Escape"
}


unbind() {
	for key in $keys; do
		tmux unbind -n $key
	done

	tmux unbind -n Escape
}


getSession() {
	tmux display -p '#S'
}


case $namespace in

	session)
		keys="Space n N c C d D"

		if [ -z $action ]; then
			bind
		else
			case $action in
				Space) tmux choose-tree ;;

				n) tmux command-prompt -p "New session:" "new-session -A -s %%" ;;
				N) tmux command-prompt -p "New session:" "new-session -A -s %% -t `getSession`" ;;

				c) tmux confirm kill-session ;;
				C) tmux kill-session ;;

				d) tmux detach ;;
				D) tmux detach -s `getSession` ;;
			esac

			unbind
		fi
	;;


	buffer)
		keys="j k h l J K H L c C"

		if [ -z $action ]; then
			bind
		else
			case $action in
				j) tmux split-window -v -c "#{pane_current_path}" ;;
				k) tmux split-window -v -c "#{pane_current_path}"; tmux swap-pane -U ;;
				h) tmux split-window -h -c "#{pane_current_path}"; tmux swap-pane -U ;;
				l) tmux split-window -h -c "#{pane_current_path}" ;;

				J) tmux swap-pane -D ;;
				K) tmux swap-pane -U ;;
				H) tmux swap-pane -U ;;
				L) tmux swap-pane -D ;;

				c) tmux confirm kill-pane ;;
				C) tmux kill-pane ;;
			esac

			unbind
		fi
	;;


	window)
		keys="h l Space n p c C"

		if [ -z $action ]; then
			bind
		else
			case $action in
				h) tmux previous-window ;;
				l) tmux next-window ;;

				Space) tmux choose-window ;;

				n) tmux new-window -a ;;
				p) tmux new-window -a; tmux swap-window -t -1 ;;

				c) tmux confirm kill-window ;;
				C) tmux kill-window ;;
			esac

			unbind
		fi
	;;

esac
