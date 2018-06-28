#!/bin/bash

if [ $UID -ne 0 ]; then
  echo "Ce script doit être exécuté en tant qu'administrateur (root)."
  exit 1
fi
#####
# Liste des applications ànstaller: A adapter a vos besoins
liste="vim sudo ntpdate curl"
#####

# Mise a jour de la liste des depots
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

#apt-setup/repository string https://repository.neuronesit.fr/repository/debian/
