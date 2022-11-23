## FUNCTIONS REQUIRED FOR MR SIMULATION STUDY:


## 1. The function `sim_mr_ss` simulates MR summary statistics. It requires
## specifications of the number of independent causal SNPs `n_snps`, the
## heritability of the exposure (the proportion of variance explained in the
## exposure by these causal SNPs) `h2`, the fraction of overlapping samples
## `frac_overlap`, the number of samples in the exposure GWAS `n_x` and the
## outcome GWAS `n_y`, the observed correlation between the exposure and the
## outcome, `cor_xy` and finally, the causal effect between the exposure and the
## outcome, `beta_xy`. The function returns a data frame with simulated summary
## statistics in a suitable form so that MR methods can be applied.

## NOTE: The fraction of overlapping samples is defined as the number of samples
## that overlap between the exposure and outcome samples divided by the total
## number of samples in the exposure/outcome GWASs, whichever has the smallest value.


sim_mr_ss <- function(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy){
  n_overlap <- frac_overlap*min(n_x, n_y)
  maf <- runif(n_snps, 0.01, 0.05)
  index <- sample(1:n_snps, ceiling(n_snps), replace=FALSE) # random sampling
  beta_gx <- 0
  beta_gx[index] <- rnorm(length(index),0,1)

  var_x <- sum(2*maf*(1-maf)*beta_gx^2)/h2
  beta_gx <- beta_gx/sqrt(var_x) # scaling to represent an exposure with variance 1
  beta_gy <- beta_gx * beta_xy

  var_gx <- 1/(n_x*2*maf*(1-maf)) # var(X)=1
  var_gy <- 1/(n_y*2*maf*(1-maf)) # var(Y)=1
  cov_gx_gy <- ((n_overlap*cor_xy)/(n_x*n_y))*(1/(2*maf*(1-maf)))

  # create covariance matrix for each SNP
  cov_array <- array(dim=c(2, 2, n_snps))
  cov_array[1,1,] <- var_gx
  cov_array[2,1,] <- cov_gx_gy
  cov_array[1,2,] <- cov_array[2,1,]
  cov_array[2,2,] <- var_gy

  summary_stats <- apply(cov_array, 3, function(x){MASS::mvrnorm(n=1, mu=c(0,0), Sigma=x)})
  summary_stats <- t(summary_stats + rbind(beta_gx, beta_gy))

  data <- tibble(
    SNP = 1:n_snps,
    id.exposure="X",
    id.outcome="Y",
    exposure="X",
    outcome="Y",
    beta.exposure = summary_stats[,1],
    beta.outcome = summary_stats[,2],
    se.exposure = sqrt(var_gx),
    se.outcome = sqrt(var_gy),
    N.exposure = n_x,
    N.outcome = n_y,
    N.overlap = n_overlap,
    fval.exposure = (beta.exposure/se.exposure)^2,
    fval.outcome = (beta.outcome/se.outcome)^2,
    pval.exposure = pf(fval.exposure, df1=1, df2=N.exposure-1, lower.tail=FALSE),
    pval.outcome = pf(fval.outcome, df1=1, df2=N.outcome-1, lower.tail=FALSE),
    eaf.exposure = maf,
    eaf.outcome = maf,
    correlation = cor_xy,
    true.exposure = beta_gx,
    true.outcome = beta_gy,
    mr_keep=TRUE
  )

  return(data)
}



## 2. The function `wc_debias` performs one iteration of our proposed method
## which removes Winner's Curse. Its first argument is a data frame in the form
## that has been outputted from the function above, `sim_mr_ss`. The second
## argument, `pi` specifies the fraction of total samples that we wish to
## include in our simulated discovery set. The default setting is `pi = 0.5`.
## The function also allows you to specify which MR method you wish to use, the
## default is `mr_method = "mr_ivw"`. The final argument is `threshold` which
## specifies the significance threshold that you wish to use for discovery of
## associated SNPs. It defaults to `5e-8`. This function returns a data frame
## with the causal estimate, its standard error, p-value and the number of SNPs
## discovered.

