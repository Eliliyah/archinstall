#!/usr/bin/bash
mv /etc/hostname /etc/backup/hostname 
cp /archinstall/hostname /etc/hostname
mv /etc/locale.gen /etc/backup/
cp /archinstall/locale.gen /etc/locale.gen
mv /etc/pacman.d/mirrorlist /etc/backup/
cp /archinstall/mirrorlist /etc/pacman.d/mirrorlist
mv /etc/hostname /etc/backup/
mv /etc/pacman.conf /etc/backup/
cp /archinstall/pacman.conf /etc/pacman.conf
cp /archinstall/locale.conf /etc/locale.conf
cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/blackarch-mirrorlist /etc/pacman.d/blackarch-mirrorlist
cp /archinstall/vconsole.conf /etc/vconsole.conf
mv /etc/mkinitcpio.conf /etc/backup
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
ls /etc/backup
