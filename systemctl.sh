#!/usr/bin/bash
systemctl enable gdm.service
systemctl enable dhcpcd
systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
timedatectl --no-ask-password set-timezone America/New_York
localectl --no-ask-password set-locale LANG="en_US.UTF-8" LC_TIME="en_US.UTF-8"
localectl --no-ask-password set-keymap us
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
timedatectl set-ntp true
timedatectl status

