#!/bin/bash

if [ $UID -ne 0 ]; then
  echo "Ce script doit être exécuté en tant qu'administrateur (root)."
  exit 1
fi
#####
# list of applications we want to install (Adapt with your needs)
liste="vim sudo ntpdate curl"
#####


# Update 
echo -e "\n Mise a jour de la liste des depots\n"
apt update

# Upgrade
echo -e "\n Mise a jour du systeme\n"
apt -y upgrade

# Installation
echo -e "\n Installation des logiciels suivants: $LISTE\n"
apt -y install $liste

echo -e "\n FIN."

#Sources repository for apt
wget -P /etc/apt/ https://repository.neuronesit.fr/repository/debian/

#Firewall desactivation
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

#http + https + ssh
echo "-A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT" >> /etc/iptables/rules.v4
echo "-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT" >> /etc/iptables/rules.v4













