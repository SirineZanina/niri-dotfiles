#!/usr/bin/env bash

dir="$HOME/.config/rofi/displaymenu"
theme='config'
HYPRCONF="$HOME/.config/hypr/conf/monitors.conf"

# Options
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

run_rofi() {
    echo -e "$extend\n$mirror\n$internal\n$external" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
    $extend)
        EXT_RES=$(hyprctl monitors all -j | jq -r '[.[] | select(.name | test("eDP|LVDS|DSI") | not)] | .[0] | "\(.width)x\(.height)@\(.refreshRate)"')
        EXT_NAME=$(hyprctl monitors all -j | jq -r '[.[] | select(.name | test("eDP|LVDS|DSI") | not)] | .[0].name')
        echo "monitor=eDP-1,1920x1080@144.15,0x0,1.0
monitor=$EXT_NAME,$EXT_RES,1920x0,1.0
monitor=,preferred,auto,1" > "$HYPRCONF"
        hyprctl reload
        ;;
    $mirror)
        EXT_NAME=$(hyprctl monitors all -j | jq -r '[.[] | select(.name | test("eDP|LVDS|DSI") | not)] | .[0].name')
        echo "monitor=eDP-1,1920x1080@144.15,0x0,1.0
monitor=$EXT_NAME,preferred,0x0,1,mirror,eDP-1
monitor=,preferred,auto,1" > "$HYPRCONF"
        hyprctl reload
        ;;
    $internal)
        EXT_NAME=$(hyprctl monitors all -j | jq -r '[.[] | select(.name | test("eDP|LVDS|DSI") | not)] | .[0].name')
        echo "monitor=eDP-1,1920x1080@144.15,0x0,1.0
monitor=$EXT_NAME,disabled
monitor=,preferred,auto,1" > "$HYPRCONF"
        hyprctl reload
        ;;
    $external)
        EXT_NAME=$(hyprctl monitors all -j | jq -r '[.[] | select(.name | test("eDP|LVDS|DSI") | not)] | .[0].name')
        EXT_RES=$(hyprctl monitors all -j | jq -r '[.[] | select(.name | test("eDP|LVDS|DSI") | not)] | .[0] | "\(.width)x\(.height)@\(.refreshRate)"')
        echo "monitor=eDP-1,disabled
monitor=$EXT_NAME,$EXT_RES,0x0,1.0
monitor=,preferred,auto,1" > "$HYPRCONF"
        hyprctl reload
        ;;
esac
