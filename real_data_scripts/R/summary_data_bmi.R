#! usr/bin/env Rscript


args=commandArgs(trailingOnly=TRUE)


## function to create a subsetted version of results for each chromosome, suitable for use with package

sub <- function(x){
  x <- x[,c(1,2,3,4,5,6,9,10)]
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

bmiA_1 <- read.table(args[1],fill=TRUE)
bmiA_1 <- sub(bmiA_1)

bmiA_2 <- read.table(args[2],fill=TRUE)
bmiA_2 <- sub(bmiA_2)

bmiA_3 <- read.table(args[3],fill=TRUE)
bmiA_3 <- sub(bmiA_3)

bmiA_4 <- read.table(args[4],fill=TRUE)
bmiA_4 <- sub(bmiA_4)

bmiA_5 <- read.table(args[5],fill=TRUE)
bmiA_5 <- sub(bmiA_5)

bmiA_6 <- read.table(args[6],fill=TRUE)
bmiA_6 <- sub(bmiA_6)

bmiA_7 <- read.table(args[7],fill=TRUE)
bmiA_7 <- sub(bmiA_7)

bmiA_8 <- read.table(args[8],fill=TRUE)
bmiA_8 <- sub(bmiA_8)

bmiA_9 <- read.table(args[9],fill=TRUE)
bmiA_9 <- sub(bmiA_9)

bmiA_10 <- read.table(args[10],fill=TRUE)
bmiA_10 <- sub(bmiA_10)

bmiA_11 <- read.table(args[11],fill=TRUE)
bmiA_11 <- sub(bmiA_11)

bmiA_12 <- read.table(args[12],fill=TRUE)
bmiA_12 <- sub(bmiA_12)

bmiA_13 <- read.table(args[13],fill=TRUE)
bmiA_13 <- sub(bmiA_13)

bmiA_14 <- read.table(args[14],fill=TRUE)
bmiA_14 <- sub(bmiA_14)

bmiA_15 <- read.table(args[15],fill=TRUE)
bmiA_15 <- sub(bmiA_15)

bmiA_16 <- read.table(args[16],fill=TRUE)
bmiA_16 <- sub(bmiA_16)

bmiA_17 <- read.table(args[17],fill=TRUE)
bmiA_17 <- sub(bmiA_17)

bmiA_18 <- read.table(args[18],fill=TRUE)
bmiA_18 <- sub(bmiA_18)

bmiA_19 <- read.table(args[19],fill=TRUE)
bmiA_19 <- sub(bmiA_19)

bmiA_20 <- read.table(args[20],fill=TRUE)
bmiA_20 <- sub(bmiA_20)

bmiA_21 <- read.table(args[21],fill=TRUE)
bmiA_21 <- sub(bmiA_21)

bmiA_22 <- read.table(args[22],fill=TRUE)
bmiA_22 <- sub(bmiA_22)

bmiA <- rbind(bmiA_1,bmiA_2,bmiA_3,bmiA_4,bmiA_5,bmiA_6,bmiA_7,bmiA_8,bmiA_9,bmiA_10,bmiA_11,bmiA_12,bmiA_13,bmiA_14,bmiA_15,bmiA_16,bmiA_17,bmiA_18,bmiA_19,bmiA_20,bmiA_21,bmiA_22)

write.table(bmiA, args[23], quote=FALSE, row.names=FALSE)
