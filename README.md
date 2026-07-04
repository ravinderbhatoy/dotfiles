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

## Setup

Clone the repo:

```sh
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

Apply the dotfiles:

```sh
./bootstrap.sh
```

This uses GNU Stow and symlinks each package into `$HOME`.

## Requirements

Install `stow` first.

Core desktop tools used by these configs:

```sh
sudo pacman -S stow i3-wm i3blocks polybar rofi picom dunst kitty ghostty feh pywal nsxiv xss-lock xclip brightnessctl flameshot autotiling snixembed
```

Bluetooth tray and notifications:

```sh
sudo pacman -S blueman
```

You will also likely want:

```sh
sudo pacman -S ttf-jetbrains-mono-nerd noto-fonts
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
