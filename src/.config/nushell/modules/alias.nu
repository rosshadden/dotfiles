##
## SHORTCUTS
##

export alias l = ls -la
export alias nud = ~/dev/forks/nushell/target/debug/nu

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
# alias tigr- = tigr --no-merges

# tmux
export alias tl = tmux list-sessions

# zellij
export alias z = zellij

##
## MISC
##

# get public ip
export alias wimi = curl ipecho.net/plain
