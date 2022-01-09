#!/usr/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S file-roller go meson cmake extra-cmake-modules rust

cd /tmp
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg -si
sudo pacman -Syu

sudo aura -A pipewire-jack-dropin snapper-support snap-pac --noconfirm
sudo aura -A pamac-all --noconfirm
sudo aura -A update-grub grub-hook btrfs-autosnap snap-pac-grub stacer-bin --noconfirm
sudo aura -A appimagelauncher --noconfirm
sudo aura -A icedrive-appimage --noconfirm
sudo aura -A hunspell-en-med-glut-git ocs-url nerd-fonts-complete pacdiff-pacman-hook-git qgnomeplatform systemd-boot-pacman-hook wd719x-firmware aic94xx-firmware 
