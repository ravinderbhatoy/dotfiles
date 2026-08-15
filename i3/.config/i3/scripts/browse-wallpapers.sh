#!/bin/sh

set -eu

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/gitclone/walls}"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper browser" "Directory not found: $WALLPAPER_DIR"
    exit 1
fi

if command -v nsxiv >/dev/null 2>&1; then
    mkdir -p "$HOME/.config/nsxiv/exec"
    ln -sf "$HOME/.config/i3/scripts/nsxiv-key-handler" "$HOME/.config/nsxiv/exec/key-handler"
    chmod +x "$HOME/.config/i3/scripts/nsxiv-key-handler"

    selected=$(find "$WALLPAPER_DIR" -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
        -print0 | xargs -0 nsxiv -t -o 2>/dev/null)

    if [ -n "${selected:-}" ]; then
        echo "$selected" | while IFS= read -r wallpaper; do
            [ -n "$wallpaper" ] && [ -f "$wallpaper" ] && "$HOME/.config/i3/scripts/apply-wallpaper.sh" "$wallpaper"
        done
    fi
    exit 0
fi

notify-send "Wallpaper Browser" "nsxiv is not installed! Run 'sudo pacman -S nsxiv' to install it."

feh -r \
    -t \
    -y 180 \
    -E 120 \
    -W 1400 \
    -H 900 \
    --draw-filename \
    --action "; $HOME/.config/i3/scripts/apply-wallpaper.sh %F" \
    "$WALLPAPER_DIR"
