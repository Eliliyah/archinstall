#!/usr/bin/bash
systemctl enable gdm.service
systemctl enable dhcpcd
systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
timedatectl --no-ask-password set-timezone America/New_York
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
timedatectl set-ntp true
timedatectl status

