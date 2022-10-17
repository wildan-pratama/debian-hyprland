#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## Kill if already running
killall -9 dunst waybar nm-applet

## Polkit agent
#if [[ ! `pidof xfce-polkit` ]]; then
#	/usr/lib/xfce-polkit/xfce-polkit &
#fi

## Polkit agent (debian)
if [[ ! `pidof xfce-polkit` ]]; then
	/usr/libexec/xfce-polkit &
fi

## Luanch Waybar
waybar -c ~/.config/hypr/waybar/config -s ~/.config/hypr/waybar/style.css &

## Lauch notification daemon
dunst -config ~/.config/hypr/bin/dunstrc &

## Set wallpaper
swaybg -i ~/Pictures/backgrounds/bganime-hd.png &

## Launch Network applet
nm-applet --indicator &
