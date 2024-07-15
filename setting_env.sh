sudo adduser --quiet cen5789
sudo usermod -a -G sudo cen5789

#logout and login as new user
gsettings set org.gnome.desktop.background picture-uri file:////usr/share/backgrounds/FondoCENA.png
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'google-chrome.desktop']"
gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'org.gnome.Terminal.desktop']"

sudo apt update
sudo apt upgrade
sudo apt-get install -y libcurl4-openssl-dev zlib1g-dev libbz2-dev build-essential libudunits2-dev libgdal-dev gdal-bin

#miniconda3
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
. /home/cen5789/.bashrc

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
conda activate genomescope2
conda install -y conda-forge::r-devtools
R -e 'require(remotes);install_version("Matrix", version = "1.6-1",repos="https://cloud.r-project.org/")'
R -e 'require(remotes);install_version("MASS", version = "7.3-60",repos="https://cloud.r-project.org/")'
R -e 'install.packages("viridis", repos="https://brieger.esalq.usp.br/CRAN/")'
conda deactivate

conda create -y -n redotable -c bioconda java-jdk
conda activate redotable
wget https://www.bioinformatics.babraham.ac.uk/projects/redotable/redotable_v1.2.zip
unzip redotable_v1.2.zip
cd redotable
mv redotable ~/miniconda3/envs/redotable/bin/
mv uk/ ~/miniconda3/envs/redotable/bin/
chmod a+x ~/miniconda3/envs/redotable/bin/redotable
cd ..
rm redotable_v1.2.zip
rm -rf redotable
conda deactivate

conda create -y -n fastqc -c bioconda fastqc
conda create -y -n bbmap -c bioconda bbmap


conda create -y -n sratoolkit -c bioconda sra-tools
conda create -y -n tidk -c bioconda tidk
conda create -y -n compleasm -c conda-forge -c bioconda compleasm
conda create -y -n merqury -c bioconda merqury

conda create -y -n jupiterplot -c bioconda circos samtools minimap2

conda create -y -n singularitycew -c wallaulab singularityce conda-forge::cni-plugins
ln -s /usr/bin/mksquashfs /usr/local/bin/
ln -s /usr/bin/unsquashfs /usr/local/bin/

conda create -y -n igv -c bioconda igv
conda create -y -n eggnogmapper -c bioconda -c conda-forge eggnog-mapper
wget https://github.com/gpertea/gffread/releases/download/v0.12.7/gffread-0.12.7.Linux_x86_64.tar.gz
tar xzf gffread-0.12.7.Linux_x86_64.tar.gz
sudo mv gffread-0.12.7.Linux_x86_64/gffread /usr/local/bin
rm -rf gffread-0.12.7.Linux_x86_64*

conda create -y -n transcriptomics -c conda-forge -c bioconda ffq python r-base r-ggplot2 bioconductor-tximport bioconductor-deseq2 fastqc bbmap multiqc

#R - From https://cran.r-project.org/bin/linux/ubuntu/#install-r
sudo apt -y update -qq
sudo apt -y install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt -y install libblas-dev liblapack-dev libatlas-base-dev gfortran zlib1g-dev libcurl4-openssl-dev libxml2-dev
sudo apt -y install --no-install-recommends r-base


#cd ~/Downloads; wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.09.1-494-amd64-debian.tar.gz
#tar xvzf rstudio-2023.09.1-494-amd64-debian.tar.gz
#sudo mv rstudio-2023.09.1+494/ /usr/local
#echo "PATH=$PATH:/usr/local/rstudio-2023.09.1+494/bin/" >> ~/.bashrc
#. ~/.bashrc

sudo apt install libfreetype6-dev libfontconfig1-dev
#In R running as sudo install sudo R
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.19")
BiocManager::install("tximport",update = FALSE, ask = FALSE)
BiocManager::install("DESeq2",update = FALSE, ask = FALSE)
BiocManager::install("topGO",update = FALSE,ask = FALSE)
BiocManager::install("Rgraphviz",update = FALSE,ask = FALSE)

install.packages(c('pheatmap','mclust','reshape2','ggplot2','readr'))
install.packages(c("ggVennDiagram","mclust"))
