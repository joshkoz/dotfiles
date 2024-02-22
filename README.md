# Prerequisites

Ensure [GNU Stow](https://www.gnu.org/software/stow/) is installed.

# Setup

1. Clone this Repository

2. Cd to the root of the repository and run the ./init_dotfiles.sh script. This will symlink paths into $HOME

3. Use [1password](https://developer.1password.com/docs/cli/secrets-environment-variables/) to load secrets into the environment

# How it works

The init script looks through all the directories in the root of this repo and runs stow on them with the target as $HOME.
Stow will then symlink these files into the correct location. The paths within each directory are a mirror to the paths within $HOME.
