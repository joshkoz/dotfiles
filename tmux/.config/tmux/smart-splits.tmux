####################
### Smart Splits ###
####################
# Smart pane switching with awareness of Vim splits.
# See: https://github.com/mrjones2014/smart-splits.nvim#tmux
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n C-h if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n C-j if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n C-k if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n C-l if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

bind-key -n C-Left if-shell "$is_vim" 'send-keys C-Left' 'resize-pane -L 3'
bind-key -n C-Down if-shell "$is_vim" 'send-keys C-Down' 'resize-pane -D 3'
bind-key -n C-Up if-shell "$is_vim" 'send-keys C-Up' 'resize-pane -U 3'
bind-key -n C-Right if-shell "$is_vim" 'send-keys C-Right' 'resize-pane -R 3'

tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\' select-pane -l

