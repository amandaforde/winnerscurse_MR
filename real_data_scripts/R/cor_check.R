#! usr/bin/env Rscript

dir.create(Sys.getenv('R_LIBS_USER'),recursive=TRUE)
.libPaths(Sys.getenv('R_LIBS_USER'))

install.packages('pracma',repos="http://cran.us.r-project.org")

args=commandArgs(trailingOnly=TRUE)

library(pracma)

data_exp <- read.table(args[1],header=TRUE)
data_out <- read.table(args[2],header=TRUE)

library(pracma)

data_exp <- read.table(args[1],header=TRUE)
data_out <- read.table(args[2],header=TRUE)

data_exp <- data_exp[is.na(data_exp[,4])==FALSE,]
data_out <- data_out[is.na(data_out[,4])==FALSE,]

common<- intersect(data_exp[,3],data_out[,3])

data_out <- data_out[data_out[,3] %in% common,]
data_exp <- data_exp[data_exp[,3] %in% common,]

data <- data.frame(SNP=data_exp$rsid, beta.exposure=data_exp$beta, se.exposure=data_exp$se, beta.outcome=data_out$beta, se.outcome=data_out$se)

n <- nrow(data)
A <- sum((data$beta.exposure/data$se.exposure)^2)
C <- sum((data$beta.outcome/data$se.outcome)^2)

B <- sum((data$beta.exposure/data$se.exposure)*(data$beta.outcome/data$se.outcome))

fun1 <- function(x){-(n/2)*(log(1-x^2))-((1)/(2*(1-x^2)))*(A-2*x*B+C)}
cor1 <- optimize(fun1, interval=c(-1,1),maximum=TRUE)$maximum

data <- data[abs(data$beta.exposure/data$se.exposure) < 0.5 & abs(data$beta.outcome/data$se.outcome) < 0.5,]
n <- nrow(data)
A <- sum((data$beta.exposure/data$se.exposure)^2)
C <- sum((data$beta.outcome/data$se.outcome)^2)

B <- sum((data$beta.exposure/data$se.exposure)*(data$beta.outcome/data$se.outcome))
fun2 <- function(lambda){
  -((1)/(2*(1-lambda^2)))*(A-2*lambda*B+C) -
    n*log(pracma::integral2(function(x,y)
      exp((-(1)/(2*(1-lambda^2)))*(x^2-2*lambda*x*y+y^2)),
      xmin=-0.5, xmax=0.5,ymin=-0.5,ymax=0.5)$Q)
}

cor2 <- optimize(fun2,interval=c(-1,1),maximum=TRUE)$maximum

rsid1 <- as.character(data_exp$rsid)
rsid2 <- as.character(data_out$rsid)

results <-data.frame(cor1 = cor1, cor2=cor2, test=sum(rsid1==rsid2)/length(rsid1))

write.table(results,args[3],quote=FALSE,row.names=FALSE)
