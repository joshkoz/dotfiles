# Prerequisites

Ensure [GNU Stow](https://www.gnu.org/software/stow/) is installed.
Ensure [AstroNvim](https://astronvim.com/) is setup.

# Setup

1. Clone this Repository

2. Cd to the root of the repository and run the ./init_dotfiles.sh script. This will symlink

3. Optionally copy shell/.config/zsh/secrets.template to shell/.config/zsh/secrets.zsh and set the secrets.

# How it works

The init script looks through all the directories in the root of this repo and runs stow on them with the target as $HOME.
Stow will then symlink these files into the correct location. The paths within each directory are a mirror to the paths within $HOME.
