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
groupadd fuse
usermod -a -G fuse ellie
confirm "Do you exist now?" 

#Enable SysRq key
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99-sysctl.conf

#Install chaotic AUR keyring
pacman-key --init
pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key FBA220DFC880C036
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist">> /etc/pacman.conf
pacman-key -u
pacman -Syu

#Move and copy files
chmod +x postinstall.sh
mkdir /etc/backupfolder
mv /etc/mkinitcpio.conf /etc/backupfolder
cp /archinstall/mkinitcpio.conf /etc/mkinitcpio.conf
ls /etc/backupfolder
ls /etc/pacman.d
confirm "Did all the files copy successfully?" 

#check configs
nano /etc/pacman.conf
nano /etc/mkinitcpio.conf
confirm "Everything look right?"

#Refresh mirrors
pacman -Syu
reflector
confirm "Mirrors okay?"
#Install important packages
pacman -Sy accountsservice adobe-source-han-sans-cn-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts alsa-firmware alsa-plugins alsa-utils b43-fwcutter bash-completion broadcom-wl-dkms btrfs-progs cantarell-fonts crda cryptsetup device-mapper dhclient dialog diffutils dmidecode dmraid dnsmasq dnsutils dosfstools downgrade duf 
pacman -S e2fsprogs ethtool exfatprogs f2fs-tools ffmpegthumbnailer findutils freetype2 fsarchiver fuse glances gnu-netcat haveged hdparm hwdetect hwinfo inetutils intel-ucode inxi ipw2100-fw ipw2200-fw iwd jfsutils keyserver-rank less libdvdcss libgsf libopenraw libwnck3 logrotate lsb-release lsscsi lvm2 man-db man-pages mdadm meld mesa-utils 
pacman -S mkinitcpio mkinitcpio-busybox mkinitcpio-nfs-utils mkinitcpio-openswap mlocate modemmanager mtools nano-syntax-highlighting nbd ndisc6 neofetch net-tools networkmanager networkmanager-openvpn nfs-utils nilfs-utils nmap noto-fonts nss-mdns ntfs-3g ntp openconnect opendesktop-fonts openvpn os-prober pacman-contrib pcurses perl pkgfile 
pacman -S poppler-glib ppp pptpclient pv python python-defusedxml python-packaging rebuild-detector reflector reflector-simple reiserfsprogs rp-pppoe rsync s-nail sed sg3_utils smartmontools sof-firmware sshfs sudo sysfsutils systemd-sysvcompat texinfo tldr power-profiles-daemon ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans unrar 
pacman -S unzip upower usb_modeswitch usbutils vpnc wget which whois wireless-regdb wireless_tools wpa_supplicant wvdial xdg-user-dirs xdg-utils xf86-input-libinput xf86-video-intel xfsprogs xl2tpd xorg-server xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xterm xterm mkinitcpio xz zsh
confirm "All good?" 

#Install build tools
pacman -S go go-tools meson cmake extra-cmake-modules rust flatpak yajl docker --noconfirm
confirm "All good?" 

#Install plasma 
pacman -S ark audiocd-kio breeze-gtk dolphin elisa gwenview kdeconnect qt5-base pass kde-gtk-config ksystemlog kcalc kalarm pacmanlogviewer khotkeys kinfocenter kinit kio-fuse konsole kscreen kwallet-pam okular plasma-desktop plasma-disks plasma-nm plasma-pa powerdevil sddm-kcm solid spectacle xsettingsd power-profiles-daemon --noconfirm
confirm "All good?" 

#Instal optional applications
pacman -S dolphin-plugins preload ffmpegthumbs kalarm kamoso kcalc kdegraphics-thumbnailers kdesdk-thumbnailers kfind kmix ksystemlog ktorrent aspell-en libappimage os-prober pacmanlogviewer oxygen latte-dock kvantum-theme-sweet-git ksystemstats jamesdsp intel-gpu-tools intel-media-driver haskell-emojis garuda-starship-prompt firefox-extension-plasma-integration discover --noconfirm
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

#Install blackarch
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh
confirm "Do you really think you're going to need that?" 

#Enable system services
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable power-profiles-daemon 
systemctl enable pipewire-media-session 
systemctl enable bluetooth
systemctl enable preload
confirm "Did system services enable?" 

#Configure journal
echo "Storage=persistent">> /etc/systemd/journald.conf

#Configure zram
pacman -S zram-generator
cp /archinstall/zram-generator.conf /etc/systemd/zram-generator.conf

#Run mkinitcpio 
mkinitcpio -p linux
mkinitcpio -p linux-zen
confirm "Did it work?" 

#Install bootloader
pacman -S grub 
pacman -S grub-btrfs efibootmgr efivar efitools
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
ls /etc/default
confirm "Is the grub file there?"
nano /etc/default/grub
mv /archinstall/EllieOS /usr/share/grub/themes
echo "GRUB_THEME="/usr/share/grub/themes/EllieOS/theme.txt"">> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
confirm "All good?" 
