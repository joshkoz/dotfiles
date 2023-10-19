# Nightfly inspired tmux theme

# Status line background and foreground colors
set -g status "on"
set -g status-bg '#011627'
set -g status-fg '#d6deeb'
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "100"

# Status left and right sections
set -g status-left " [#S] | "
set -g status-right "%H:%M %d-%b-%y"

# Window status colors
setw -g window-status-style bg='#011627',fg='#57c7ff'
setw -g window-status-current-style bg='#57c7ff',fg='#011627'

# Pane border colors
set -g pane-border-style bg='#011627',fg='#57c7ff'
set -g pane-active-border-style bg='#011627',fg='#21c7a8'

# Message text
set -g message-style bg='#011627',fg='#FFEB95'

# Command prompt
set -g status-left-style fg='#d6deeb'
set -g status-right-style fg='#d6deeb'

# Clock mode
setw -g clock-mode-colour '#21c7a8'
setw -g clock-mode-style 24

# Highlight active window title in status line
set-option -g window-status-format " #{window_index}:#{pane_current_command}#{window_flags} "
set-option -g window-status-current-format " #{window_index}:#{pane_current_command}#{window_flags} "

