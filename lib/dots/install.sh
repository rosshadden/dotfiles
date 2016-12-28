#!/usr/bin/env bash

source "$(dirname $0)/functions.sh"

isAnon=false
shouldDownload=false
shouldForce=false

spec=":adf"
while getopts $spec opt; do
	case "$opt" in
		a) isAnon=true ;;
		d) shouldDownload=true ;;
		f) shouldForce=true ;;
		:) error "Option '-$OPTARG' requires an argument." ;;
		*) error "Invalid option: -$OPTARG" ;;
	esac
done
shift "$((OPTIND-1))"

DOTS="${1:-$DOTS}"
configPath="${XDG_CONFIG_HOME:-$HOME/.config}"
tpmPath="$HOME/.tmux/plugins/tpm"

function fetch() {
	if [[ -d "$DOTS" ]]; then error "Skipping fetch, as '$DOTS' already exists"; fi

	echo "Downloading dotfiles into '$DOTS'."

	local repoUrl="https://github.com/rosshadden/dotfiles"
	local cloneUrl="git@github.com:rosshadden/dotfiles.git"

	if isCommand git; then
		if $isAnon; then local cloneUrl="$repoUrl.git"; fi
		git clone "$cloneUrl" "$DOTS"
	else
		wget "$repoUrl/archive/master.zip"
		mv dotfiles-master "$DOTS"
	fi

	echo
}

function init() {
	echo "Initializing git submodules..."
	pushd "$DOTS" &> /dev/null
		git submodule update --init --remote --recursive
	popd &> /dev/null

	if [[ ! -d "$tpmPath" ]]; then
		echo "Initializing tpm..."
		git clone https://github.com/tmux-plugins/tpm "$tpmPath"
	fi

	local zplugFile=$DOTS/lib/shell/zplug/init.zsh
	if [[ -f "$zplugFile" ]]; then
		echo "Initializing zplug..."
		zsh <<-eof
			source $zplugFile
			zplug install
		eof
	else
		echo "zplug not found"
	fi

	echo
}

# TODO: combine into one stanza with conditions or variables, instead of three
# TODO: handle `shouldForce`
function link() {
	echo "Linking {bin,lib} to $HOME"
	if [[ ! -e "$HOME/bin" ]]; then
		echo "Linking bin to $HOME"
		ln -s "$DOTS/bin" "$HOME"
	elif [[ ! -h "$HOME/bin" ]]; then
		echo "File already exists and is not a symlink: bin"
	else
		echo "Skipping existing node: bin"
	fi
	if [[ ! -e "$HOME/lib" ]]; then
		echo "Linking lib to $HOME"
		ln -s "$DOTS/lib" "$HOME"
	elif [[ ! -h "$HOME/lib" ]]; then
		echo "File already exists and is not a symlink: lib"
	else
		echo "Skipping existing node: lib"
	fi
	echo

	echo "Linking dotfiles to $HOME"
	for file in $DOTS/src/{,.[^.]}*; do
		local name="$(basename $file)"
		local destPath="$HOME/$name"

		# linking blacklist
		if [[ "$name" == ".config" ]]; then continue; fi
		if [[ "$name" == ".local" ]]; then continue; fi
		if [[ "$name" == "shell" ]]; then continue; fi
		if [[ "$name" == "themes" ]]; then continue; fi

		if [[ ! -e "$destPath" ]]; then
			ln -s "$file" "$HOME/"
		elif [[ ! -h "$destPath" ]]; then
			echo "File already exists and is not a symlink: $name"
		else
			echo "Skipping existing node: $name"
		fi
	done
	echo

	echo "Linking config files to $configPath..."
	for file in $DOTS/src/.config/*; do
		local name="$(basename $file)"
		local destPath="$configPath/$name"

		if [[ ! -e "$destPath" ]]; then
			ln -s "$file" "$configPath/"
		elif [[ ! -h "$destPath" ]]; then
			echo "File already exists and is not a symlink: .config/$name"
		else
			echo "Skipping existing node: .config/$name"
		fi
	done
}

if $shouldDownload; then
	fetch
elif [[ ! -d "$DOTS" ]]; then
	error "Dotfiles were not found at '$DOTS'.  Run \`dots install -f\` to fetch."
fi

init
link
