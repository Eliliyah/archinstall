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

#Edit pacman.conf
#UseSyslog
Color
ILoveCandy
#NoProgressBar
CheckSpace
VerbosePkgLists
DisableDownloadTimeout
ParallelDownloads = 5

#Edit Grub
nano /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="EllieOS"
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 resume=UUID=PUT_THE_SWAP_UUID_HERE"
GRUB_CMDLINE_LINUX=""
GRUB_DISABLE_OS_PROBER=false

#Double check everything and reboot
umount -R /mnt
reboot

#Install optional packages
cd/archinstall
./postinstall.sh

Done!
