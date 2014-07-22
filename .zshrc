# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Path to dotfiles.
DOTS=$HOME/dotfiles

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="norm"
ZSH_THEME="ross"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse command-not-found)
plugins=(extract github grails node npm python nyan sublime history-substring-search tmux)
#plugins=(battery extract github grails node npm python nyan sublime vi-mode)

source $ZSH/oh-my-zsh.sh
source $DOTS/shell/vim.zsh
source $DOTS/shell/opp.zsh/opp.zsh
source $DOTS/shell/opp.zsh/opp/*.zsh
unsetopt correct_all

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

bindkey '^[[Z' reverse-menu-complete


################################################################
# ROSS
. $DOTS/shell/general.sh
. $DOTS/shell/path.sh
. $DOTS/shell/alias.sh
[[ -e "$HOME/.local.sh" ]] && . $HOME/.local.sh

# vi-mode stuff
KEYTIMEOUT=1

# expand .[TAB] and ..[TAB]
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"


man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
