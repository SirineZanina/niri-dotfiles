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
		-theme "${dir}/${theme}.rasi"
}

chosen="$(printf '%s\n' "$extend" "$mirror" "$internal" "$external" | rofi_cmd)"

# Any mode change should first tear down a previous mirror session
stop_mirror() {
	pkill -x wl-mirror 2>/dev/null
}

case "$chosen" in
"$extend")
	stop_mirror
	niri msg output "$INT" on
	niri msg output "$EXT" on
	niri msg output "$INT" position set 0 0
	niri msg output "$EXT" position set 1920 0
	;;
"$mirror")
	stop_mirror
	niri msg output "$INT" on
	niri msg output "$EXT" on
	# niri has no native mirroring: fullscreen a wl-mirror window of INT onto EXT
	wl-mirror --fullscreen --fullscreen-output "$EXT" "$INT" &
	disown
	;;
"$internal")
	stop_mirror
	niri msg output "$INT" on
	niri msg output "$EXT" off
	;;
"$external")
	stop_mirror
	niri msg output "$EXT" on
	niri msg output "$EXT" position set 0 0
	niri msg output "$INT" off
	;;
esac
