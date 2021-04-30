#!/bin/bash

PROJ="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

ln -snf "$PROJ/bspwm" "$HOME/.config/bspwm" 
ln -snf "$PROJ/sxhkd" "$HOME/.config/sxhkd"
ln -snf "$PROJ/dunst" "$HOME/.config/dunst"
ln -snf "$PROJ/alacritty" "$HOME/.config/alacritty"
ln -snf "$PROJ/rofi" "$HOME/.config/rofi"
ln -snf "$PROJ/polybar" "$HOME/.config/polybar"
ln -sf "$PROJ/dots/.Xmodmap" "$HOME/.Xmodmap"
