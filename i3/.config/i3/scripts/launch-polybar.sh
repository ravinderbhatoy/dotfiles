#!/bin/sh

pkill -x polybar 2>/dev/null || true
sleep 1
exec polybar --config=/home/raypamber/.config/polybar/config.ini main \
    >>/tmp/polybar-i3.log 2>&1
