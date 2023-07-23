alias k=kubectl


# Use Exa Aliases if exa is installed 
if command -v exa &> /dev/null; then
  alias ls=exa
  alias ls='exa'                                                          # ls
  alias l='exa -lbF'
  alias ll='exa -lbGF'
  alias llm='exa -lbGd --sort=modified'
  alias la='exa -lbhHigUmuSa --time-style=long-iso --color-scale'
  alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --color-scale'
fi
