#!/usr/bin/bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

useradd -m -G wheel -s /bin/bash ellie
passwd ellie

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")


echo "ellie ALL=(ALL)ALL">> /etc/sudoers
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

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
systemctl enable gdm.service
systemctl enable dhcpcd
timedatectl status 

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

mkinitcpio -p linux
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

confirm "Did you check what you're supposed to check?" $(echo "Excellent. You haven't broken it. Yet.")

exit
umount -R /mnt