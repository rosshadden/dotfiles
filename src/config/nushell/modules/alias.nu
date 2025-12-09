##
## SHORTCUTS
##

export alias x = exit
export alias h = help

##
## EDITING
##

export alias e = nvim
export alias se = sudo -E nvim

##
## APPS
##

# git
export alias g = git
export alias tigs = tig status
export alias tigr = tig $"(git rev-parse HEAD | str trim)..(git rev-parse FETCH_HEAD | str trim)"

# tmux
export alias tl = tmux list-sessions

# zoxide
export alias d = zoxide query

##
## ENV
##

# TODO: consider migrating to an env
export alias sshc = ssh -i ~/.ssh/cuda

##
## MISC
##

export alias dcp = docker-compose
