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

height_1 <- read.table(args[1],fill=TRUE)
height_1 <- sub(height_1)

height_2 <- read.table(args[2],fill=TRUE)
height_2 <- sub(height_2)

height_3 <- read.table(args[3],fill=TRUE)
height_3 <- sub(height_3)

height_4 <- read.table(args[4],fill=TRUE)
height_4 <- sub(height_4)

height_5 <- read.table(args[5],fill=TRUE)
height_5 <- sub(height_5)

height_6 <- read.table(args[6],fill=TRUE)
height_6 <- sub(height_6)

height_7 <- read.table(args[7],fill=TRUE)
height_7 <- sub(height_7)

height_8 <- read.table(args[8],fill=TRUE)
height_8 <- sub(height_8)

height_9 <- read.table(args[9],fill=TRUE)
height_9 <- sub(height_9)

height_10 <- read.table(args[10],fill=TRUE)
height_10 <- sub(height_10)

height_11 <- read.table(args[11],fill=TRUE)
height_11 <- sub(height_11)

height_12 <- read.table(args[12],fill=TRUE)
height_12 <- sub(height_12)

height_13 <- read.table(args[13],fill=TRUE)
height_13 <- sub(height_13)

height_14 <- read.table(args[14],fill=TRUE)
height_14 <- sub(height_14)

height_15 <- read.table(args[15],fill=TRUE)
height_15 <- sub(height_15)

height_16 <- read.table(args[16],fill=TRUE)
height_16 <- sub(height_16)

height_17 <- read.table(args[17],fill=TRUE)
height_17 <- sub(height_17)

height_18 <- read.table(args[18],fill=TRUE)
height_18 <- sub(height_18)

height_19 <- read.table(args[19],fill=TRUE)
height_19 <- sub(height_19)

height_20 <- read.table(args[20],fill=TRUE)
height_20 <- sub(height_20)

height_21 <- read.table(args[21],fill=TRUE)
height_21 <- sub(height_21)

height_22 <- read.table(args[22],fill=TRUE)
height_22 <- sub(height_22)

heightA <- rbind(height_1,height_2,height_3,height_4,height_5,height_6,height_7,height_8,height_9,height_10,height_11,height_12,height_13,height_14,height_15,height_16,height_17,height_18,height_19,height_20,height_21,height_22)


write.table(heightA, args[23], quote=FALSE, row.names=FALSE)
