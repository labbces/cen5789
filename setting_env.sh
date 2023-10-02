sudo adduser --quiet cen5789
sudo usermod -a -G sudo cen5789

#logout and login as new user
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/FondoCENA.png

sudo apt update
sudo apt upgrade

#miniconda3
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash

#restart computer and then install conda software

#Software
conda config --add channels conda-forge
conda config --add channels bioconda

conda create -n emboss -c bioconda emboss
conda create -n blast -c bioconda blast
conda create -n flye -c bioconda flye
conda create -n hifiasm -c bioconda hifiasm
conda create -n bandage -c bioconda bandage
conda create -n quast -c bioconda quast
conda create -n genomescope2 -c bioconda genomescope2