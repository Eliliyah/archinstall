echo "ellie ALL=(ALL)ALL">> /etc/sudoers

pacman -S networkmanager dhclient pacman-contrib curl dhcpcd rsync --needed --noconfirm
pacman -S linux-zen linux-lts --noconfirm
pacman -S git wayland xorg-xwayland gdm wayland-protocols qt5-wayland libva xorg xdg-user-dirs gnome-shell nemo fish opera --noconfirm


systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
systemctl enable gdm.service
systemctl enable dhcpcd

mv /etc/mkinitcpio.conf /etc/backup
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
mkinitcpio -p linux
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -R /mnt