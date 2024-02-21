#!/bin/bash

apt remove -y avahi-daemon avahi-utils

sed -i'' /LLMNR/s/.*/LLMNR=yes/ /etc/systemd/resolved.conf
sed -i'' /MulticastDNS/s/.*/MulticastDNS=yes/ /etc/systemd/resolved.conf

declare -A interfaces=$(ip link | egrep -o ': (.*):' | sed s/://g | awk -F @ '{print $1}' | grep -v lo)

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

# Persist mDNS settings after reboot
# for networkd
for interface in $interfaces; do
    cat > /etc/systemd/network/${interface}.network <<-EOS
[Match]
Name=${interface}

[Network]
MulticastDNS=yes
EOS
done
# for NetworkManager
cat > /etc/NetworkManager/conf.d/enable-mdns.conf <<-EOS
[connection]
connection.mdns=2
EOS

