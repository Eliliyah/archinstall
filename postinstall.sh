#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done }

example-function() { echo "Excellent. You haven't broken it. Yet." }

confirm "Are you ready to keep going?" $(echo "Say your prayers.")

sudo Pacman -Syu 
sudo pacman -S flatpak libappimage wget yajl

sudo pacman -S nemo fish opera meld file-roller opera-ffmpeg-codecs bitwarden code inkscape libreoffice-fresh virtualbox qbittorrent strawberry thunderbird totem bpytop firefox cryptsetup gimp pam-u2f rclone gparted  

cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si
confirm "Did yaourt install successfully?" $(echo "Why does that always make me want yogurt?")
yaourt -S pamac-all
yaourt -S snapd
yaourt -S timeshift
cd /tmp 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 
confirm "Did yay install successfully?" $(echo "Yay! (ba dum tss)")
yay -S appimagelauncher
confirm "Can you install appimages now?" $(echo "Awesome. We're almost done.")
yay -S icedrive-appimage
confirm "Is it cold in here?" $(echo "No, it's not - it's Florida.")

cd/tmp
git clone https://github.com/safing/portmaster-packaging
cd portmaster-packaging/linux
makepkg -is
confirm "Did portmaster install successfully?" $(echo "Finally.")

systemctl enable portmaster
timedatectl status 
confirm "Did system services enable?" $(echo "Okay, time for a deep breath.")
