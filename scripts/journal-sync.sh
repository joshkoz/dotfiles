#!/usr/bin/env bash
set -euo pipefail

src="/home/${USER}/work/journal/"
dest="/mnt/NAS/obsidian-vaults/work-journal/"

if ! command -v inotifywait >/dev/null 2>&1; then
  echo "inotifywait not found (install inotify-tools)" >&2
  exit 1
fi

rsync_opts=(
  -a
  --delete
  --exclude '*~'
)

run_rsync() {
  if ! /usr/bin/mountpoint -q "/mnt/NAS"; then
    echo "NAS not mounted, skipping sync" >&2
    return 0
  fi

  set +e
  rsync "${rsync_opts[@]}" "$src" "$dest"
  rc=$?
  set -e
  if [ "$rc" -ne 0 ] && [ "$rc" -ne 24 ]; then
    exit "$rc"
  fi
}

run_rsync

inotifywait -m -r -e close_write,create,delete,move --format '%w%f' "$src" | while read -r _; do
  run_rsync
done
