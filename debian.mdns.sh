#!/bin/bash

apt remove -y avahi-daemon avahi-utils
apt autoremove -y

if [ -f /etc/systemd/resolved.conf ]; then
  sed -i'' /LLMNR/s/.*/LLMNR=yes/ /etc/systemd/resolved.conf
  sed -i'' /MulticastDNS/s/.*/MulticastDNS=yes/ /etc/systemd/resolved.conf
fi

declare -A interfaces=$(ip link | egrep -o ': (.*):' | sed s/://g | awk -F @ '{print $1}' | grep -v lo)

##
## Persist mDNS settings after reboot
##

# for networkd
if [ -d /etc/systemd/network/ ]; then
  for interface in $interfaces; do
    cat > /etc/systemd/network/${interface}.network <<-EOS
[Match]
Name=${interface}

[Network]
MulticastDNS=yes
EOS
  done
fi
# for NetworkManager
if [ -d /etc/NetworkManager/conf.d ]; then
  cat > /etc/NetworkManager/conf.d/enable-mdns.conf <<-EOS
[connection]
connection.mdns=2
EOS
fi

# Allow .local hostname lookups via mDNS resolution
if which systemd-resolve; then
  for interface in $interfaces; do
    systemd-resolve --set-mdns=yes --interface=${interface}
  done
elif which resolvectl; then
  for interface in $interfaces; do
    resolvectl mdns ${interface} yes
  done
fi

systemctl restart systemd-resolved
resolvectl status
