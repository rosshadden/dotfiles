##
## SHORTCUTS
##

export alias x = exit

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

# get public ip
export alias wimi = curl --location ipecho.net/plain

export def wimli [] {
	ip address show label enp* | rg -o '\d+\.\d+\.\d+\.\d+/\d+' | str trim
}

export alias dcp = docker-compose
