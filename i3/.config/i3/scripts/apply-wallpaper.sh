#!/bin/sh

set -eu

[ $# -ge 1 ] || exit 1

wallpaper=$1

feh --bg-fill "$wallpaper"

if command -v wal >/dev/null 2>&1; then
    wal -i "$wallpaper" 2>/dev/null || true
fi

[ -x "$HOME/.config/i3/scripts/sync-dunst-colors" ] && "$HOME/.config/i3/scripts/sync-dunst-colors" 2>/dev/null || true
[ -x "$HOME/.config/i3/scripts/apply-pywal-colors" ] && "$HOME/.config/i3/scripts/apply-pywal-colors" 2>/dev/null || true

if command -v notify-send >/dev/null 2>&1; then
    notify-send "Wallpaper Set" "$(basename "$wallpaper")"
fi
