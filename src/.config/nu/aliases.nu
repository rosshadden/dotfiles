##
## SHORTCUTS
##

alias l = ls -la

##
## EDITING
##

alias e = ^$nu.env.EDITOR
alias se = sudo $nu.env.EDITOR

##
## APPS
##

# git
alias g = git
alias tigs = tig status
alias tigr = tig \$(git rev-parse HEAD)..\$(git rev-parse FETCH_HEAD)
# alias tigr- = tigr --no-merges

# tmux
alias tl = tmux list-sessions

##
## MISC
##

# get public ip
alias wimi = curl ipecho.net/plain
