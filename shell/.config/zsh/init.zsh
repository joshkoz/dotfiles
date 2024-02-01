eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
unsetopt beep
setopt share_history 
setopt APPEND_HISTORY
# Immediately append history to the history file, not just when a shell exits
setopt INC_APPEND_HISTORY

bindkey -v
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=1
 
zstyle :compinstall filename '/Users/joshua/.zshrc'

autoload -Uz compinit
compinit

# pnpm
export PNPM_HOME="/home/joshua/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

touch $HOME/.config/zsh/secrets.zsh
source $HOME/.config/zsh/secrets.zsh

source $HOME/.config/zsh/aliases.zsh
# source /usr/share/nvm/init-nvm.sh

# Requires installing zsh-syntax-highlighting and zsh-autosuggestions
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
