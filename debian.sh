#!/bin/bash

apt update
apt upgrade -y
apt install -y curl gnupg2

curl "https://raw.githubusercontent.com/JackDanger/dotfiles/main/debian.mdns.sh" -H "Cache-Control: no-cache" | bash

grep -q daemon-reload /etc/bash.bashrc || tee -a /etc/bash.bashrc <<-EOS
alias l='ls -lAG'
alias reload='systemctl daemon-reload'
alias start='systemctl start'
alias stop='systemctl stop'
alias restart='systemctl restart'
alias status='systemctl status'
alias journal='journalctl -f -u'
EOS
