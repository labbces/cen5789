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

conda create -y -n emboss -c bioconda emboss
conda create -y -n blast -c bioconda blast
conda create -y -n flye -c bioconda flye
conda create -y -n hifiasm -c bioconda hifiasm
conda create -y -n bandage -c bioconda bandage
conda create -y -n quast -c bioconda quast
conda create -y -n genomescope2 -c bioconda genomescope2

#

conda create -y -n redotable -c bioconda java-jdk
conda activate redotable
wget https://www.bioinformatics.babraham.ac.uk/projects/redotable/redotable_v1.2.zip
unzip redotable_v1.2.zip
cd redotable
mv redotable ~/miniconda3/envs/redotable/bin/
mv uk/ ~/miniconda3/envs/redotable/bin/
cd ..
rm redotable_v1.2.zip
rm -rf redotable
conda deactivate

conda create -y -n fastqc -c bioconda fastqc
conda create -y -n bbmap -c bioconda bbmap
