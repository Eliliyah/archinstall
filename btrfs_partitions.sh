#!/usr/bin/bash

cryptsetup luksFormat --align-payload=8192 -s 256 -c aes-xts-plain64 /dev/sda3/cryptsystem
cryptsetup open /dev/sda3/cryptsystem system

cryptsetup open --type plain --key-file /dev/urandom /dev/sda2/cryptswap swap
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
mount /dev/sda1 /mnt/boot
