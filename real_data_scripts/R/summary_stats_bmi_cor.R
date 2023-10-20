#! usr/bin/env Rscript


args=commandArgs(trailingOnly=TRUE)


## function to create a subsetted version of results for each chromosome, suitable for use with package

sub <- function(x){
  x <- x[,c(1,2,3,9,10)]
  names(x)[1] <- 'chr'
  names(x)[2] <- 'pos'
  names(x)[3] <- 'rsid'
  names(x)[4] <- 'beta'
  names(x)[5] <- 'se'
  return(x)
}

bmi_1 <- read.table(args[1],fill=TRUE)
bmi_1 <- sub(bmi_1)

bmi_2 <- read.table(args[2],fill=TRUE)
bmi_2 <- sub(bmi_2)

bmi_3 <- read.table(args[3],fill=TRUE)
bmi_3 <- sub(bmi_3)

bmi_4 <- read.table(args[4],fill=TRUE)
bmi_4 <- sub(bmi_4)

bmi_5 <- read.table(args[5],fill=TRUE)
bmi_5 <- sub(bmi_5)

bmi_6 <- read.table(args[6],fill=TRUE)
bmi_6 <- sub(bmi_6)

bmi_7 <- read.table(args[7],fill=TRUE)
bmi_7 <- sub(bmi_7)

bmi_8 <- read.table(args[8],fill=TRUE)
bmi_8 <- sub(bmi_8)

bmi_9 <- read.table(args[9],fill=TRUE)
bmi_9 <- sub(bmi_9)

bmi_10 <- read.table(args[10],fill=TRUE)
bmi_10 <- sub(bmi_10)

bmi_11 <- read.table(args[11],fill=TRUE)
bmi_11 <- sub(bmi_11)

bmi_12 <- read.table(args[12],fill=TRUE)
bmi_12 <- sub(bmi_12)

bmi_13 <- read.table(args[13],fill=TRUE)
bmi_13 <- sub(bmi_13)

bmi_14 <- read.table(args[14],fill=TRUE)
bmi_14 <- sub(bmi_14)

bmi_15 <- read.table(args[15],fill=TRUE)
bmi_15 <- sub(bmi_15)

bmi_16 <- read.table(args[16],fill=TRUE)
bmi_16 <- sub(bmi_16)

bmi_17 <- read.table(args[17],fill=TRUE)
bmi_17 <- sub(bmi_17)

bmi_18 <- read.table(args[18],fill=TRUE)
bmi_18 <- sub(bmi_18)

bmi_19 <- read.table(args[19],fill=TRUE)
bmi_19 <- sub(bmi_19)

bmi_20 <- read.table(args[20],fill=TRUE)
bmi_20 <- sub(bmi_20)

bmi_21 <- read.table(args[21],fill=TRUE)
bmi_21 <- sub(bmi_21)

bmi_22 <- read.table(args[22],fill=TRUE)
bmi_22 <- sub(bmi_22)

bmiA <- rbind(bmi_1,bmi_2,bmi_3,bmi_4,bmi_5,bmi_6,bmi_7,bmi_8,bmi_9,bmi_10,bmi_11,bmi_12,bmi_13,bmi_14,bmi_15,bmi_16,bmi_17,bmi_18,bmi_19,bmi_20,bmi_21,bmi_22)


write.table(bmiA, args[23], quote=FALSE, row.names=FALSE)
