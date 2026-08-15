#!/bin/sh
set -eu
REPO_URL="https://github.com/ravinderbhatoy/dotfiles"
DEFAULT_REPO_DIR="$HOME/dotfiles"
# Names of GNU Stow packages in this repository.
STOW_PACKAGES="i3 dunst polybar rofi picom kitty ghostty nvim nsxiv zsh"
# Runtime dependencies for the configurations above.  The Arch package for i3
# is i3-wm (there is no package named "i3").
OFFICIAL_PACKAGES="git stow i3-wm dunst polybar rofi picom kitty ghostty neovim nsxiv zsh flameshot brightnessctl feh python-pywal libnotify xorg-xset xorg-setxkbmap pipewire-pulse blueman dex chromium thunar"
FONTS="ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-0xproto-nerd ttf-hack-nerd"
# AUR-only packages -- not in official Arch/CachyOS repos, require paru or yay.
AUR_PACKAGES="zen-browser-bin autotiling i3-resurrect snixembed"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ -d "$SCRIPT_DIR/.git" ]; then
    REPO_DIR="$SCRIPT_DIR"
    printf 'using local checkout: %s\n' "$REPO_DIR"
else
    REPO_DIR="${DOTFILES_DIR:-$DEFAULT_REPO_DIR}"
    if [ ! -d "$REPO_DIR/.git" ]; then
        printf 'cloning %s into %s\n' "$REPO_URL" "$REPO_DIR"
        git clone "$REPO_URL" "$REPO_DIR"
    else
        printf 'using existing clone: %s\n' "$REPO_DIR"
    fi
fi
cd "$REPO_DIR"
if ! command -v pacman >/dev/null 2>&1; then
    printf 'error: this bootstrap targets Arch-based systems (CachyOS); pacman not found\n' >&2
    exit 1
fi
if [ "$(id -u)" -eq 0 ]; then
    AUR_HELPER="pacman"
    PKG_MGR="pacman"
    SUDO=""
else
    if command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    elif command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    else
        AUR_HELPER="pacman"
    fi
    PKG_MGR="$AUR_HELPER"
    SUDO="sudo"
fi
install_packages() {
    case "$PKG_MGR" in
        paru|yay)
            "$PKG_MGR" -S --needed --noconfirm "$@"
            ;;
        pacman)
            $SUDO pacman -S --needed --noconfirm "$@"
            ;;
    esac
}
printf 'installing official packages...\n'
install_packages $OFFICIAL_PACKAGES

printf 'installing fonts: %s\n' "$FONTS"
if ! install_packages $FONTS; then
    printf 'warning: one or more font packages failed to install; continuing anyway\n' >&2
    printf '  (on CachyOS, check package names with: pacman -Ss <name> after pacman -Sy)\n' >&2
fi

printf 'installing AUR-only dependencies: %s\n' "$AUR_PACKAGES"
if [ "$AUR_HELPER" = "pacman" ]; then
    printf 'warning: no AUR helper (paru/yay) found -- skipping AUR packages: %s\n' "$AUR_PACKAGES" >&2
    printf '  install paru or yay, then re-run this script (existing installs will be skipped\n' >&2
    printf '  automatically thanks to --needed) to pull these in.\n' >&2
else
    if ! install_packages $AUR_PACKAGES; then
        printf 'warning: one or more AUR packages failed to build/install; continuing anyway\n' >&2
        printf '  (rerun manually with: %s -S <pkgname> to see the build error)\n' "$AUR_HELPER" >&2
    fi
fi

# --- stow, with first-run --adopt guard ---
# On a fresh install, $HOME often already has stock dotfiles (e.g. default
# .zshrc, .config skeleton from the live ISO). Plain `stow --restow` will
# fail loudly if a target file exists and isn't already a stow-owned symlink.
# STOW_ADOPT=1 makes stow absorb existing files into the repository working
# tree instead of aborting. The adopted content is deliberately retained for
# review; silently resetting it would destroy a user's existing configuration.
STOW_ADOPT="${STOW_ADOPT:-0}"
STOW_FLAGS="--restow"
if [ "$STOW_ADOPT" = "1" ]; then
    STOW_FLAGS="--adopt --restow"
    printf 'STOW_ADOPT=1: existing conflicting files will be adopted into the repo; review git diff afterward\n'
fi

for package in $STOW_PACKAGES; do
    if [ ! -d "$package" ]; then
        printf 'warning: skipping missing package %s\n' "$package" >&2
        continue
    fi
    if stow --target="$HOME" $STOW_FLAGS "$package" 2>/tmp/stow_err_$$; then
        rm -f /tmp/stow_err_$$
    else
        cat /tmp/stow_err_$$ >&2
        rm -f /tmp/stow_err_$$
        if [ "$STOW_ADOPT" != "1" ]; then
            printf 'error: stow conflict for "%s". existing files in $HOME are blocking the symlink.\n' "$package" >&2
            printf '  re-run with STOW_ADOPT=1 to absorb them into the repo for review, or remove the conflicting files\n' >&2
            printf '  manually and re-run.\n' >&2
            exit 1
        else
            printf 'error: stow --adopt still failed for "%s"; inspect manually\n' "$package" >&2
            exit 1
        fi
    fi
done

printf 'done. configs from %s applied to %s\n' "$REPO_URL" "$HOME"
printf 'fonts installed: %s\n' "$FONTS"
