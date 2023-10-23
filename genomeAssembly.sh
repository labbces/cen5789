cd ~/
mkdir dia4
cd dia4

conda activate sratoolkit
fasterq-dump --threads 3 --progress --outfile SRR25033384.fq SRR25033384
conda deactivate
gzip SRR25033384.fq


conda activate blast
git clone https://github.com/sheinasim/HiFiAdapterFilt.git
export PATH=$PATH:$HOME/dia4/HiFiAdapterFilt/:$HOME/dia4/HiFiAdapterFilt/DB
bash HiFiAdapterFilt/pbadapterfilt.sh -t 4 -p SRR25033384
conda deactivate

mkdir -p asm/hifiasm
cd asm/hifiasm

conda activate hifiasm
\time -v hifiasm  -o NRRLY27205.asm -t 5 ../../SRR25033384.fq.gz >  NRRLY27205.hifiasm.log 2> NRRLY27205.hifiasm.log
awk '/^S/{print ">"$2;print $3}' NRRLY27205.asm.bp.hap1.p_ctg.gfa > NRRLY27205.asm.bp.hap1.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' NRRLY27205.asm.bp.hap2.p_ctg.gfa > NRRLY27205.asm.bp.hap2.p_ctg.fa
awk '/^S/{print ">"$2;print $3}' NRRLY27205.asm.bp.p_ctg.gfa > NRRLY27205.asm.bp.p_ctg.fa
conda deactivate

cd ..
mkdir flye
cd flye
conda activate flye
\time -v flye  --threads 5 --pacbio-hifi SRR25033384.filt.fastq.gz --out-dir NRRLY27205.flye > NRRLY27205.flye.log 2> NRRLY27205.flye.log
conda deactivate

