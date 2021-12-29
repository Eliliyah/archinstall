#!/usr/bin/bash

sudo pacman -Syu 
sudo pacman -S flatpak libappimage wget yajl
sudo pacman -S nemo fish opera gimp discord meld file-roller opera-ffmpeg-codecs bitwarden code inkscape virtualbox qbittorrent strawberry thunderbird totem bpytop firefox cryptsetup gimp pam-u2f rclone gparted 

flatpak install com.wps.Office
flatpak install org.gnome.clocks  
flatpak install io.mgba.mgba
flatpak install io.github.dosbox-staging

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 
yay -Y --devel --save

yay -S pamac-all --noconfirm
yay -S timeshift timeshift-autosnap btrfs-autosnap --noconfirm
yay -S chrome-gnome-shell debtap loginized masterpdfeditor-free mullvad-vpn virtualbox-ext-oracle --noconfirm
yay -S appimagelauncher --noconfirm
yay -S icedrive-appimage --noconfirm
yay gimp-plugin-gmic gimp-palletes-davidrevoy gimp-plugin-akkana-git gimp-plugin-astronomy gimp-plugin-beautify gimp-plugin-contrastfix gimp-plugin-create-layer-mask-from gimp-plugin-duplicate-to-another-image gimp-plugin-export-layers gimp-plugin-image-reg gimp-plugin-instagram-effects gimp-plugin-layerfx gimp-plugin-layer-via-copy-cut gimp-plugin-pandora gimp-plugin-place-layer-into-selection gimp-plugin-registry gimp-plugin-scale-layer-to-image-size gimp-plugin-toy gimp-plugin-refocus --noconfirm

cd/tmp
git clone https://github.com/safing/portmaster-packaging
cd portmaster-packaging/linux
makepkg -is

systemctl enable portmaster
