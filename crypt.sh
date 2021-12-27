#!/usr/bin/bash

mkfs.fat -F32 -n EFI /dev/sda1/EFI

cryptsetup open --type plain --key-file /dev/urandom /dev/sda2 swap
mkswap -L swap /dev/mapper/swap
swapon -L swap

mkfs.btrfs --force --label system /dev/mapper/system
o=defaults,x-mount.mkdir
o_btrfs=$o,compress=lzo,ssd,noatime
mount -t btrfs LABEL=system /mnt

btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/snapshots
umount -R /mnt

mount -t btrfs -o subvol=root,$o_btrfs LABEL=system /mnt
mount -t btrfs -o subvol=home,$o_btrfs LABEL=system /mnt/home
mount -t btrfs -o subvol=snapshots,$o_btrfs LABEL=system /mnt/.snapshots
mkdir /mnt/boot
mount LABEL=EFI /mnt/boot
