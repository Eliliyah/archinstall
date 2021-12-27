#!/usr/bin/bash
pacman -S networkmanager dhclient pacman-contrib curl reflector rsync --needed --noconfirm
systemctl enable --now NetworkManager
pacman -S linux-zen linux-lts 
pacman -S git wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome eog nemo fish opera dhcpcd
