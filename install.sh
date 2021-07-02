#!/bin/bash

PROJ="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

ln -snf "$PROJ/bspwm" "$HOME/.config/bspwm"
ln -snf "$PROJ/sxhkd" "$HOME/.config/sxhkd"
ln -snf "$PROJ/picom" "$HOME/.config/picom"
ln -snf "$PROJ/dunst" "$HOME/.config/dunst"
ln -snf "$PROJ/alacritty" "$HOME/.config/alacritty"
ln -snf "$PROJ/sway" "$HOME/.config/sway"
ln -snf "$PROJ/rofi" "$HOME/.config/rofi"
ln -snf "$PROJ/polybar" "$HOME/.config/polybar"
ln -snf "$PROJ/tmux" "$HOME/.config/tmux"
ln -snf "$PROJ/waybar" "$HOME/.config/waybar"
ln -snf "$PROJ/pip" "$HOME/.config/pip"
ln -sf "$PROJ/dots/.Xresources" "$HOME/.Xresources"
ln -sf "$PROJ/chromium-flags.conf" "$HOME/.config/chromium-flags.conf"
ln -snf "$PROJ/wayst" "$HOME/.config/wayst"
