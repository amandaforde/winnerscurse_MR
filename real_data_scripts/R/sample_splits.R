#! /usr/bin/env Rscript
args=commandArgs(trailingOnly=TRUE)

H <- read.table(args[1], header=TRUE, fill=TRUE)
H <- H[is.na(H[,3]) == FALSE,]

B <- read.table(args[2], header=TRUE, fill=TRUE)
B <- B[is.na(B[,3]) == FALSE,]

common <- intersect(H[,1],B[,1])

H <- H[H[,1] %in% common,]
B <- B[B[,1] %in% common,]

sample_size <- 450000

set.seed(1998)

## Zero overlap

sample_size0 <- 225000

picked_full <- sample(seq_len(nrow(H)),size=sample_size)
H_full <- H[picked_full,]

picked_half <- sample(seq_len(nrow(H_full)),size=sample_size0)

gwas_H <- H_full[picked_half,]
gwas_H2 <- H_full[-picked_half,]
gwas_B <- B[B[,1] %in% gwas_H2[,1],]

H <- H[order(H[,1]),]
B <- B[order(B[,1]),]

#cor_HB <- data.frame(cor_HB=cor(H[,3],B[,3]))
#check_HB <- intersect(gwas_H[,1],gwas_B[,1])
#write.table(cor_HB,args[3],quote=FALSE,row.names=FALSE)

write.table(gwas_H,args[3],quote=FALSE,row.names=FALSE,col.names=c('id','id','bmi'))
write.table(gwas_B,args[4],quote=FALSE,row.names=FALSE,col.names=c('id','id','T2D'))
#write.table(check_HB,args[6],quote=FALSE,row.names=FALSE)

## 25% overlap

sample_size_same <- 56250
picked_same <- sample(seq_len(nrow(H)),size=sample_size_same)

H_same <- H[picked_same,]
H_diff <- H[-picked_same,]

sample_size_diff <- 337500
picked_diff <- sample(seq_len(nrow(H_diff)),size=sample_size_diff)
H_diff <- H_diff[picked_diff,]

size_half <- 168750
picked_half <- sample(seq_len(nrow(H_diff)),size=size_half)

H_diff1 <- H_diff[picked_half,]
H_diff2 <- H_diff[-picked_half,]

gwas_H <- H[H[,1] %in% H_same[,1] | H[,1] %in% H_diff1[,1],]
gwas_B <- B[B[,1] %in% H_same[,1] | B[,1] %in% H_diff2[,1],]

#check_HB <- intersect(gwas_H[,1],gwas_B[,1])

write.table(gwas_H,args[5],quote=FALSE,row.names=FALSE,col.names=c('id','id','bmi'))
write.table(gwas_B,args[6],quote=FALSE,row.names=FALSE,col.names=c('id','id','T2D'))
#write.table(check_HB,args[9],quote=FALSE,row.names=FALSE)

## 50% overlap

sample_size_same <- 112500
picked_same <- sample(seq_len(nrow(H)),size=sample_size_same)

H_same <- H[picked_same,]
H_diff <- H[-picked_same,]

sample_size_diff <- 225000
picked_diff <- sample(seq_len(nrow(H_diff)),size=sample_size_diff)
H_diff <- H_diff[picked_diff,]

size_half <- 112500
picked_half <- sample(seq_len(nrow(H_diff)),size=size_half)

H_diff1 <- H_diff[picked_half,]
H_diff2 <- H_diff[-picked_half,]

gwas_H <- H[H[,1] %in% H_same[,1] | H[,1] %in% H_diff1[,1],]
gwas_B <- B[B[,1] %in% H_same[,1] | B[,1] %in% H_diff2[,1],]
#check_HB <- intersect(gwas_H[,1],gwas_B[,1])

write.table(gwas_H,args[7],quote=FALSE,row.names=FALSE,col.names=c('id','id','bmi'))
write.table(gwas_B,args[8],quote=FALSE,row.names=FALSE,col.names=c('id','id','T2D'))
#write.table(check_HB,args[12],quote=FALSE,row.names=FALSE)

## 75% overlap

sample_size_same <- 168750
picked_same <- sample(seq_len(nrow(H)),size=sample_size_same)

H_same <- H[picked_same,]
H_diff <- H[-picked_same,]

sample_size_diff <- 112500
picked_diff <- sample(seq_len(nrow(H_diff)),size=sample_size_diff)
H_diff <- H_diff[picked_diff,]

size_half <- 56250
picked_half <- sample(seq_len(nrow(H_diff)),size=size_half)

H_diff1 <- H_diff[picked_half,]
H_diff2 <- H_diff[-picked_half,]

gwas_H <- H[H[,1] %in% H_same[,1] | H[,1] %in% H_diff1[,1],]
gwas_B <- B[B[,1] %in% H_same[,1] | B[,1] %in% H_diff2[,1],]

#check_HB <- intersect(gwas_H[,1],gwas_B[,1])

write.table(gwas_H,args[9],quote=FALSE,row.names=FALSE,col.names=c('id','id','bmi'))
write.table(gwas_B,args[10],quote=FALSE,row.names=FALSE,col.names=c('id','id','T2D'))
#write.table(check_HB,args[15],quote=FALSE,row.names=FALSE)

## Full overlap

sample_size100 <- 225000
picked <- sample(seq_len(nrow(H)),size=sample_size100)

gwas_H <- H[picked,]
gwas_B <- B[B[,1] %in% gwas_H[,1],]
#check_HB <- intersect(gwas_H[,1],gwas_B[,1])

write.table(gwas_H,args[11],quote=FALSE,row.names=FALSE,col.names=c('id','id','bmi'))
write.table(gwas_B,args[12],quote=FALSE,row.names=FALSE,col.names=c('id','id','T2D'))
#write.table(check_HB,args[18],quote=FALSE,row.names=FALSE)