wc_debias <- function(data,pi=0.5,mr_method="mr_ivw", threshold=5e-8){
  data$maf <- data$eaf.exposure
  # create covariance matrix for the conditional distribution of each SNP
  cond_var_gx <- ((1-pi)/(pi))*(1/(data$N.exposure[1]*2*data$maf*(1-data$maf)))
  cond_var_gy <- ((1-pi)/(pi))*(1/(data$N.outcome[1]*2*data$maf*(1-data$maf)))
  cond_cov_gx_gy <- ((1-pi)/(pi))*(((data$N.overlap[1]*data$correlation[1])/(data$N.exposure[1]*data$N.outcome[1]))*(1/(2*data$maf*(1-data$maf))))

  cond_cov_array <- array(dim=c(2, 2, nrow(data)))
  cond_cov_array[1,1,] <- cond_var_gx
  cond_cov_array[2,1,] <- cond_cov_gx_gy
  cond_cov_array[1,2,] <- cond_cov_array[2,1,]
  cond_cov_array[2,2,] <- cond_var_gy

  summary_stats_sub <- apply(cond_cov_array, 3, function(x) {MASS::mvrnorm(n=1, mu=c(0,0), Sigma=x)})

  summary_stats_sub1 <- t(summary_stats_sub + rbind(data$beta.exposure, data$beta.outcome))
  colnames(summary_stats_sub1) <- c("beta.exposure.1", "beta.outcome.1")
  data <- cbind(data, summary_stats_sub1)

  se.exposure.1 <-  sqrt(((1)/(pi))*(1/(data$N.exposure[1]*2*data$maf*(1-data$maf))))
  pval.exposure.1 <- pf((data$beta.exposure.1/se.exposure.1)^2, df1=1, df2=(pi*data$N.exposure)-1, lower.tail=FALSE)

  data <- data %>% dplyr::filter(pval.exposure.1 < threshold)
  if(nrow(data) < 3){return(NULL)}else{
    beta.exposure.2 <- (data$beta.exposure - pi*data$beta.exposure.1)/(1-pi)
    beta.outcome.2 <- (data$beta.outcome - pi*data$beta.outcome.1)/(1-pi)
    se.exposure.2 <- sqrt(((1)/(1-pi))*(1/(data$N.exposure[1]*2*data$maf*(1-data$maf))))
    se.outcome.2 <- sqrt(((1)/(1-pi))*(1/(data$N.outcome[1]*2*data$maf*(1-data$maf))) )

    data <- tibble(
      SNP = data$SNP,
      id.exposure="X",
      id.outcome="Y",
      exposure="X",
      outcome="Y",
      beta.exposure = beta.exposure.2,
      beta.outcome = beta.outcome.2,
      se.exposure = se.exposure.2,
      se.outcome = se.outcome.2,
      fval.exposure = (beta.exposure/se.exposure)^2,
      fval.outcome = (beta.outcome/se.outcome)^2,
      pval.exposure = pf(fval.exposure, df1=1, df2=data$N.exposure-1, lower.tail=FALSE),
      pval.outcome = pf(fval.outcome, df1=1, df2=data$N.outcome-1, lower.tail=FALSE),
      eaf.exposure = data$maf,
      eaf.outcome = data$maf,
      mr_keep=TRUE
    )

    results <- data %>%
      TwoSampleMR::mr(.,method_list=mr_method)
    return(results[,5:9])
  }
}



## 3. The function `prss_2` performs a number of iterations of the above
## function, `wc_debias`. Its arguments are very similar to the above function,
## but it also allows you to specify the number of iterations. This defaults to
## `n.iter = 100`. The function returns a data frame with the average number of
## SNPs discovered in each iteration, the average of the causal estimates and
## appropriated estimated standard error and p-value of this average.

prss_2 <- function(data,n.iter=100,pi=0.5,mr_method="mr_ivw", threshold=5e-8){
  results <- c()
  for (i in 1:n.iter){
    wc_remove <- wc_debias(data,pi,mr_method, threshold)
    if(is.null(wc_remove) == FALSE){results <- rbind(results,wc_remove)}
  }
  if(length(results) == 0){return(NULL)}else{
    est_se <- sqrt((sum(results$se^2)-sum((results$b-mean(results$b))^2))/(nrow(results)))
    summary <- data.frame(method=c(mr_method), nsnp = c(mean(results$nsnp)), b = c(mean(results$b)), se=c(est_se), pval=c(2*pnorm(mean(results$b)/est_se, lower.tail=FALSE)))
    return(summary)
  }
}


## 4. This function `wc_summary` indicates how much Winner's Curse is present in
## the significant SNPs of the original data set. It requires a data set in the
## form outputted by the first function, `sim_mr_ss`. It then outputs four
## different metrics, namely number of significant SNPs, the percentage of these
## that are overestimated, the percentage that are significantly overestimated
## and finally, the MSE of significant SNPs.

wc_summary <- function(summary_data){
  summary_data_sig <- summary_data %>% dplyr::filter(pf((beta.exposure/se.exposure)^2, df1=1, df2=N.exposure-1, lower.tail=FALSE) < 5e-8)
  n_sig <- nrow(summary_data_sig)  # no. of associated SNPs with exposure
  perc_bias <- (sum(abs(summary_data_sig$beta.exposure) > abs(summary_data_sig$true.exposure))/n_sig)*100  # percentage with exposure association overestimated
  perc_x <- (sum(abs(summary_data_sig$beta.exposure) > (abs(summary_data_sig$true.exposure) + 1.96*summary_data_sig$se.exposure))/n_sig)*100  # percentage with exposure association significantly overestimated
  mse <- mean((summary_data_sig$true.exposure-summary_data_sig$beta.exposure)^2)
  wc_test <- data.frame(Metrics=c("No. sig SNPs", "% overestimated", "% significantly overestimated", "MSE"), Quantities=c(round(n_sig,5), round(perc_bias,5), round(perc_x,5), round(mse,5)))
  return(wc_test)
}


