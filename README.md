# Unattended-debian-installation
There is many ways to do an automatic debian installation. We are going to use a preseed file.  Preseeding provides a way to set answers to questions asked during the installation process, without having to manually enter the answers while the installation is running.



# Instructions
This script create an .iso with preseed file to allow an automatic installation.



## Requirements

* **genisoimage** package installed



## How to use the script

* Create a directory isofiles in /home , isofiles/stock and isofiles/isoCp (if you want you can modify the script with your own directories).

* Place the script and the debian iso in /home
* Launch the script in **root** 

## Miscellaneous

You have a script post installation to install some basics packages, you have to launch it in **root** because you don't have **sudo** on basic debian.
