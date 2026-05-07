#!/usr/bin/env bash
dir="$HOME/.config/rofi/powermenu"
theme='config'

uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

shutdown=' shutdown'
reboot=' reboot'
lock=' lock'
suspend=' suspend'
logout=' logout'
yes=' yes'
no=' no'

rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "uptime: $uptime" \
        -u 1,4 \
        -a 2,3 \
        -theme "${dir}/${theme}.rasi"
}

confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'are you sure?' \
        -theme "${dir}/${theme}.rasi"
}

confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
    echo -e "$lock\n$shutdown\n$reboot\n$suspend\n$logout" | rofi_cmd
}

run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        case $1 in
            --shutdown) systemctl poweroff ;;
            --reboot)   systemctl reboot ;;
            --suspend)  systemctl suspend ;;
            --logout)   niri msg action quit --skip-confirmation ;;
        esac
    fi
}

chosen="$(run_rofi)"
case ${chosen} in
    "$shutdown") run_cmd --shutdown ;;
    "$reboot")   run_cmd --reboot ;;
    "$lock")     swaylock ;;
    "$suspend")  run_cmd --suspend ;;
    "$logout")   run_cmd --logout ;;
esac
