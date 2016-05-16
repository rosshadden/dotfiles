################
# BINS
################

# local
export PATH=~/bin:~/local/bin

# system
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin/:/bin

# perl (if installed)
[[ -f "/usr/bin/perl" ]] && export PATH=$PATH:/usr/bin/core_perl

# java (if installed)
[[ -f "/usr/bin/java" ]] && export PATH=$PATH:$JAVA_HOME/bin

# android (if installed)
[[ -d "$ANDROID_HOME" ]] && export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# ruby (if installed)
[[ -f "/usr/bin/ruby" ]] && export PATH="$PATH:`ruby -e 'puts Gem.user_dir'`/bin:~/.rvm/bin"

################
# APPS
################

# nodejs
export N_PREFIX=~/local

# java
export JAVA_HOME=/usr/lib/jvm/default

# android
export ANDROID_HOME=/opt/android-sdk
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64

# fasd
fpath=($DOTS/lib/shell/completions/functions $fpath)
# TODO: this does not work
# if [[ -f "$XDG_DATA_HOME/nvim/shada/main.shada" ]]; then
# 	export _FASD_VIMINFO="$XDG_DATA_HOME/nvim/shada/main.shada"
# fi

# ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# fzf
export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -g ''"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

################
# SETTINGS
################

export EDITOR=nvim

export VISUAL=gvim

export BROWSER=google-chrome-stable

[[ -f "/usr/bin/termite" ]] && export TERMINAL=termite || export TERMINAL=xterm

export DEFAULT_USER=$USER

# sensible pager
export PAGER="less -FRSX"

# big-ass search history
export HISTSIZE=65536

# enable XON/XOFF flow control
stty -ixon
