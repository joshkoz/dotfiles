# --> Catppuccin (Mocha)
thm_fg="#cdd6f4"
thm_cyan="#89dceb"
thm_black="#181825"
thm_gray="#313244"
thm_magenta="#cba6f7"
thm_pink="#f5c2e7"
thm_red="#f38ba8"
thm_green="#a6e3a1"
thm_yellow="#f9e2af"
thm_blue="#89b4fa"
thm_orange="#fab387"
thm_black4="#585b70"

# status
set -g status "on"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-style fg=default,bg=default

# Status left and right sections
set -g status-left "#[fg=${thm_black4},bg=default] #{session_name} | "

# messages
set -g message-style "fg=${thm_cyan},bg=default,align=centre"
set -g message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

# panes
set -g pane-border-style "fg=${thm_gray}"
set -g pane-active-border-style "fg=${thm_blue}"

# windows
setw -g window-status-activity-style "fg=${thm_fg},bg=default,none"
setw -g window-status-separator ""
setw -g window-status-style "fg=${thm_fg},bg=default,none"
setw -g window-status-current-style "fg=${thm_magenta},bold"

set-option -g window-status-format "#{window_index}:#{pane_current_command}#{window_flags} "
set-option -g window-status-current-format "#{window_index}:#{pane_current_command}#{window_flags} "

