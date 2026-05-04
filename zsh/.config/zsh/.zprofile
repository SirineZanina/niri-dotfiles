#!/bin/sh
# Sources environment variables
[ -f "$HOME/.config/shell/profile" ] && . "$HOME/.config/shell/profile"
[ -f "$XDG_CONFIG_HOME/shell/secrets.sh" ] && source "$XDG_CONFIG_HOME/shell/secrets.sh"

if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec start-hyprland
fi

