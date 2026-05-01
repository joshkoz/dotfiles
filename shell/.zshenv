. "$HOME/.cargo/env"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/.bin:$HOME/.dotnet/tools:$HOME/.local/share/gem/ruby/3.0.0/bin"
export PATH="$HOME/.local/share/npm/bin:$PATH"
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

