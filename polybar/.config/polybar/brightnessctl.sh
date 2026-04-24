#!/usr/bin/env sh

case "$1" in
  up)
    exec /usr/bin/brightnessctl set +5%
    ;;
  down)
    exec /usr/bin/brightnessctl set 5%-
    ;;
  *)
    exit 1
    ;;
esac
