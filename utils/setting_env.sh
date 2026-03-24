#!/usr/bin/env bash
set -euo pipefail

# Must be run like this
# while read -r host; do
#  echo "=== $host ==="
#  ssh -t aula@"$host" 'bash -s' < setting_env.sh
# done < ips.txt

echo "Authenticating sudo..."
sudo -v   # asks password once

sudo userdel -r cen5789
sudo adduser --quiet --home /data/home/cen5789 --gecos "" --disabled-password cen5789
#sudo adduser --quiet --home /data/home/cen5789 cen5789
sudo usermod -a -G sudo cen5789
sudo ln -s /data/home/cen5789 /home/cen5789
sudo usermod -d /home/cen5789 cen5789

sudo apt update
sudo apt-get install -y libcurl4-openssl-dev zlib1g-dev libbz2-dev build-essential libudunits2-dev libgdal-dev gdal-bin dbus-x11
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt update
sudo apt install -y apptainer

sudo rm  -rf /etc/singularity /usr/local/etc/singularity

sudo mkdir -p /data/cen5789_containers/

sudo wget -r -np -nd -A "*.sif" \
     -P /data/cen5789_containers/ \
     https://labbces.cena.usp.br/shared/CEN5789/containers/
sudo wget -P /data/cen5789_containers/ https://labbces.cena.usp.br/shared/CEN5789/containers/md5sum.txt
sudo chmod a+rx /data/cen5789_containers/
sudo chmod a+x /data/cen5789_containers/*.sif


HASH=$(openssl passwd -6 "passwdsss")
sudo usermod -p "$HASH" cen5789

#desktop setting for cen5789 user
sudo -u cen5789 dbus-launch gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/FondoCENA.png
sudo -u cen5789 dbus-launch gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'google-chrome.desktop']"
sudo -u cen5789 dbus-launch gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.Terminal.desktop']"

cd /data/cen5789_containers/
md5sum -c md5sum.txt
