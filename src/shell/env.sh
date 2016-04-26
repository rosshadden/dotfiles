################
# BINS
################

# local
export PATH=$HOME/bin:$HOME/local/bin

# system
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin/:/bin

# perl (if installed)
[[ -f "/usr/bin/perl" ]] && export PATH=$PATH:/usr/bin/core_perl

# java (if installed)
[[ -f "/usr/bin/java" ]] && export PATH=$PATH:$JAVA_HOME/bin

# android (if installed)
[[ -d "$ANDROID_HOME" ]] && export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# ruby (if installed)
[[ -f "/usr/bin/ruby" ]] && export PATH="$PATH:`ruby -e 'puts Gem.user_dir'`/bin:$HOME/.rvm/bin"

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
fpath=($DOTS/src/shell/completions/functions $fpath)

# ranger
export RANGER_LOAD_DEFAULT_RC=false

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
