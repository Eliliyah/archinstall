#!/usr/bin/bash

pacman -S wayland xorg-xwayland wayland-protocols libva

pacman -S gdm gnome-shell 

pacman -S gnome-terminal --needed gnome-desktop cinnamon-desktop gnome-control-center gnome-system-monitor gnome-tweaks  gnome-color-manager gnome-usage gnome-screenshot gnome-keyring gnome-nettool gnome-calculator 

systemctl enable gdm.service
cp /archinstall/postinstall.sh /home/ellie/Downloads 