#! /usr/bin/env Rscript
args=commandArgs(trailingOnly=TRUE)

H <- read.table(args[1], header=TRUE, fill=TRUE)
H <- H[is.na(H[,3]) == FALSE,]

B <- read.table(args[2], header=TRUE, fill=TRUE)
B <- B[is.na(B[,3]) == FALSE,]

common <- intersect(H[,1],B[,1])

H <- H[H[,1] %in% common,]
B <- B[B[,1] %in% common,]

sample_size <- 100000
set.seed(1998)
picked <- sample(seq_len(nrow(H)),size=sample_size)
gwas_H <- H[picked,]
gwas_B<- B[B[,1] %in% gwas_H[,1],]

gwas_H <- gwas_H[order(gwas_H[,1]),]
gwas_B <- gwas_B[order(gwas_B[,1]),]

cor_HB <- data.frame(cor_HB=cor(gwas_H[,3],gwas_B[,3]))

write.table(gwas_H,args[3],quote=FALSE,row.names=FALSE,col.names=c('id','id','height'))
write.table(gwas_B,args[4],quote=FALSE,row.names=FALSE,col.names=c('id','id','bmi'))
write.table(cor_HB,args[5],quote=FALSE,row.names=FALSE)


write.table()
