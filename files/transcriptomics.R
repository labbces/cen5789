if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("tximport")
BiocManager::install("DESeq2")

install.packages(c('pheatmap','mclust','reshape2','ggplot2','readr'))


library(DESeq2)
library(tximport)

#Delete everithing in your R environment
rm(list=ls())

#Set your working directory. This should be the directoy containing all the Salmon results, remember you should have 16 folders with salmon results
wd<-"/data/diriano/cen5789_salmon/"
setwd(wd)

#Loading the experimental design
#we use the R read.delim to load a text file, that has columns separated by TABs, this is stores inside R as an object called target, a data.frame
targets<-read.delim("targets.txt",header=T)
rownames(targets)<-targets$SampleName

#Preparing to load the salmon quantification
#We need to prepare and object that has the sample names, and the location on disk of the quant.sf files produced by salmon
#We have the samples names in the target object, in the SampleName column,
# and we know that in our working directoy we have a folder for each sample,
# with the same name as the SampleName and the quat.sf file is inside that directory

myFiles<-paste(wd, targets$SampleName,"/quant.sf",sep="")

#Check whether these paths look ok
myFiles
#Add the sample name as the name of each path
names(myFiles)<-targets$SampleName
myFiles

#Check whether these paths actually exists on disk
all(file.exists(myFiles))

#Now, let load the mapping of transcript to gene identifiers
tx2gene<-read.delim("tx2gene.txt",header=F)
head(tx2gene)

#Let's see one example of a gene that has 3 transcripts
tx2gene[which(tx2gene$V2=='AT1G51370'),]

#Now, let's import the salmon quantification data into R, for this we will use the package tximport
txi.salmon<-tximport(files = myFiles, type = 'salmon', tx2gene = tx2gene, txIn = TRUE, txOut = FALSE)
