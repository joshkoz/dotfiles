This is my dotfiles repo. There are many like it, but this one is mine.

My dotfiles are my best friend. It is my life. I must master it as I must master my life.

Without me, my dotfiles are useless. Without my dotfiles, I am useless. I must configure my dotfiles true. I must tweak faster than my frustrations, which are trying to slow me down. I must automate before chaos strikes. I will...

My dotfiles and I know that what counts in development is not the commits we push, the noise of our mechanical keyboard, nor the themes we make. We know that it is the efficiency that counts. We will be efficient...

My dotfiles repo is human, even as I am human, because it is my life. Thus, I will learn it as a brother. I will learn its weaknesses, its strength, its parts, its aliases, its shell scripts and its symlinks. I will keep my dotfiles repo clean and ready, even as I am clean and ready. We will become part of each other. We will...

Before God, I swear this creed. My dotfiles and I are the defenders of my workflow. We are the masters of my environment. We are the saviors of my sanity.

So be it, until there is no chaos, but peace!

# Prerequisites

Ensure [GNU Stow](https://www.gnu.org/software/stow/) is installed.

# Setup

1. Clone this Repository

2. Cd to the root of the repository and run the ./init_dotfiles.sh script. This will symlink paths into $HOME

3. Use [1password](https://developer.1password.com/docs/cli/secrets-environment-variables/) to load secrets into the environment

# How it works

The init script looks through all the directories in the root of this repo and runs stow on them with the target as $HOME.
Stow will then symlink these files into the correct location. The paths within each directory are a mirror to the paths within $HOME.
