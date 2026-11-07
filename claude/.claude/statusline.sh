#!/usr/bin/env bash
# Claude Code status line: model and context used on the left, plan usage on the right.
# Example: Opus 5.5 high · ctx 42%          5h ━━━───── 31% ↻2h14m   7d ━━━━━━━─ 85% ↻3d4h
#
# Plan usage only arrives after a session's first reply, but it's account-wide,
# so the last values seen by any session are cached and shown until then.

export LC_ALL=C.UTF-8
cache=${XDG_CACHE_HOME:-$HOME/.cache}/claude-statusline/rate-limits.json

input=$(cat)

if jq -e '.rate_limits.five_hour or .rate_limits.seven_day' >/dev/null 2>&1 <<<"$input"; then
    mkdir -p "$(dirname "$cache")"
    tmp=$(mktemp "$cache.XXXXXX")
    jq '.rate_limits' <<<"$input" >"$tmp" && mv "$tmp" "$cache"
    limits=$(jq -c '.rate_limits' <<<"$input")
else
    limits=$(cat "$cache" 2>/dev/null || echo '{}')
fi

# Unit separator rather than tab: read collapses consecutive tabs, which would shift empty fields.
IFS=$'\x1f' read -r ctx model effort five five_reset seven seven_reset < <(jq -r --argjson limits "$limits" --argjson now "$(date +%s)" '
    def live(w): w and (w.resets_at // 0) > $now;
    def pct(w): if live(w) then (w.used_percentage | floor) else "" end;
    def remaining(w): if live(w) then (w.resets_at - $now) else "" end;
    [
        (.context_window.used_percentage // "" | if . == "" then . else floor end),
        (.model.display_name // ""),
        (.effort.level // ""),
        pct($limits.five_hour), remaining($limits.five_hour),
        pct($limits.seven_day), remaining($limits.seven_day)
    ] | map(tostring) | join("\u001f")' <<<"$input")

dim=$'\e[2m'
reset=$'\e[0m'

# Green below 60%, yellow below 80%, red above.
colour() {
    if (($1 >= 80)); then
        printf '\e[31m'
    elif (($1 >= 60)); then
        printf '\e[33m'
    else
        printf '\e[32m'
    fi
}

level() {
    if [[ -z $2 ]]; then
        printf '%s%s –%s' "$dim" "$1" "$reset"
    else
        printf '%s%s %s%%%s' "$(colour "$2")" "$1" "$2" "$reset"
    fi
}

# 37m, 2h14m or 3d4h until a window resets.
duration() {
    local s=$1
    if ((s < 60)); then
        printf '<1m'
    elif ((s < 3600)); then
        printf '%dm' $((s / 60))
    elif ((s < 86400)); then
        printf '%dh%02dm' $((s / 3600)) $((s % 3600 / 60))
    else
        printf '%dd%dh' $((s / 86400)) $((s % 86400 / 3600))
    fi
}

# 5h ━━━───── 31% ↻2h14m
meter() {
    local label=$1 pct=$2 left=$3 width=8 filled
    local full='━━━━━━━━' empty='────────'
    if [[ -z $pct ]]; then
        printf '%s%s %s   –%s' "$dim" "$label" "$empty" "$reset"
        return
    fi
    filled=$(((pct * width + 50) / 100))
    ((filled > width)) && filled=$width
    printf '%s%s%s %s%s%s%s%s %s%3d%%%s %s↻%s%s' \
        "$dim" "$label" "$reset" \
        "$(colour "$pct")" "${full:0:filled}" "$reset" "$dim" "${empty:0:width - filled}" \
        "$(colour "$pct")" "$pct" "$reset" \
        "$dim" "$(duration "$left")" "$reset"
}

left="${model}${effort:+ $effort}"
left+="${left:+ · }$(level ctx "$ctx")"
right="$(meter 5h "$five" "$five_reset")   $(meter 7d "$seven" "$seven_reset")"

# Pad to push plan usage to the right edge. COLUMNS is set by Claude Code; the margin
# leaves room for the interface's own indent so the line never wraps.
shopt -s extglob
visible() {
    local plain=${1//$'\e['*([0-9;])m/}
    echo "${#plain}"
}
# Fall back to plain percentages when the pane is too narrow for the meters.
if (($(visible "$left") + $(visible "$right") + 8 > ${COLUMNS:-80})); then
    right="$(level 5h "$five") · $(level 7d "$seven")"
fi
gap=$((${COLUMNS:-80} - $(visible "$left") - $(visible "$right") - 6))
((gap < 2)) && gap=2

printf '%s%*s%s' "$left" "$gap" '' "$right"
