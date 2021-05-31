#!/bin/bash

pacman -S --needed curl

pacman -S --needed --noconfirm archlinuxcn-keyring pacman-contrib

pacman -S --needed --noconfirm \
  sudo dunst sxhkd git openssh grub efibootmgr man-db man networkmanager network-manager-applet tmux \
  pikaur qv2ray elinks wget xorg xdm \
  gvfs-mtp udisks2 gnupg pass telegram-tdlib jdk-openjdk clojure \
  maim waybar sway mako grim swappy
