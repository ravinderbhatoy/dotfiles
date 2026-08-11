#!/bin/sh
set -eu
REPO_URL="https://github.com/ravinderbhatoy/dotfiles"
DEFAULT_REPO_DIR="$HOME/dotfiles"
PACKAGES="i3 dunst polybar rofi picom kitty ghostty nvim nsxiv zsh"
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
printf 'installing core dependencies (git, stow)...\n'
install_packages git stow

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
# STOW_ADOPT=1 makes stow absorb existing files into the repo's working tree
# instead of aborting -- then we discard any local drift with `git checkout`
# so the repo's version wins, matching normal (non-adopt) behavior.
STOW_ADOPT="${STOW_ADOPT:-0}"
STOW_FLAGS="--restow"
if [ "$STOW_ADOPT" = "1" ]; then
    STOW_FLAGS="--adopt --restow"
    printf 'STOW_ADOPT=1: existing conflicting files will be adopted into the repo, then reset to repo versions\n'
fi

for package in $PACKAGES; do
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
            printf '  re-run with STOW_ADOPT=1 to absorb them into the repo (their content will then be\n' >&2
            printf '  overwritten by the repo version via git checkout), or remove the conflicting files\n' >&2
            printf '  manually and re-run.\n' >&2
            exit 1
        else
            printf 'error: stow --adopt still failed for "%s"; inspect manually\n' "$package" >&2
            exit 1
        fi
    fi
    if [ "$STOW_ADOPT" = "1" ]; then
        # discard any content adopted from pre-existing $HOME files so the
        # repo's tracked version is authoritative, not whatever was on disk
        git checkout -- "$package" 2>/dev/null || true
    fi
done

printf 'done. configs from %s applied to %s\n' "$REPO_URL" "$HOME"
printf 'fonts installed: %s\n' "$FONTS"
