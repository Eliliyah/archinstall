#!/usr/bin/bash

nano /etc/hostname
     ellie
passwd

sudo EDITOR=nano visudo
#uncomment wheel group
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers

nano /etc/mkinitcpio.conf
    MODULES=(vmd crc32c-intel)
    BINARIES=(/usr/sbin/btrfs)
    HOOKS=(systemd btrfs sd-encrypt fsck base udev autodetect modconf block keyboard keymap consolefont encrypt resume filesystems)

mkinitcpio -p linux

grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -R /mnt
reboot