eval "$(starship init zsh)"

# Only use the 1Password agent bridge if we're in WSL
if grep -iq microsoft /proc/version; then
  source $HOME/.config/zsh/scripts/.agent-bridge.sh
fi


touch $HOME/.config/zsh/secrets.zsh
source $HOME/.config/zsh/secrets.zsh

source $HOME/.config/zsh/aliases.zsh
