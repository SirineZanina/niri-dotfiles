#!/bin/bash
# LockScreen.sh - Lock the screen with hyprlock
# Save to: ~/.config/hypr/scripts/LockScreen.sh

# Pause any media before locking
if command -v playerctl &> /dev/null; then
    playerctl pause
fi

# Lock the screen
hyprlock
