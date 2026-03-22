#!/bin/bash
#script must be run with sudo

userdel -r cen5789
adduser --quiet --home /data/home/cen5789 cen5789
usermod -a -G sudo cen5789
ln -s /data/home/cen5789 /home/cen5789

apt update
apt-get install -y libcurl4-openssl-dev zlib1g-dev libbz2-dev build-essential libudunits2-dev libgdal-dev gdal-bin
apt install -y software-properties-common
add-apt-repository -y ppa:apptainer/ppa
apt update
apt install -y apptainer

rm  -rf /etc/singularity /usr/local/etc/singularity

mkdir -p /data/cen5789_containers/

wget -r -np -nd -A "*.sif" \
     -P /data/cen5789_containers/ \
     https://labbces.cena.usp.br/shared/CEN5789/containers/

chmod a+rx /data/cen5789_containers/
chmod a+x /data/cen5789_containers/*.sif

#desktop setting for cen5789 user
sudo -u cen5789 dbus-launch gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/FondoCENA.png
sudo -u cen5789 dbus-launch gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'google-chrome.desktop']"
sudo -u cen5789 dbus-launch gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.Terminal.desktop']"

