. "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.local/bin:$HOME/.bin:$HOME/.dotnet/tools"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=ghostty
export DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock
# Testcontainers settings live in ~/.testcontainers.properties (testcontainers/ package) so IDEs
# launched outside a shell pick them up too. Don't set TESTCONTAINERS_* here: env vars override that file.
export CLOUDSDK_PYTHON_SITEPACKAGES=1


# git and ssh use whichever agent ~/.ssh/agent.sock points at. A shell started by an SSH login
# with a forwarded agent takes the link over, so the connecting machine's 1Password signs and
# pushes. Once that agent is gone, the link falls back to the local 1Password agent.
if [[ $OSTYPE == linux* ]]; then
	if [[ -n $SSH_CONNECTION && -S $SSH_AUTH_SOCK && $SSH_AUTH_SOCK != $HOME/.ssh/agent.sock ]]; then
		ln -sfn "$SSH_AUTH_SOCK" "$HOME/.ssh/agent.sock"
	elif [[ ! -S $HOME/.ssh/agent.sock ]]; then
		ln -sfn "$HOME/.1password/agent.sock" "$HOME/.ssh/agent.sock"
	fi
	export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
fi
