#!/usr/bin/env bash

################
# DOTFILES
################

[ -f $DOTS/THEME ] && export DOTS_THEME="$(cat $DOTS/THEME)"

################
# BINS
################

# local
export PATH=~/dotfiles/bin:~/local/bin:~/.local/bin

# work
export PATH=$PATH:~/dev/reaction/bin

# system
export PATH=$PATH:/usr/local/bin:/usr/sbin:/usr/local/sbin:/usr/bin:/bin

# perl (if installed)
if isCommand perl; then export PATH=$PATH:/usr/bin/core_perl; fi

# java (if installed)
if isCommand java; then export PATH=$PATH:$JAVA_HOME/bin; fi

# ruby (if installed)
if isCommand ruby; then export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin:~/.rvm/bin"; fi

# nim
export PATH=$PATH:~/.nimble/bin

# rust (if installed)
if isCommand rustc; then export PATH=$PATH:~/.cargo/bin; fi

# go (if installed)
if isCommand go; then export PATH=$PATH:~/go/bin; fi

# android (if installed)
[ -d "$ANDROID_HOME" ] && export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

################
# APPS
################

# nodejs
export N_PREFIX=~/local

# rust
export RUST_SRC_PATH=/usr/src/rust/src

# java
export JAVA_HOME=/usr/lib/jvm/default

# android
export ANDROID_HOME=/opt/android-sdk
export ANDROID_NDK_ROOT=/opt/android-ndk
export ANDROID_NDK_CLANG=/opt/android-ndk/toolchains/llvm/prebuilt/linux-x86_64
export ANDROID_NDK_ARM=/opt/android-ndk/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64

# ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# fzf
fzfOutput=ansi
# fzfOutput=xterm256
numLines=$(($(tput lines) * 2))
if isCommand ag; then
	export FZF_DEFAULT_COMMAND="ag --hidden -g '' --ignore=.git"
elif isCommand fd; then
	export FZF_DEFAULT_COMMAND="fd ."
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3"
export FZF_DEFAULT_OPTS="--cycle --tiebreak=length,index --bind=alt-enter:print-query,tab:toggle-up --preview='(highlight -O $fzfOutput {} || cat {}) 2> /dev/null | head -$numLines'"

# pass
export PASSWORD_STORE_GENERATED_LENGTH=16

# steam
export STEAM_COMPAT_DATA_PATH=/media/data/games/proton/

# godot
export GODOT_BIN=/usr/bin/godot

# mono
export FrameworkPathOverride=/lib/mono/4.8-api

################
# SETTINGS
################

export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir dir_writable vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs vi_mode time)

if isCommand nvim; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi
export VISUAL="termoil -- $EDITOR"
export GIT_EDITOR=$EDITOR

export BROWSER=google-chrome-stable

if [ -f "/usr/bin/termite" ]; then
	export TERMINAL=termite
elif [ -f "/usr/bin/kitty" ]; then
	export TERMINAL=kitty
else
	export TERMINAL=xterm
fi

export DEFAULT_USER=$USER

# sensible pager
export PAGER="less -FRSX"

# add timestamps to `history`
export HIST_STAMPS=yyyy-mm-dd

# big-ass search history
export HISTSIZE=65536

export GTK_MODULES=vi
export GTK_PATH=$HOME/.gtk-2.0/modules

# make gpg open in-terminal dialog
export GPG_TTY="$(tty)"

# goo=$?
# if [[ $goo == 0 ]]; then
# 	if [[ -x /usr/bin/vimpager ]]; then
# 		export PAGER=vimpager
# 	fi
# 	alias less=$PAGER
# 	alias zless=$PAGER
# fi

# enable XON/XOFF flow control
stty -ixon
