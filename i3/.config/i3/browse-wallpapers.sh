#!/bin/sh

set -eu

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/gitclone/walls}"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper browser" "Directory not found: $WALLPAPER_DIR"
    exit 1
fi

if command -v nsxiv >/dev/null; then
    mkdir -p "$HOME/.config/nsxiv/exec"
    ln -sf "$HOME/.config/i3/nsxiv-key-handler" "$HOME/.config/nsxiv/exec/key-handler"
    find "$WALLPAPER_DIR" -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        -print0 | xargs -0 nsxiv -tb 2>/dev/null
    exit 0
fi

feh -r \
    -t \
    -y 180 \
    -E 120 \
    -W 1400 \
    -H 900 \
    --draw-filename \
    --action "; $HOME/.config/i3/apply-wallpaper.sh %F" \
    "$WALLPAPER_DIR"
