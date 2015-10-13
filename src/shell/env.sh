################
# BINS
################

	# local
	export PATH=$HOME/bin:$HOME/local/bin
	# global
	export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin
	# perl (if installed)
	[[ -f /usr/bin/perl ]] && export PATH=$PATH:/usr/bin/core_perl
	# ruby (if installed)
	[[ -f /usr/bin/ruby ]] && export PATH="$PATH:`ruby -e 'puts Gem.user_dir'`/bin:$HOME/.rvm/bin"
	# java (if installed)
	[[ -f /usr/bin/java ]] && export PATH=$PATH:$JAVA_HOME/bin
	# android
	export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools


################
# PATHS
################

	# java
	export JAVA_HOME=/usr/lib/jvm/default
	# android
	export ANDROID_HOME=/opt/android-sdk
	export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64
	# atom plugins
	export ATOM_REPOS_HOME=$DB/dev/forks

	fpath=($DOTS/src/shell/completions/functions $fpath)


################
# DEFAULTS
################

	export EDITOR=vim


################
# MISC
################

	# used by some zsh themes (ex: agnoster)
	export DEFAULT_USER=$USER

	# sensible terminal
	export TERMINAL=urxvt

	# sensible pager
	export PAGER="less -FRSX"

	# big-ass search history
	export HISTSIZE=65536

	# enable XON/XOFF flow control
	stty -ixon
