#!/usr/bin/bash

sgdisk --zap-all /dev/sda

sgdisk --clear \
         --new=1:0:+550MiB --typecode=1:ef00 --change-name=1:EFI \
         --new=2:0:+8GiB   --typecode=2:8200 --change-name=2:cryptswap \
         --new=3:0:0       --typecode=3:8300 --change-name=3:cryptsystem \
           /dev/sda

mkfs.fat -F32 -n EFI /dev/sda1

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