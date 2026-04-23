#!/bin/sh

set -eu

[ $# -ge 1 ] || exit 1

wallpaper=$1

feh --bg-fill "$wallpaper"
wal -i "$wallpaper"
