eval "$(starship init zsh)"

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/joshua/.zshrc'

autoload -Uz compinit
compinit
# Only use the 1Password agent bridge if we're in WSL
if grep -iq microsoft /proc/version; then
  source $HOME/.config/zsh/scripts/.agent-bridge.sh
fi


touch $HOME/.config/zsh/secrets.zsh
source $HOME/.config/zsh/secrets.zsh

source $HOME/.config/zsh/aliases.zsh
