# Coding-agent workflow. Sourced after the theme so it can extend the theme's formats.
# Drop the source-file line in tmux.conf to turn all of this off.

# Shift+Enter for multi-line prompts in Claude Code.
set -as terminal-features 'xterm*:extkeys'

# Per-window agent state, set by agent-tmux (from Claude Code hooks in ~/.claude/settings.json).
agent_icon="#{?#{==:#{@agent},wait},#[fg=red bold]! ,#{?#{==:#{@agent},busy},#[fg=yellow]◐ ,#{?#{==:#{@agent},done},#[fg=green]✓ ,}}}"
setw -ga window-status-format "${agent_icon}"
setw -ga window-status-current-format "${agent_icon}"

# Same icons in the session and window trees (prefix s / prefix w). Session rows list one icon per Claude window.
tree_format="#{?pane_format,#{pane_current_command},#{?window_format,${agent_icon}#[default]#{window_name}#{window_flags},#{session_windows} windows#{?session_attached, (attached),}  #{W:${agent_icon}}#[default]}}"
bind s choose-tree -Zs -F "${tree_format}"
bind w choose-tree -Zw -F "${tree_format}"

# Agent counts across every session, so you can see an agent needs you from anywhere.
set -ga status-right "#(agent-tmux summary)"

# Looking at a finished agent's window marks it as seen.
set-hook -g 'session-window-changed[50]' 'if -F "#{==:#{@agent},done}" "set -w @agent idle"'
set-hook -g 'client-session-changed[50]' 'if -F "#{==:#{@agent},done}" "set -w @agent idle"'

# Jump to an agent, waiting ones first.
bind C-g display-popup -E -w 70% -h 50% "agent-tmux pick"
# Live pane of this window's Claude Code background tasks (shell tasks and background agents).
bind T split-window -d -h -l 40% "agent-tmux tasks"
# Claude Code's own overview of every running session.
bind A display-popup -E -w 90% -h 90% "claude agents"
