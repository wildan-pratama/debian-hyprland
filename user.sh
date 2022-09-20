#!/bin/sh
mkdir -p ~/.config ~/Pictures
cp -aR config/* ~/.config
cp -aR backgrounds ~/Pictures
touch ~/.config/mpd/database