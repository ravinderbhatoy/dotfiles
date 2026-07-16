#!/bin/sh

set -eu

[ $# -ge 1 ] || exit 1

wallpaper=$1

feh --bg-fill "$wallpaper"
wal -i "$wallpaper"
"$HOME/.config/i3/scripts/sync-dunst-colors"
"$HOME/.config/i3/scripts/apply-pywal-colors"
