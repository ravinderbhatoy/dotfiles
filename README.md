# Dotfiles

Personal Linux desktop configuration managed with GNU Stow.

## Packages

- `i3`
- `dunst`
- `polybar`
- `rofi`
- `picom`
- `kitty`
- `ghostty`
- `nvim`
- `nsxiv`
- `zsh`
- `tmux`

## Setup

Clone the repo:

```sh
git clone https://github.com/ravinderbhatoy/dotfiles ~/dotfiles
cd ~/dotfiles
```

Or just run the bootstrap script — it will clone the repo automatically if
you don't have it yet:

```sh
curl -fsSL https://raw.githubusercontent.com/ravinderbhatoy/dotfiles/main/bootstrap.sh | sh
```

Then apply the dotfiles:

```sh
./bootstrap.sh
```

The bootstrap script:

1. Clones this repo into `~/dotfiles` if it isn't already present.
2. Installs `git`, `stow`, and the Nerd Fonts used by the configs
   (`JetBrains Mono`, `FiraCode`, `0xProto`) via `pacman` (using `paru` or
   `yay` if available).
3. Uses GNU Stow to symlink each package into `$HOME`.

## Requirements

CachyOS / Arch-based system (the script checks for `pacman`).

The font packages installed by the bootstrap script are:

```sh
ttf-jetbrains-mono-nerd ttf-firacode-nerd ttf-0xproto-nerd
```

## Notes

- `i3` startup launches `dunst` for notifications.
- `i3` startup launches `blueman-applet` for Bluetooth tray integration and notifications.
- `snixembed` bridges StatusNotifier/AppIndicator tray icons, such as Telegram, into Polybar's XEmbed tray.
- Low battery warnings are handled by `~/.config/i3/scripts/low-battery-warning`.
- `dunst` border colors are synced to the current `pywal` theme by `~/.config/i3/scripts/sync-dunst-colors`.
- Changing wallpaper through `~/.config/i3/apply-wallpaper.sh` also refreshes `pywal` and `dunst` colors.

## Updating

After pulling new changes:

```sh
cd ~/dotfiles
git pull
./bootstrap.sh
```
