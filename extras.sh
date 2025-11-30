#!/usr/bin/env bash

LIST="$HOME/dotfiles/extras.txt"

if ! command -v yay &> /dev/null; then
	echo "'yay' needs to be installed"
	exit 1
fi

SELECTED=$(cat $LIST | gum choose --no-limit --height 15 --header "Select the extra packages you want to install (Space to check/uncheck, Enter to confirm)")

if [[ -z "$SELECTED" ]]; then
	echo "no packages selected"
	exit 0
fi

PACKAGES=$(echo "$SELECTED" | awk '{print $1}')
echo "Selected packages:"
printf " * %s\n" ${PACKAGES[@]}

gum confirm "¿Do you want to proceed with instalation?" && {
	echo "installing.."
	yay -S --needed $PACKAGES
} || {
	echo "canceling.."
	exit 0
}

