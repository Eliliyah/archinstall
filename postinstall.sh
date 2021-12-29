#!/usr/bin/bash

sudo Pacman -Syu 
sudo pacman -S flatpak libappimage wget yajl

sudo pacman -S nemo fish opera gimp discord meld file-roller opera-ffmpeg-codecs bitwarden code inkscape virtualbox qbittorrent strawberry thunderbird totem bpytop firefox cryptsetup gimp pam-u2f rclone gparted 

cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si

cd /tmp 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 

cd/tmp
git clone https://github.com/safing/portmaster-packaging
cd portmaster-packaging/linux
makepkg -is

systemctl enable portmaster

flatpak install com.wps.Office
flatpak install org.gnome.clocks  
flatpak install io.mgba.mgba
flatpak install io.github.dosbox-staging

yaourt -S pamac-all
yaourt -S snapd
yaourt -S timeshift
yaourt -S timeshift-autosnap
yaourt -S btrfs-autosnap
yaourt -S chrome-gnome-shell
yaourt -S debtap
yaourt -S loginized
yaourt -S masterpdfeditor-free
yaourt -S mullvad-vpn
yaourt -S virtualbox-ext-oracle
yaourt -S gimp-plugin-gmic
yaourt -S gimp-palletes-davidrevoy
yaourt -S gimp-plugin-akkana-git
yaourt -S gimp-plugin-astronomy 
yaourt -S gimp-plugin-beautify
yaourt -S gimp-plugin-contrastfix
yaourt -S gimp-plugin-create-layer-mask-from
yaourt -S gimp-plugin-duplicate-to-another-image
yaourt -S gimp-plugin-export-layers
yaourt -S gimp-plugin-image-reg
yaourt -S gimp-plugin-instagram-effects
yaourt -S gimp-plugin-layerfx
yaourt -S gimp-plugin-layer-via-copy-cut
yaourt -S gimp-plugin-pandora
yaourt -S gimp-plugin-place-layer-into-selection
yaourt -S gimp-plugin-registry
yaourt -S gimp-plugin-scale-layer-to-image-size
yaourt -S gimp-plugin-toy
yaourt -S gimp-plugin-refocus

yay -S appimagelauncher
yay -S icedrive-appimage

timedatectl status 
