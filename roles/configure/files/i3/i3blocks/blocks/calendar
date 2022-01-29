#!/bin/sh

[ -n "${BLOCK_BUTTON}" ] && case "${BLOCK_BUTTON}" in
    1) notify-send "$(cal | sed -r "s?\b$(date|cut -d' ' -f4)\b?*?")" ;; # left click, show current month
    2) notify-send "$(cal -Y)" ;; # middle click, show whole year
    3) notify-send "$(cal -3S)" ;; # right click, show 3 months, span the date
    *) ;;
esac
date +" %a, %d %b %H:%M:%S"
