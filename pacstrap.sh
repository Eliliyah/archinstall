#!/usr/bin/bash
pacstrap /mnt base linux linux-firmware
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils which neofetch iwctl fish efibootmgr efivars reflector reflector-simple systemd perl perl-timedate zstd 