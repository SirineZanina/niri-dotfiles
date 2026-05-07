#!/usr/bin/env bash

dir="$HOME/.config/rofi/displaymenu"
theme='config'

INT="eDP-1"
EXT="HDMI-A-2"

extend='󰿬 Extend'
mirror='󰍹 Mirror'
internal='󰌁 Internal Only'
external='󰍺 External Only'

rofi_cmd() {
    rofi -dmenu \
        -p "󰍺 Display" \
        -mesg "Choose display mode" \
        -theme ${dir}/${theme}.rasi
}

chosen="$(echo -e "$extend\n$mirror\n$internal\n$external" | rofi_cmd)"

case ${chosen} in
    $extend)
        niri msg output "$INT" on
        niri msg output "$EXT" on
        niri msg output "$INT" position x=0 y=0
        niri msg output "$EXT" position x=1920 y=0
        ;;
    $mirror)
        niri msg output "$INT" on
        niri msg output "$EXT" mirror "$INT"
        ;;
    $internal)
        niri msg output "$INT" on
        niri msg output "$EXT" off
        ;;
    $external)
        niri msg output "$INT" off
        niri msg output "$EXT" on
        niri msg output "$EXT" position x=0 y=0
        ;;
esac
