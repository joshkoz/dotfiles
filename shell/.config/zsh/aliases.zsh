alias k=kubectl
alias vim=nvim

bindkey -s '^f' "^utmux-sessionizer^M"

alias standby="i3lock --color=000000 && systemctl suspend"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias hstat='systemctl --user status "hypr*" waybar dunst vicinae cliphist-images cliphist-text'
