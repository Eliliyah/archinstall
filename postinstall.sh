#!/usr/bin/bash

sudo Pacman -Syu 
sudo pacman -S flatpak libappimage wget yajl

sudo pacman -S nemo fish opera meld file-roller opera-ffmpeg-codecs bitwarden code inkscape libreoffice-fresh virtualbox qbittorrent strawberry thunderbird totem bpytop firefox cryptsetup gimp pam-u2f rclone gparted gimp-plugin-gmic 

cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si

yaourt -S pamac-all
yaourt -S snapd
yaourt -S timeshift

cd /tmp 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 

yay -S appimagelauncher

yay -S icedrive-appimage

cd/tmp
git clone https://github.com/safing/portmaster-packaging
cd portmaster-packaging/linux
makepkg -is

systemctl enable portmaster

snap install dosbox-staging

timedatectl status 