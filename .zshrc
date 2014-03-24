# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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
plugins=(extract git github grails node npm python nyan sublime history-substring-search tmux)
#plugins=(battery extract github grails node npm python nyan sublime vi-mode)
#bindkey -M viins 'jj' vi-cmd-mode

source $ZSH/oh-my-zsh.sh
source $HOME/Dropbox/.dots/scripts/vim.zsh
unsetopt correct_all

# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games


################################################################
# ROSS
. $HOME/Dropbox/.dots/path.sh
. $HOME/Dropbox/.dots/alias.sh
[[ -e "$HOME/.local.sh" ]] && . $HOME/.local.sh

# vi-mode stuff
KEYTIMEOUT=1


# PROMPT='%{$fg[yellow]%}λ %{$fg[green]%}${PWD/#$HOME/~} %{$fg[yellow]%}→ $(git_prompt_info)%{$reset_color%}'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"
