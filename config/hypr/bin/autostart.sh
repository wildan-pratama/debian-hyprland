#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Kill already running process
_ps=(dunst xfce-polkit waybar)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# Fix cursor
xsetroot -cursor_name left_ptr

# Polkit agent
/usr/libexec/xfce-polkit &

# Set wallpaper
swaybg -i ~/Pictures/backgrounds/bganime.png &

# Luanch Waybar
waybar -c ~/.config/hypr/waybar1/config -s ~/.config/hypr/waybar1/style.css &

# Lauch notification daemon
dunst -config ~/.config/hypr/bin/dunstrc

# Start mpd
#mpd

# Set theme
gsettings set $gnome-schema cursor-theme "Layan-border Cursors"
gsettings set $gnome-schema font-name "JetBrains Mono Medium 10"

# Start autotiling
#autotiling

