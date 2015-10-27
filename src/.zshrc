################
# VARIABLES
# TODO: breakout.exe
################

# dots
export DOTS=$HOME/dotfiles
# sync
export SYNC=$HOME/sync
# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
# dropbox
export DB=$HOME/Dropbox

# shell dir
shellDir=$DOTS/src/shell
# themes dir
themeDir=$DOTS/src/themes


################
# OPTIONS
################

# command correction
setopt correct


################
# CONFIG
################

# dots displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# better zsh correction prompt
SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? ([y]es, [n]o, [a]bort, [e]dit) "


################
# MODULES
################

source $shellDir/env.sh
source $shellDir/colors.sh
source $shellDir/alias.sh
source $shellDir/functions.sh
source $shellDir/general.sh
[[ -f ~/local/.zshrc ]] && source ~/local/.zshrc


################
# MAPPINGS
################

# fix shift-tab in completion menus
bindkey -a '	' menu-expand-or-complete

# fix shift-tab in completion menus
bindkey '^[[Z' reverse-menu-complete


################
# THEME
################

# NOTE: overwritten below
ZSH_THEME="agnoster"


# base16 colors
if [ "${TERM%%-*}" = 'linux' ]; then
	BASE16_TYPE="vconsole"
else
	BASE16_TYPE="shell"
fi

THEME="pop"
BASE16_VARIANT="dark"
BASE16_DIR="$themeDir/base16-builder/output/$BASE16_TYPE"
BASE16_SHELL="$BASE16_DIR/base16-$THEME.$BASE16_VARIANT.sh"

[[ -f $BASE16_SHELL ]] && . $BASE16_SHELL


# airline prompt
. $themeDir/promptline.sh


################
# FEATURES
################

source $shellDir/features.zsh


################
# PLUGINS
################

plugins=(archlinux battery extract git-extras node npm python nyan history-substring-search systemd fasd)

. $ZSH/oh-my-zsh.sh
. $shellDir/plugins/vim.zsh

# tmuxp
source tmuxp.zsh

# TODO: move to standalone file, merged with shell/plugins/vim.zsh
# expand
bindkey '^f' vi-forward-blank-word
bindkey '^[f' vi-forward-char
bindkey '^b' vi-backward-blank-word
bindkey '^[b' vi-backward-char


################
# TERMINAL
################

# Make special keys work
	# create a zkbd compatible hash;
	# to add other keys to this hash, see: man 5 terminfo
	typeset -A key

	key[Home]=${terminfo[khome]}
	key[End]=${terminfo[kend]}
	key[Insert]=${terminfo[kich1]}
	key[Delete]=${terminfo[kdch1]}
	key[Up]=${terminfo[kcuu1]}
	key[Down]=${terminfo[kcud1]}
	key[Left]=${terminfo[kcub1]}
	key[Right]=${terminfo[kcuf1]}
	key[PageUp]=${terminfo[kpp]}
	key[PageDown]=${terminfo[knp]}

	# setup key accordingly
	if [[ -n "${key[End]}"      ]]; then bindkey  "${key[End]}"      end-of-line; fi
	if [[ -n "${key[Insert]}"   ]]; then bindkey  "${key[Insert]}"   overwrite-mode; fi
	if [[ -n "${key[Delete]}"   ]]; then bindkey  "${key[Delete]}"   delete-char; fi
	if [[ -n "${key[Up]}"       ]]; then bindkey  "${key[Up]}"       up-line-or-history; fi
	if [[ -n "${key[Down]}"     ]]; then bindkey  "${key[Down]}"     down-line-or-history; fi
	if [[ -n "${key[Left]}"     ]]; then bindkey  "${key[Left]}"     backward-char; fi
	if [[ -n "${key[Right]}"    ]]; then bindkey  "${key[Right]}"    forward-char; fi
	if [[ -n "${key[PageUp]}"   ]]; then bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history; fi
	if [[ -n "${key[PageDown]}" ]]; then bindkey  "${key[PageDown]}" end-of-buffer-or-history; fi

	# Finally, make sure the terminal is in application mode, when zle is active.
	# Only then are the values from $terminfo valid.
	if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
		function zle-line-init () {
			printf '%s' "${terminfo[smkx]}"
		}
		function zle-line-finish () {
			printf '%s' "${terminfo[rmkx]}"
		}
		zle -N zle-line-init
		zle -N zle-line-finish
	fi


# VI-MODE
# TODO: breakout.exe

vim_ins_mode="INSERT"
vim_cmd_mode="NORMAL"
vim_mode=$vim_ins_mode

zle-keymap-select() {
	vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
	__promptline
	zle reset-prompt

	if [ "$TERM" != "linux" ]; then
		if [ $KEYMAP = vicmd ]; then
			set-prompt $colors[normal2] 2
		else
			set-prompt $colors[insert2] 2
		fi
	fi
};
zle -N zle-keymap-select

function zle-line-finish {
	vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function TRAPINT() {
	vim_mode=$vim_ins_mode
	return $(( 128 + $1 ))
}


# INIT

zle-line-init () {
	# RESET
	zle -K viins
	set-prompt $colors[insert2] 2

	# Enable autosuggestions automatically
	# zle autosuggest-start
};
zle -N zle-line-init
