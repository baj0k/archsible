# Start X after login
[ "$(tty)" = "/dev/tty1" ] && ! pgrep Xorg && exec startx "${XDG_CONFIG_HOME:?}/xorg/xinitrc"
