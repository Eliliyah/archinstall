#!/usr/bin/bash
loadkeys us
sgdisk --zap-all /dev/sda

sgdisk --clear \
         --new=1:0:+550MiB --typecode=1:ef00 --change-name=1:EFI \
         --new=2:0:+1GiB   --typecode=2:8200 --change-name=2:swap \
         --new=3:0:0       --typecode=3:8300 --change-name=3:system \
           /dev/sda

mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.btrfs /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot


pacstrap /mnt base linux linux-firmware
pacstrap /mnt dhcpcd linux-zen base-devel btrfs-progs iw gptfdisk zsh terminus-font intel-ucode snapper grub dosfstools man-db man-pages nano usbutils which neofetch fish efibootmgr reflector perl perl-timedate iwd git systemd grub-btrfs refind

genfstab -L -p /mnt >> /mnt/etc/fstab

arch-chroot /mnt
loadkeys us
git clone https://github.com/Eliliyah/archinstall.git
cd archinstall
chmod +x part2.sh
chmod +x part3.sh
timedatectl --no-ask-password set-timezone America/New_York
timedatectl set-ntp true
locale-gen

mkdir /etc/backup
mv /etc/locale.gen /etc/backup/
cp /archinstall/locale.gen /etc/locale.gen
mv /etc/pacman.d/mirrorlist /etc/backup/
cp /archinstall/mirrorlist /etc/pacman.d/mirrorlist
mv /etc/hostname /etc/backup/
cp /archinstall/hostname /etc/hostname
mv /etc/pacman.conf /etc/backup/
cp /archinstall/pacman.conf /etc/pacman.conf
cp /archinstall/locale.conf /etc/locale.conf
cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/blackarch-mirrorlist /etc/pacman.d/blackarch-mirrorlist
cp /archinstall/vconsole.conf /etc/vconsole.conf
useradd -m -G wheel -s /bin/bash ellie

