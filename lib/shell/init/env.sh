#!/usr/bin/env sh

################
# DOTFILES
################

export DOTS_THEME="$(cat $DOTS/THEME)"

################
# BINS
################

# local
export PATH=~/bin:~/local/bin

# system
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin

# perl (if installed)
if isCommand perl; then export PATH=$PATH:/usr/bin/core_perl; fi

# java (if installed)
if isCommand java; then export PATH=$PATH:$JAVA_HOME/bin; fi

# nimble (if installed)
if isCommand nimble; then export PATH=$PATH:~/.nimble/bin; fi

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
if isCommand pt; then
	export FZF_DEFAULT_COMMAND="pt -g ''"
elif isCommand ag; then
	export FZF_DEFAULT_COMMAND="ag --hidden -g '' --ignore=.git"
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3"
export FZF_DEFAULT_OPTS="--cycle --tiebreak=length,index --bind=alt-enter:print-query,tab:toggle-up --preview='(highlight -O $fzfOutput {} || cat {}) 2> /dev/null | head -$numLines'"

# pass
export PASSWORD_STORE_GENERATED_LENGTH=16

################
# SETTINGS
################

if [ -f "/usr/bin/nvim" ]; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi
export GIT_EDITOR=$EDITOR

export VISUAL=atom

export BROWSER=google-chrome-stable

[ -f "/usr/bin/termite" ] && export TERMINAL=termite || export TERMINAL=xterm

export DEFAULT_USER=$USER

# sensible pager
export PAGER="less -FRSX"

# add timestamps to `history`
export HIST_STAMPS=yyyy-mm-dd

# big-ass search history
export HISTSIZE=65536

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
