# ~/.bash_profile

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -d "$HOME/.local/bin" ]]; then
	export PATH="$HOME/.local/bin/:$PATH"
fi

# For go install..
#if [[ -d "$HOME/go/bin" ]]; then
#	export PATH="$HOME/go/bin:$PATH"
#fi

