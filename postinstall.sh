#!/usr/bin/bash

sudo pacman -Syu 
sudo pacman -S flatpak libappimage wget yajl
sudo pacman -S gimp discord meld file-roller opera-ffmpeg-codecs bitwarden code inkscape virtualbox qbittorrent strawberry thunderbird totem bpytop firefox gimp pam-u2f rclone gparted 

flatpak install com.wps.Office org.gnome.clocks io.mgba.mgba io.github.dosbox-staging --noconfirm 

cd /tmp
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -si
sudo pacman -Syu

sudo aura -A pamac-all --noconfirm
sudo aura -A timeshift timeshift-autosnap btrfs-autosnap --noconfirm
sudo aura -A chrome-gnome-shell debtap loginized masterpdfeditor-free mullvad-vpn virtualbox-ext-oracle --noconfirm
sudo aura -A appimagelauncher --noconfirm
sudo aura -A -S icedrive-appimage --noconfirm
sudo aura -A gimp-plugin-gmic gimp-palletes-davidrevoy gimp-plugin-akkana-git gimp-plugin-astronomy gimp-plugin-beautify gimp-plugin-contrastfix gimp-plugin-create-layer-mask-from gimp-plugin-duplicate-to-another-image gimp-plugin-export-layers gimp-plugin-image-reg gimp-plugin-instagram-effects gimp-plugin-layerfx gimp-plugin-layer-via-copy-cut gimp-plugin-pandora gimp-plugin-place-layer-into-selection gimp-plugin-registry gimp-plugin-scale-layer-to-image-size gimp-plugin-toy gimp-plugin-refocus --noconfirm

cd/tmp
git clone https://github.com/safing/portmaster-packaging
cd portmaster-packaging/linux
makepkg -is

systemctl enable portmaster
