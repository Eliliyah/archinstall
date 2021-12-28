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

confirm "Are you ready to keep going?" $(echo "Say your prayers.")

#Set the root password
passwd
confirm "Did you set the root password?" $(echo "Excellent. You haven't broken it. Yet.")

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
echo "ellie ALL=(ALL)ALL">> /etc/sudoers
confirm "Do you exist now?" $(echo "Are you sure you want to?")

#Create the backup directory and move files
mkdir /etc/backupfolder
mv /etc/locale.gen /etc/backupfolder
mv /etc/pacman.d/mirrorlist /etc/backupfolder
mv /etc/pacman.conf /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
ls /etc/backupfolder
confirm "Did the files backup successfully?" $(echo "Excellent. You haven't broken it. Yet.")

#Copy files
cp /archinstall/hostname /etc/hostname
cp /archinstall/locale.gen /etc/locale.gen
cp /archinstall/mirrorlist /etc/pacman.d/mirrorlist
cp /archinstall/pacman.conf /etc/pacman.conf
cp /archinstall/locale.conf /etc/locale.conf
cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/vconsole.conf /etc/vconsole.conf
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
confirm "Did all the files copy successfully?" $(echo "Whew!")

#Install Extras
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si
confirm "Did yaourt install successfully?" $(echo "Why does that always make me want yogurt?")
yaourt -S pamac-aur
confirm "Did pamac install?" $(echo "Okay, but you know that's the lazy way of doing things.")
cd /tmp 
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si 
confirm "Did yay install successfully?" $(echo "Yay! (ba dum tss)")
yay -S appimagelauncher
confirm "Can you install appimages now?" $(echo "Awesome. We're almost done.")
yay -S icedrive-appimage
confirm "Is it cold in here?" $(echo "No, it's not - it's Florida.")
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
confirm "Do you really think you're going to need that?" $(echo "Whatever you say, Ellie.")
cd/tmp
git clone https://github.com/safing/portmaster-packaging
cd portmaster-packaging/linux
makepkg -is
confirm "Did portmaster install successfully?" $(echo "Finally.")

#Enable system services
reflector
systemctl enable NetworkManager
systemctl enable systemd-timesyncd.service
systemctl enable gdm.service
systemctl enable dhcpcd
systemctl enable portmaster
timedatectl status 
confirm "Did system services enable?" $(echo "Okay, time for a deep breath.")

#Run mkinitcpio 
mkinitcpio -p linux
confirm "Did it work?" $(echo "Thank God.")

#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
confirm "Are you ready to get out of here?" $(echo "Same.")

#Exit the chroot
exit
confirm "Last chance. Everything look good?" $(echo "Alright, let's do it.")

#Unmount the drive and reboot
umount -R /mnt
reboot
