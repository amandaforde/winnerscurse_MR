#! usr/bin/env Rscript

args=commandArgs(trailingOnly=TRUE)

pruned_SNPs <- read.table(args[1],header=TRUE)
summary_data <- read.table(args[2],header=TRUE)
summary_data <- summary_data[summary_data$rsid %in% pruned_SNPs$V1,]

write.table(summary_data, args[3],quote=FALSE,row.names=FALSE)
