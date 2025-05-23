eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

set -o emacs

export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000
export KEYTIMEOUT=1

unsetopt beep
setopt share_history 
setopt APPEND_HISTORY
# Immediately append history to the history file, not just when a shell exits
setopt INC_APPEND_HISTORY

# bindkey -v  # Vim mode
bindkey '^R' history-incremental-search-backward

# autoload -z edit-command-line
# zle -N edit-command-line
# bindkey '^X^E' edit-command-line

zstyle :compinstall filename '/home/joshua/.zshrc'

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
source /usr/share/nvm/init-nvm.sh

# Requires installing zsh-syntax-highlighting and zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source <(fzf --zsh)

backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    local WORDCHARS=${WORDCHARS/./}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
