#Clone and begin

pacman -Sy git
git clone https://github.com/Eliliyah/archinstall.git
cd archinstall
chmod +x part1.sh
./part1.sh

#Clone and continue
pacman -Sy git
git clone https://github.com/Eliliyah/archinstall.git
cd archinstall
chmod +x part2.sh
./part2.sh

#Double check everything and reboot
umount -R /mnt
reboot

#Install optional packages
cd/archinstall
./postinstall.sh

Done!

copy theme to /boot/grub/themes
