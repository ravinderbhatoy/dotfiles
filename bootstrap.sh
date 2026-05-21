#!/bin/sh

set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PACKAGES="i3 dunst polybar rofi picom kitty nvim nsxiv"

if ! command -v stow >/dev/null 2>&1; then
    printf 'error: GNU Stow is not installed\n' >&2
    printf 'install it first, then rerun %s/bootstrap.sh\n' "$REPO_DIR" >&2
    exit 1
fi

cd "$REPO_DIR"

for package in $PACKAGES; do
    if [ ! -d "$package" ]; then
        printf 'warning: skipping missing package %s\n' "$package" >&2
        continue
    fi

    stow --target="$HOME" --restow "$package"
done

printf 'dotfiles applied for:%s\n' " $PACKAGES"
