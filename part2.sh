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
confirm "Are you ready to keep going?" 

#Generate locales
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8">> /etc/locale.gen
locale-gen 
confirm "Did locales generate?"
echo "LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_NUMERIC=en_US.UTF-8
LANGUAGE=en_US.UTF-8">> /etc/locale.conf
echo "KEYMAP=us
FONT=Lat2-Terminus16">> /etc/vconsole.conf
echo "ellie">> /etc/hostname
nano /etc/locale.gen
confirm "Did the time set correctly?" 

#Set the root password
passwd
EDITOR=nano visudo

#add yourself as a user
useradd -m -G wheel -s /bin/bash ellie
passwd ellie
confirm "Do you exist now?" 

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#Move and copy files
chmod +x postinstall.sh
mkdir /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
echo "
[endeavouros]
Include = /etc/pacman.d/endeavouros-mirrorlist

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist">> /etc/pacman.conf
cp /archinstall/endeavouros-mirrorlist /etc/pacman.d/endeavouros-mirrorlist
cp /archinstall/chaotic-mirrorlist /etc/pacman.d/chaotic-mirrorlist
ls /etc/backupfolder
ls /etc/pacman.d
confirm "Did all the files copy successfully?" 

#check configs
nano /etc/pacman.conf
nano /etc/mkinitcpio.conf
confirm "Everything look right?"

#Refresh mirrors
pacman-key --init
reflector
confirm "Mirrors okay?"

#Install important packages
pacman -S accountsservice adobe-source-han-sans-cn-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts alsa-firmware alsa-plugins alsa-utils b43-fwcutter base-devel bash-completion broadcom-wl-dkms btrfs-progs cantarell-fonts crda cryptsetup device-mapper dhclient dialog diffutils dmidecode dmraid dnsmasq dnsutils dosfstools downgrade duf e2fsprogs efibootmgr efitools ethtool exfatprogs f2fs-tools ffmpegthumbnailer findutils freetype2 fsarchiver git glances gnu-netcat grub grub-tools grub-btrfs haveged hdparm hwdetect hwinfo inetutils intel-ucode inxi ipw2100-fw ipw2200-fw iwd jfsutils keyserver-rank less libdvdcss libgsf libopenraw libwnck3 linux-zen linux-zen-headers logrotate lsb-release lsscsi lvm2 man-db man-pages mdadm meld mesa-utils mkinitcpio mkinitcpio-busybox mkinitcpio-nfs-utils mkinitcpio-openswap mlocate modemmanager mtools nano nano-syntax-highlighting nbd ndisc6 neofetch net-tools networkmanager networkmanager-openvpn nfs-utils nilfs-utils nmap noto-fonts nss-mdns ntfs-3g ntp openconnect opendesktop-fonts openvpn os-prober pacman-contrib pcurses perl pkgfile poppler-glib ppp pptpclient pv python python-defusedxml python-packaging rebuild-detector reflector reflector-simple reiserfsprogs rp-pppoe rsync s-nail sed sg3_utils smartmontools sof-firmware sshfs sudo sysfsutils systemd-sysvcompat texinfo tldr power-profiles-daemon ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans unrar unzip upower usb_modeswitch usbutils vpnc wget which whois wireless-regdb wireless_tools wpa_supplicant wvdial xdg-user-dirs xdg-utils xf86-input-libinput xf86-video-intel xfsprogs xl2tpd xorg-server xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xterm xterm mkinitcpio xz zsh
confirm "All good?" 

#Install build tools
pacman -S go go-tools perl meson cmake extra-cmake-modules rust flatpak snapd yajl wget curl --noconfirm
confirm "All good?" 

#Install aur helper
pacman -S aura
confirm "All good?" 

#Install plasma 
pacman -S ark audiocd-kio breeze-gtk dolphin elisa gwenview kdeconnect qt5-base pass kde-gtk-config khotkeys kinfocenter kinit kio-fuse konsole kscreen kwallet-pam okular plasma-desktop plasma-disks plasma-nm plasma-pa powerdevil sddm-kcm solid spectacle xsettingsd power-profiles-daemon --noconfirm
confirm "All good?" 

#Instal optional applications
pacman -S dolphin-plugins ffmpegthumbs kalarm kamoso kcalc kdegraphics-thumbnailers kdesdk-thumbnailers kfind kmix ksystemlog ktorrent aspell-en libappimage os-prober pacmanlogviewer oxygen masterpdfeditor-free latte-dock kvantum-theme-sweet-git ksystemstats jamesdsp intel-gpu-tools intel-media-driver haskell-emojis garuda-starship-prompt firefox-extension-plasma-integration discover android-sdk-cmdline-tools-latest android-sdk-platform-tools --noconfirm
confirm "All good?" 

pacman -S fish fish-autopair gimp libreoffice-fresh discord meld file-roller vivaldi vivaldi-ffmpeg-codecs bitwarden code inkscape clementine bpytop firefox pam-u2f rclone gparted starship --noconfirm
confirm "All good?" 

#Install audio applications
pacman -S pipewire sof-firmware
pacman -S pipewire-alsa pipewire-jack pipewire-media-session pipewire-pulse pipewire-v4l2 pipewire-zeroconf gst-plugin-pipewire alsa-card-profiles lv2 openal opus bluez bluedevil --noconfirm
confirm "All good?" 

#Install virtualbox
pacman -S virtualbox-ext-vnc virtualbox-guest-iso virtualbox-guest-utils virtualbox-host-dkms virtualbox-sdk --noconfirm
confirm "All good?" 

#Install zram
echo "zram">> /etc/modules-load.d/zram.conf
echo "options zram num_devices=2">> /etc/modprobe.d/zram.conf
echo "KERNEL=="zram0", ATTR{disksize}="512M" RUN="/usr/bin/mkswap /dev/zram0", TAG+="systemd"
KERNEL=="zram1", ATTR{disksize}="512M" RUN="/usr/bin/mkswap /dev/zram1", TAG+="systemd"">> /etc/udev/rules.d/99-zram.rules
echo "
/dev/zram0 none swap defaults 0 0
/dev/zram1 none swap defaults 0 0" >> /etc/fstab
nano /etc/fstab
confirm "Zram looking good?"

#Install blackarch
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
confirm "Do you really think you're going to need that?" 

#Enable system services
systemctl enable NetworkManager
systemctl enable sddm.service
systemctl enable power-profiles-daemon 
systemctl enable pipewire.service pipewire-media-session.service 
systemctl --user enable pipewire.service pipewire-media-session.service 
systemctl enable bluetooth.service
confirm "Did system services enable?" 

#Run mkinitcpio 
mkinitcpio -p linux
mkinitcpio -p linux-zen
confirm "Did it work?" 

#Install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
mv /archinstall/EllieOS /usr/share/grub/themes
echo "GRUB_THEME="/usr/share/grub/themes/EllieOS/theme.txt"">> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
nano /etc/default/grub
confirm "All good?" 

done
