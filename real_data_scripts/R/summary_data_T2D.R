#! usr/bin/env Rscript


args=commandArgs(trailingOnly=TRUE)


## function to create a subsetted version of results for each chromosome, suitable for use with package

sub <- function(x){
  x <- x[,c(1,2,3,4,5,6,10,11)]
  names(x)[1] <- 'chr'
  names(x)[2] <- 'pos'
  names(x)[3] <- 'rsid'
  names(x)[4] <- 'ref_allele'
  names(x)[5] <- 'alt_allele'
  names(x)[6] <- 'A1_allele'
  names(x)[7] <- 'beta'
  names(x)[8] <- 'se'
  return(x)
}

T2DA_1 <- read.table(args[1],fill=TRUE)
T2DA_1 <- sub(T2DA_1)

T2DA_2 <- read.table(args[2],fill=TRUE)
T2DA_2 <- sub(T2DA_2)

T2DA_3 <- read.table(args[3],fill=TRUE)
T2DA_3 <- sub(T2DA_3)

T2DA_4 <- read.table(args[4],fill=TRUE)
T2DA_4 <- sub(T2DA_4)

T2DA_5 <- read.table(args[5],fill=TRUE)
T2DA_5 <- sub(T2DA_5)

T2DA_6 <- read.table(args[6],fill=TRUE)
T2DA_6 <- sub(T2DA_6)

T2DA_7 <- read.table(args[7],fill=TRUE)
T2DA_7 <- sub(T2DA_7)

T2DA_8 <- read.table(args[8],fill=TRUE)
T2DA_8 <- sub(T2DA_8)

T2DA_9 <- read.table(args[9],fill=TRUE)
T2DA_9 <- sub(T2DA_9)

T2DA_10 <- read.table(args[10],fill=TRUE)
T2DA_10 <- sub(T2DA_10)

T2DA_11 <- read.table(args[11],fill=TRUE)
T2DA_11 <- sub(T2DA_11)

T2DA_12 <- read.table(args[12],fill=TRUE)
T2DA_12 <- sub(T2DA_12)

T2DA_13 <- read.table(args[13],fill=TRUE)
T2DA_13 <- sub(T2DA_13)

T2DA_14 <- read.table(args[14],fill=TRUE)
T2DA_14 <- sub(T2DA_14)

T2DA_15 <- read.table(args[15],fill=TRUE)
T2DA_15 <- sub(T2DA_15)

T2DA_16 <- read.table(args[16],fill=TRUE)
T2DA_16 <- sub(T2DA_16)

T2DA_17 <- read.table(args[17],fill=TRUE)
T2DA_17 <- sub(T2DA_17)

T2DA_18 <- read.table(args[18],fill=TRUE)
T2DA_18 <- sub(T2DA_18)

T2DA_19 <- read.table(args[19],fill=TRUE)
T2DA_19 <- sub(T2DA_19)

T2DA_20 <- read.table(args[20],fill=TRUE)
T2DA_20 <- sub(T2DA_20)

T2DA_21 <- read.table(args[21],fill=TRUE)
T2DA_21 <- sub(T2DA_21)

T2DA_22 <- read.table(args[22],fill=TRUE)
T2DA_22 <- sub(T2DA_22)

T2DA <- rbind(T2DA_1,T2DA_2,T2DA_3,T2DA_4,T2DA_5,T2DA_6,T2DA_7,T2DA_8,T2DA_9,T2DA_10,T2DA_11,T2DA_12,T2DA_13,T2DA_14,T2DA_15,T2DA_16,T2DA_17,T2DA_18,T2DA_19,T2DA_20,T2DA_21,T2DA_22)

write.table(T2DA, args[23], quote=FALSE, row.names=FALSE)
