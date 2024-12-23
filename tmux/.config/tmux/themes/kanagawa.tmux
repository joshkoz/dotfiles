
# --> Kanagawa
# thm_bg="#16161d"
thm_bg="#1f1f28" 
# thm_bg="#15141A"
thm_fg="#dcd7ba"
thm_cyan="#6a9589"
thm_black="#090618"
thm_gray="#363646"
thm_magenta="#957fb8"
thm_pink="#938aa9"
thm_red="#c34043"
thm_green="#76946a"
thm_yellow="#c0a36e"
thm_blue="#7e9cd8"
thm_orange="#ffa066"
thm_altblack="#727169"

# status
set -g status "on"
set -g status-bg "${thm_bg}"
set -g status-justify "left"
set -g status-left-length "100"
set -g status-right-length "150"

# messages
set -g message-style "fg=${thm_orange},bg=${thm_gray},align=centre"
set -g message-command-style "fg=${thm_orange},bg=${thm_gray},align=centre"

# panes
set -g pane-border-style "fg=${thm_gray}"
set -g pane-active-border-style "fg=${thm_blue}"

# windows
setw -g window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
setw -g window-status-separator ""
setw -g window-status-style "fg=${thm_fg},bg=${thm_bg},none"

#  Modes
setw -g clock-mode-colour "${thm_blue}"
setw -g mode-style "fg=${thm_orange} bg=${thm_gray} bold"

date_time="$(get_tmux_option "@kanagawa_date_time" "%H:%M")"

# These variables are the defaults so that the setw and set calls are easier to parse.
git_branch="#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)"

show_directory="#[fg=$thm_green,bg=$thm_gray]  #{pane_current_path} #{?$git_branch,#[fg=$thm_fg]on #[fg=$thm_magenta] $git_branch,}"

show_session="#{?client_prefix,#[fg=$thm_orange],#{?pane_in_mode,#[fg=$thm_orange],#[fg=$thm_fg]}}#[bg=$thm_bg] #S | "

window_status_format="#[fg=$thm_fg,bg=$thm_bg,italics] #I: #W "

window_status_current_format="#[fg=$thm_fg,bg=$thm_gray] #I: #W "


set -g status-left "${show_session} "
set -g status-right " #[fg=$thm_fg,bg=$thm_bg]  #(whoami)@#H  #[fg=$thm_orange,bg=$thm_bg] "

setw -g window-status-format "${window_status_format}"
setw -g window-status-current-format "${window_status_current_format}"

