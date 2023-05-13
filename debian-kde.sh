#!/bin/bash
# Copyright 2023 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Default packages are for the configuration and corresponding .config folders
# Install packages after installing base Debian with no GUI
# My recommended theme for kde is Lavanda

echo
echo "****************************************************"
echo "****  RECOMMENDATION TO ONLY USE IF YOU ARE ON  ****"
echo "****      DEBIAN BULLSEYE MINIMAL INSTALL       ****"
echo
echo "This script is intended for Debian Bullseye Minimal Install"
read -p "Do you want to proceed? (yes/no) " yn

case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac
echo
echo
echo
echo "*******************************************************"
echo "****  Installing Xorg packages from Debian Stable  ****"
echo
# xorg display server installation
sudo apt install -yy xorg xbacklight xbindkeys xvkbd xinput xorg-dev
echo
echo
echo "*********************************************************"
echo "****  Installing Build Essential from Debian Stable  ****"
echo
# INCLUDES make,etc.
sudo apt install -yy build-essential 
echo
echo
echo "***************************************************"
echo "****  Installing Microcode from Debian Stable  ****"
echo
# Microcode for Intel/AMD 
# sudo apt install -y amd64-microcode
sudo apt install -yy intel-microcode 
echo
echo
echo
echo "*********************************************************"
echo "****  Installing Yakuake terminal from Debian Stable   ****"
echo
# Terminal (eg. terminator,kitty,xfce4-terminal)
sudo apt install -yy yakuake
echo
echo
echo "************************************************"
echo "****  Installing Tools from Debian Stable   ****"
echo
sudo apt install mtools dosfstools acpi acpid timeshift avahi-daemon gvfs-backends -yy
sudo systemctl enable acpid
sudo systemctl enable avahi-daemon
echo
echo
echo "********************************************************"
echo "****  Installing Neofetch/Htop from Debian and lavanda theme Stable   ****"
echo
# Neofetch/HTOP
sudo apt install -yy neofetch htop
https://github.com/vinceliuice/Lavanda-kde.git
cd Lavanda-kde
sudo ./install.sh
echo
echo
echo "***********************************************"
echo "****  Installing Google Chrome and spotify using non-free Repository   ****"
echo
# Browser Installation (eg. chromium)
wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install google-chrome-stable
sudo apt install spotify-client
echo
echo "****************************************************************************"
echo "****  Installing Favourite Apps from Debian Stable   ****"
echo
# Packages needed after installation
sudo apt install discord telegram-desktop vlc lutris steam obs-studio -yy
echo
echo
echo "******************************************************"
echo "****  Installing sddm from Debian Stable   ****"
echo
echo
# Install Lightdm Console Display Manager
sudo apt install -y sddm
sudo systemctl enable sddm
echo
echo "***************************************************"
echo "****  Adding Debian unstable/sid to apt list   ****"
echo
echo
sudo echo 'deb http://deb.debian.org/debian/ unstable main non-free contrib' | sudo tee -a /etc/apt/sources.list
echo
echo "********************************************"
echo "****   Adding Preferences to Apt List   ****"
echo
echo
cat > ./temp << "EOF"
Package: *
Pin: release a=bullseye
Pin-Priority: 500

Package: linux-image-amd64
Pin: release a=unstable
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 100
EOF
sudo cp ./temp /etc/apt/preferences;rm ./temp
echo

echo "*********************************************"
echo "****  Add Latest Kernel from Debian Sid  ****"
echo
sudo apt update -yy && sudo apt upgrade -yy
echo
echo "******************************************************"
echo "****  Desktop env. selecting using tasksel   ****"
echo
sudo apt install tasksel -y
sudo tasksel
echo
echo
echo
echo "******************************************"
echo "****  Remove Debian Bullseye Kernel   ****"
echo
sudo apt autoremove -yy
echo "********************************"
echo "****   Autoremove command   ****"
sudo apt autoremove -yy
echo

printf "\e[1;32mDone! you can now reboot.\e[0m\n"


