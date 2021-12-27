#!/usr/bin/bash
pacman -S networkmanager dhclient pacman-contrib curl reflector rsync --needed --noconfirm
systemctl enable --now NetworkManager
sudo pacman -S git wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome-shell gnome-tweaks gnome-shell-extensions gnome-power-manager gnome-color-manager gnome-calculator gnome-disk-utility gnome-control-center gnome-system-monitor gnome-screenshot gnome-autoar gnome-bluetooth gnome-common gnome-desktop gnome-keyring gnome-nettool gnome-online-accounts gnome-session gnome-settings-daemon eog nemo fish opera dhcpcd
