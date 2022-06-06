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

#Install build tools
pacman -S --needed go go-tools meson vala make automake cmake extra-cmake-modules rust flatpak yajl docker ninja mea nodejs python python2 python-systemd qt5-tools jdk-openjdk jre-openjdk jre-openjdk-headless ruby rubygems--noconfirm

#Install important packages
pacman -Sy --needed aura accountsservice acpid adobe-source-han-sans-cn-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts alsa-firmware alsa-plugins alsa-utils b43-fwcutter bash-completion broadcom-wl-dkms btrfs-progs cantarell-fonts crda cryptsetup dbus dbus-glib dbus-pythondevice-mapper dhclient dialog diffutils dmidecode dmraid dnsmasq dnsutils dosfstools downgrade duf e2fsprogs ethtool exfatprogs f2fs-tools ffmpegthumbnailer findutils freetype2 fsarchiver fuse glances gnu-netcat haveged hdparm hwdetect hwinfo inetutils amd-ucode inxi ipw2100-fw ipw2200-fw iwd jfsutils less libdvdcss libgsf libopenraw libwnck3 lm_sensors logrotate lsb-release lsscsi lvm2 man-db man-pages mdadm meld mesa-utils mkinitcpio mkinitcpio-busybox mkinitcpio-nfs-utils mkinitcpio-openswap mlocate modemmanager mtools nano-syntax-highlighting nbd ndisc6 ibus net-tools networkmanager networkmanager-qt networkmanager-openvpn nfs-utils nilfs-utils nmap noto-fonts noto-color-emoji-fontconfig noto-fonts-emoji nss-mdns ntfs-3g ntp openconnect opendesktop-fonts openvpn os-prober pacman-contrib perl pkgfile poppler-glib ppp neofetch pptpclient pv python python-defusedxml python-packaging rebuild-detector reflector reflector-simple reiserfsprogs rp-pppoe rsync s-nail sed sg3_utils smartmontools sshfs sudo sysfsutils systemd-sysvcompat texinfo tldr power-profiles-daemon ttf-bitstream-vera ttf-dejavu ttf-liberation ttf-opensans unrar unzip upower usb_modeswitch usbutils vpnc wget which whois wireless-regdb wireless_tools wpa_supplicant wvdial xdg-user-dirs xdg-utils xf86-input-libinput xfsprogs xl2tpd xorg-server xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xterm xterm xz zsh --noconfirm


#install amd support
pacman -S amd-ucode amdgpu-pro-libgl amdvlk amf-amdgpu-pro opencl-amd xf86-video-amdgpu --noconfirm

#Install plasma 
pacman -S --needed ark avahi beautyline seahorse audiocd-kio breeze-gtk dolphin gwenview kdeconnect partitionmanager qt5-base pass kde-gtk-config ksystemlog kcalc kalarm pacmanlogviewer khotkeys kinfocenter kinit kio-fuse konsole kscreen kwallet-pam kwallet-manager okular plasma-desktop plasma-disks plasma-nm plasma-pa powerdevil sddm-kcm solid spectacle xsettingsd power-profiles-daemon qt5ct-kde qt6-base --noconfirm


#Instal optional applications
pacman -S --needed pamac-nosnap dolphin-plugins preload ffmpegthumbs kalarm kamoso kcalc kdegraphics-thumbnailers kdesdk-thumbnailers kfind kmix ksystemlog ktorrent aspell-en libappimage os-prober pacmanlogviewer oxygen latte-dock kvantum-theme-sweet-git ksystemstats kwalletmanager plasma-systemmonitor easyeffects  haskell-emojis garuda-starship-prompt firefox-extension-plasma-integration discover flameshot teamviewer --noconfirm


pacman -S --needed wine-installer fish fish-autopair gimp libreoffice-fresh android-sdk-cmdline-tools-latest android-tools android-ndk android-sdk-build-tools android-sdk-platform-tools gnome-logs discord meld file-roller vivaldi vivaldi-ffmpeg-codecs bitwarden code inkscape clementine bpytop firefox pam-u2f rclone gparted starship telegram aic94xx-firmware cdrtools debtap e2fs-progs exfat-utils masterpdfeditor-free ocs-url oxygen pacdiff-pacman-hook-git
--noconfirm


#Install media applications
pacman -S --needed openal opus sof-firmware pipewire pipewire-alsa pipewire-jack pipewire-media-session pipewire-pulse pipewire-support pipewire-v4l2 pipewire-x11-bell pipewire-zeroconf gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack lib32-pipewire-v4l2 alsa-card-profiles alsa-firmware alsa-lib alsa-plugins alsa-topology-conf alsa-ucm-conf alsa-utils lsp-plugins phonon-qt5-gstreamer phonon-qt5 pulseaudio-qt --noconfirm
pacman -S bluetooth-support bluez bluez-qt bluez-plugins bluez-tools bluez-utils bluetooth-autoconnect blueberry bluedevil blueman gnome-bluetooth --noconfirm
pacman -S --needed gst-libav gst-plugin-gtk gst-plugin-msdk gst-plugin-opencv gst-plugin-pipewire gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-plugins-bad-libs gst-plugins-base gst-plugins-base-libs gstreamer gstreamer-vaapi phonon-qt5-gstreamer --noconfirm

#Install android utilities
pacman -S android-apktool android-ndk android-platform android-sdk android-sdk-build-tools android-sdk-cmdline-tools-latest android-sdk-platform-tools android-tools android-udev protobuf python-protobuf reflector-simple zoxide 

#Install virtualbox
pacman -S --needed virtualbox-meta --noconfirm

#Install snapper
pacman -S snapper snapper-support snap-pac-grub snap-pac btrfs-assistant 
