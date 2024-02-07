alias k=kubectl
alias vim=nvim

# Use eza Aliases if eza is installed 
if command -v eza &> /dev/null; then
  alias ls=eza
  alias ls='eza'                                                          # ls
  alias l='eza -lbF'
  alias ll='eza -lbGF'
  alias llm='eza -lbGd --sort=modified'
  alias la='eza -lbhHigUmuSa --time-style=long-iso --color-scale'
  alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --color-scale'
fi

bindkey -s '^f' "^utmux-sessionizer^M"

alias standby="i3lock --color=000000 && systemctl suspend"
