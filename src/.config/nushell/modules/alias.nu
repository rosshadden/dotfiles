##
## SHORTCUTS
##

export alias l = (ls -la | select name type target size modified)

##
## EDITING
##

export alias e = ^$env.EDITOR
export alias se = sudo $env.EDITOR

##
## APPS
##

# git
export alias g = git
export alias tigs = tig status
export alias tigr = tig $"(git rev-parse HEAD | str trim)..(git rev-parse FETCH_HEAD | str trim)"

# tmux
export alias tl = tmux list-sessions

# zellij
export alias z = zellij

##
## MISC
##

# get public ip
export alias wimi = curl ipecho.net/plain
