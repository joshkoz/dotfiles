. "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.local/bin:$HOME/.bin:$HOME/.dotnet/tools"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export XDG_CONFIG_HOME=$HOME/.config
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=ghostty
export DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock
export TESTCONTAINERS_RYUK_DISABLED=true
export TESTCONTAINERS_HOST_OVERRIDE=127.0.0.1
export CLOUDSDK_PYTHON_SITEPACKAGES=1

