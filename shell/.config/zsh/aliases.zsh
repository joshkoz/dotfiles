alias k=kubectl
alias vim=nvim
alias open='xdg-open'
alias hstat='systemctl --user status "hypr*" waybar dunst vicinae cliphist-images cliphist-text'

bindkey -s '^f' "^utmux-sessionizer^M"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias -s md=bat
alias -s yaml="bat -l yaml"
alias -s yml="bat -l yaml"
alias -s json="jless"
alias -s conf="$EDITOR"

alias -g C='| wl-copy'
