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
		keys="Space n N c C d D r"

		if [ -z $action ]; then
			bind
		else
			case $action in
				# choose
				Space) tmux choose-tree ;;

				# new
				n) tmux command-prompt -p "New session:" "new-session -A -s %%" ;;
				N) tmux command-prompt -p "New session:" "new-session -A -s %% -t `getSession`" ;;

				# close
				c) tmux confirm kill-session ;;
				C) tmux kill-session ;;

				# detach
				d) tmux detach ;;
				D) tmux detach -s `getSession` ;;

				# rename
				r) tmux command-prompt -p "Rename session:" "rename-session %%" ;;
			esac

			unbind
		fi
	;;


	window)
		keys="Space h l n p c C r"

		if [ -z $action ]; then
			bind
		else
			case $action in
				# choose
				Space) tmux choose-window ;;

				# navigate
				h) tmux previous-window ;;
				l) tmux next-window ;;

				# new
				n) tmux new-window -a ;;
				p) tmux new-window -a; tmux swap-window -t -1 ;;

				# close
				c) tmux confirm kill-window ;;
				C) tmux kill-window ;;

				# rename
				r) tmux command-prompt -p "Rename window:" "rename-window %%" ;;
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
				# navigate
				j) tmux split-window -v -c "#{pane_current_path}" ;;
				k) tmux split-window -v -c "#{pane_current_path}"; tmux swap-pane -U ;;
				h) tmux split-window -h -c "#{pane_current_path}"; tmux swap-pane -U ;;
				l) tmux split-window -h -c "#{pane_current_path}" ;;

				# swap
				J) tmux swap-pane -D ;;
				K) tmux swap-pane -U ;;
				H) tmux swap-pane -U ;;
				L) tmux swap-pane -D ;;

				# close
				c) tmux confirm kill-pane ;;
				C) tmux kill-pane ;;
			esac

			unbind
		fi
	;;

esac
