#!/bin/bash

path="$(pwd)"

echo "create link for polybar"
ln -s -f "$path/polybar" "$HOME/.config/polybar"
echo "create link for i3wm"
ln -s -f "$path/i3" "$HOME/.config/i3"
echo "create link for xresources"
ln -s -f "$path/xresources" "$HOME/.Xresources"
echo "create link for xmodmap"
ln -s -f "$path/xmodmap" "$HOME/.Xmodmap"
