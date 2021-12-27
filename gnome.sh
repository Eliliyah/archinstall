#!/usr/bin/bash
pacman -S networkmanager dhcpcd dhclient pacman-contrib curl rsync --needed --noconfirm
systemctl enable --now NetworkManager
pacman -S linux-zen linux-lts --noconfirm
pacman -S git wayland xorg-xwayland gnome-shell gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs eog nemo fish opera 
