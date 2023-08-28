if status is-interactive
    # Commands to run in interactive sessions can go here
end

function on_cancel --on-event fish_cancel
    # Override default behavior and do nothing
end

set -U fish_greeting

starship init fish | source

bind \e\[1\;Pf forward-word
bind \e\[1\;Pb backward-word
bind \cb backward-word
bind \cf forward-word


