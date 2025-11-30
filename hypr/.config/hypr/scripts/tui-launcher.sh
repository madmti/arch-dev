#!/usr/bin/env bash

j4-dmenu-desktop --dmenu="fzf \
	--reverse \
	--border=rounded \
	--margin=1% \
	--color=dark \
	--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl:#d858fe \
	--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef \
	--prompt='Seach: ' \
	--pointer='>' \
	--header='App Launcher' \
	" \
	--term="kitty"

