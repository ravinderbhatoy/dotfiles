#!/usr/bin/env sh

choice=$(
  printf "Lock\nLogout\nReboot\nShutdown\n" |
    rofi -dmenu -i -p power
)

case "$choice" in
  Lock)
    if command -v i3lock >/dev/null 2>&1; then
      exec i3lock
    fi
    ;;
  Logout)
    exec i3-msg exit
    ;;
  Reboot)
    exec systemctl reboot
    ;;
  Shutdown)
    exec systemctl poweroff
    ;;
esac
