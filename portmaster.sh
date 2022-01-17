#!/usr/bin/bash

# Create portmaster data dir
mkdir -p /opt/safing/portmaster

# Download portmaster-start utility
wget -O /tmp/portmaster-start https://updates.safing.io/latest/linux_amd64/start/portmaster-start
sudo mv /tmp/portmaster-start /opt/safing/portmaster/portmaster-start
sudo chmod a+x /opt/safing/portmaster/portmaster-start

# Download resources
sudo /opt/safing/portmaster/portmaster-start --data /opt/safing/portmaster update

#Start core services
sudo /opt/safing/portmaster/portmaster-start core

#Start the Portmaster UI
/opt/safing/portmaster/portmaster-start app

#Start the Portmaster Notifier
/opt/safing/portmaster/portmaster-start notifier

#Start it on boot
cp /archinstall/portmaster.service /etc/systemd/system/portmaster.service

#Reload the systemd daemon and enable/start the Portmaster:
sudo systemctl daemon-reload
sudo systemctl enable --now portmaster

