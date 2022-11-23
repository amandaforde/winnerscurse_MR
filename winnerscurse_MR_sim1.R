## WINNER'S CURSE MR SIMULATION STUDY SCRIPT 1:

## Evaluating and comparing of our proposed method, 'prss' which eliminates
## winner's curse and uses the IVW, MR Egger and weighted median methods against
## the original form of these methods

## NOTE: Our method is not suitable if only a small number of SNPs are significant

library(parallel)
library(TwoSampleMR)
library(dplyr)
library(tidyr)
library(ggplot2)
library(RColorBrewer)
col <- brewer.pal(8,"Dark2")

################################################################################

## Total number of simulations:
tot_sim <- 20
## Fixed causal effect:
Beta_xy <- 0.3
## Fixed correlation between exposure and outcome:
Cor_xy <- 0.6
## Fixed total number of samples in exposure GWAS:
N_x <- 100000
## Fixed total number of samples in outcome GWAS:
N_y <- 100000

## Set of scenarios to be tested
sim_params <- expand.grid(
  sim = c(1:tot_sim),
  n_snps = c(5000, 10000),
  h2 = c(0.3,0.7),
  frac_overlap = c(0, 0.25, 0.5, 0.75, 1)
)

################################################################################

## IVW simulations

set.seed(1996)

run_sim <- function(n_snps, h2, frac_overlap, sim, n_x = N_x, n_y = N_y, cor_xy = Cor_xy, beta_xy = Beta_xy)
{
  stats <- sim_mr_ss(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy)
  stats_sig <- stats[stats$pval.exposure < 5e-8, ]

  params <- data.frame(sim = sim, n_snps = n_snps, h2 = h2, frac_overlap)

  while(nrow(stats_sig) < 3){
    stats <- sim_mr_ss(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy)
    stats_sig <- stats[stats$pval.exposure < 5e-8, ]
  }

  ## Evaluate extent of Winner's Curse
  summary_wc <- wc_summary(stats)

  ## Apply original MR method
  orig_res <- stats %>% dplyr::filter(pval.exposure < 5e-8) %>%
    TwoSampleMR::mr(.,method_list=c("mr_ivw"))

  ## Apply our proposed method with default parameters
  prss_res <- prss_2(stats)

  ## return a list of parameters
  results <- list(params = params, summary_wc = summary_wc, orig_res = orig_res, prss_res = prss_res, data = stats)

  return(results)
}
res_ivw <- mclapply(1:nrow(sim_params), function(i){
  do.call(run_sim, args=as.list(sim_params[i,]))}, mc.cores=1)

################################################################################

## MR Egger simulations

set.seed(1996)

run_sim <- function(n_snps, h2, frac_overlap, sim, n_x = N_x, n_y = N_y, cor_xy = Cor_xy, beta_xy = Beta_xy)
{
  stats <- sim_mr_ss(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy)
  stats_sig <- stats[stats$pval.exposure < 5e-8, ]

  params <- data.frame(sim = sim, n_snps = n_snps, h2 = h2, frac_overlap)

  while(nrow(stats_sig) < 3){
    stats <- sim_mr_ss(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy)
    stats_sig <- stats[stats$pval.exposure < 5e-8, ]
  }

  ## Evaluate extent of Winner's Curse
  summary_wc <- wc_summary(stats)

  ## Apply original MR method
  orig_res <- stats %>% dplyr::filter(pval.exposure < 5e-8) %>%
    TwoSampleMR::mr(.,method_list=c("mr_egger_regression"))

  ## Apply our proposed method with default parameters
  prss_res <- prss_2(stats, mr_method = "mr_egger_regression")

  ## return a list of parameters
  results <- list(params = params, summary_wc = summary_wc, orig_res = orig_res, prss_res = prss_res, data = stats)

  return(results)
}
res_egger <- mclapply(1:nrow(sim_params), function(i){
  do.call(run_sim, args=as.list(sim_params[i,]))}, mc.cores=1)


################################################################################

## Weighed Median simulations

set.seed(1996)

run_sim <- function(n_snps, h2, frac_overlap, sim, n_x = N_x, n_y = N_y, cor_xy = Cor_xy, beta_xy = Beta_xy)
{
  stats <- sim_mr_ss(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy)
  stats_sig <- stats[stats$pval.exposure < 5e-8, ]

  params <- data.frame(sim = sim, n_snps = n_snps, h2 = h2, frac_overlap)

  while(nrow(stats_sig) < 3){
    stats <- sim_mr_ss(n_snps, h2, frac_overlap, n_x, n_y, cor_xy, beta_xy)
    stats_sig <- stats[stats$pval.exposure < 5e-8, ]
  }

  ## Evaluate extent of Winner's Curse
  summary_wc <- wc_summary(stats)

  ## Apply original MR method
  orig_res <- stats %>% dplyr::filter(pval.exposure < 5e-8) %>%
    TwoSampleMR::mr(.,method_list=c("mr_weighted_median"))

  ## Apply our proposed method with default parameters
  prss_res <- prss_2(stats, mr_method = "mr_weighted_median")

  ## return a list of parameters
  results <- list(params = params, summary_wc = summary_wc, orig_res = orig_res, prss_res = prss_res, data = stats)

  return(results)
}
res_med <- mclapply(1:nrow(sim_params), function(i){
  do.call(run_sim, args=as.list(sim_params[i,]))}, mc.cores=1)

################################################################################
################################################################################

## save results of comparison of methods

summary_results_ivw <- data.frame(sim = res_ivw[[1]]$params$sim, n_snps = res_ivw[[1]]$params$n_snps, h2 = res_ivw[[1]]$params$h2, frac_overlap = res_ivw[[1]]$params$frac_overlap, method = res_ivw[[1]]$orig_res$method, nsnp = res_ivw[[1]]$orig_res$nsnp, b = res_ivw[[1]]$orig_res$b, se = res_ivw[[1]]$orig_res$se, pval = res_ivw[[1]]$orig_res$pval, nsnp_prss = res_ivw[[1]]$prss_res$nsnp, b_prss = res_ivw[[1]]$prss_res$b, se_prss = res_ivw[[1]]$prss_res$se, pval_prss = res_ivw[[1]]$prss_res$pval)
for(i in 2:length(res_ivw)){
  if(is.null(res_ivw[[i]]$prss_res) == FALSE){
    vec <- c(res_ivw[[i]]$params$sim, res_ivw[[i]]$params$n_snps, res_ivw[[i]]$params$h2, res_ivw[[i]]$params$frac_overlap, res_ivw[[i]]$orig_res$method, res_ivw[[i]]$orig_res$nsnp, res_ivw[[i]]$orig_res$b, res_ivw[[i]]$orig_res$se, res_ivw[[i]]$orig_res$pval, res_ivw[[i]]$prss_res$nsnp, res_ivw[[i]]$prss_res$b, res_ivw[[i]]$prss_res$se, res_ivw[[i]]$prss_res$pval)
    summary_results_ivw <- rbind(summary_results_ivw, vec)
  }
}
write.csv(summary_results_ivw, "compare_ivw_20sim.csv")
summary_results_ivw_long <- data.frame(sim = c(rep(summary_results_ivw$sim,2)), n_snps = c(rep(summary_results_ivw$n_snps,2)), h2 = c(rep(summary_results_ivw$h2,2)), frac_overlap = c(rep(summary_results_ivw$frac_overlap,2)), Method = c(rep(summary_results_ivw$method,2)), PRSS = c(rep("No",nrow(summary_results_ivw)), rep("Yes",nrow(summary_results_ivw))), nsnp = c(summary_results_ivw$nsnp, summary_results_ivw$nsnp_prss), b = c(summary_results_ivw$b, summary_results_ivw$b_prss), se = c(summary_results_ivw$se, summary_results_ivw$se_prss), pval = c(summary_results_ivw$pval, summary_results_ivw$pval_prss))
write.csv(summary_results_ivw_long, "compare_ivw_20sim_long.csv")


summary_results_egger <- data.frame(sim = res_egger[[1]]$params$sim, n_snps = res_egger[[1]]$params$n_snps, h2 = res_egger[[1]]$params$h2, frac_overlap = res_egger[[1]]$params$frac_overlap, method = res_egger[[1]]$orig_res$method, nsnp = res_egger[[1]]$orig_res$nsnp, b = res_egger[[1]]$orig_res$b, se = res_egger[[1]]$orig_res$se, pval = res_egger[[1]]$orig_res$pval, nsnp_prss = res_egger[[1]]$prss_res$nsnp, b_prss = res_egger[[1]]$prss_res$b, se_prss = res_egger[[1]]$prss_res$se, pval_prss = res_egger[[1]]$prss_res$pval)
for(i in 2:length(res_egger)){
  if(is.null(res_egger[[i]]$prss_res) == FALSE){
    vec <- c(res_egger[[i]]$params$sim, res_egger[[i]]$params$n_snps, res_egger[[i]]$params$h2, res_egger[[i]]$params$frac_overlap, res_egger[[i]]$orig_res$method, res_egger[[i]]$orig_res$nsnp, res_egger[[i]]$orig_res$b, res_egger[[i]]$orig_res$se, res_egger[[i]]$orig_res$pval, res_egger[[i]]$prss_res$nsnp, res_egger[[i]]$prss_res$b, res_egger[[i]]$prss_res$se, res_egger[[i]]$prss_res$pval)
    summary_results_egger <- rbind(summary_results_egger, vec)
  }
}
write.csv(summary_results_egger, "compare_egger_20sim.csv")
summary_results_egger_long <- data.frame(sim = c(rep(summary_results_egger$sim,2)), n_snps = c(rep(summary_results_egger$n_snps,2)), h2 = c(rep(summary_results_egger$h2,2)), frac_overlap = c(rep(summary_results_egger$frac_overlap,2)), Method = c(rep(summary_results_egger$method,2)), PRSS = c(rep("No",nrow(summary_results_egger)), rep("Yes",nrow(summary_results_egger))), nsnp = c(summary_results_egger$nsnp, summary_results_egger$nsnp_prss), b = c(summary_results_egger$b, summary_results_egger$b_prss), se = c(summary_results_egger$se, summary_results_egger$se_prss), pval = c(summary_results_egger$pval, summary_results_egger$pval_prss))
write.csv(summary_results_egger_long, "compare_egger_20sim_long.csv")


summary_results_med <- data.frame(sim = res_med[[1]]$params$sim, n_snps = res_med[[1]]$params$n_snps, h2 = res_med[[1]]$params$h2, frac_overlap = res_med[[1]]$params$frac_overlap, method = res_med[[1]]$orig_res$method, nsnp = res_med[[1]]$orig_res$nsnp, b = res_med[[1]]$orig_res$b, se = res_med[[1]]$orig_res$se, pval = res_med[[1]]$orig_res$pval, nsnp_prss = res_med[[1]]$prss_res$nsnp, b_prss = res_med[[1]]$prss_res$b, se_prss = res_med[[1]]$prss_res$se, pval_prss = res_med[[1]]$prss_res$pval)
for(i in 2:length(res_med)){
  if(is.null(res_med[[i]]$prss_res) == FALSE){
    vec <- c(res_med[[i]]$params$sim, res_med[[i]]$params$n_snps, res_med[[i]]$params$h2, res_med[[i]]$params$frac_overlap, res_med[[i]]$orig_res$method, res_med[[i]]$orig_res$nsnp, res_med[[i]]$orig_res$b, res_med[[i]]$orig_res$se, res_med[[i]]$orig_res$pval, res_med[[i]]$prss_res$nsnp, res_med[[i]]$prss_res$b, res_med[[i]]$prss_res$se, res_med[[i]]$prss_res$pval)
    summary_results_med <- rbind(summary_results_med, vec)
  }
}
write.csv(summary_results_med, "compare_med_20sim.csv")
summary_results_med_long <- data.frame(sim = c(rep(summary_results_med$sim,2)), n_snps = c(rep(summary_results_med$n_snps,2)), h2 = c(rep(summary_results_med$h2,2)), frac_overlap = c(rep(summary_results_med$frac_overlap,2)), Method = c(rep(summary_results_med$method,2)), PRSS = c(rep("No",nrow(summary_results_med)), rep("Yes",nrow(summary_results_med))), nsnp = c(summary_results_med$nsnp, summary_results_med$nsnp_prss), b = c(summary_results_med$b, summary_results_med$b_prss), se = c(summary_results_med$se, summary_results_med$se_prss), pval = c(summary_results_med$pval, summary_results_med$pval_prss))
write.csv(summary_results_med_long, "compare_med_20sim_long.csv")

################################################################################
################################################################################

## save results of measuring degree of Winner's Curse

summary_results_wc_ivw <- data.frame(sim = res_ivw[[1]]$params$sim, n_snps = res_ivw[[1]]$params$n_snps, h2 = res_ivw[[1]]$params$h2, frac_overlap = res_ivw[[1]]$params$frac_overlap, method = res_ivw[[1]]$orig_res$method, n_sig_snps = res_ivw[[1]]$summary_wc$Quantities[1], per_over = res_ivw[[1]]$summary_wc$Quantities[2], per_sig_over = res_ivw[[1]]$summary_wc$Quantities[3], MSE = res_ivw[[1]]$summary_wc$Quantities[4])
for(i in 2:nrow(sim_params)){
  if(is.null(res_ivw[[i]]$prss_res) == FALSE){
    vec <- c(res_ivw[[i]]$params$sim, res_ivw[[i]]$params$n_snps, res_ivw[[i]]$params$h2, res_ivw[[i]]$params$frac_overlap, res_ivw[[i]]$orig_res$method, res_ivw[[i]]$summary_wc$Quantities[1], res_ivw[[i]]$summary_wc$Quantities[2], res_ivw[[i]]$summary_wc$Quantities[3], res_ivw[[i]]$summary_wc$Quantities[4])
    summary_results_wc_ivw <- rbind(summary_results_wc_ivw, vec)
  }
}
scenarios <- c(rep("n_snps = 5000, h2 = 0.3",20), rep("n_snps = 10000, h2 = 0.3", 20), rep("n_snps = 5000, h2 = 0.7", 20), rep("n_snps = 10000, h2 = 0.7", 20))
summary_results_wc_ivw$scenario <- c(rep(scenarios, 5))

summary_results_wc_egger <- data.frame(sim = res_egger[[1]]$params$sim, n_snps = res_egger[[1]]$params$n_snps, h2 = res_egger[[1]]$params$h2, frac_overlap = res_egger[[1]]$params$frac_overlap, method = res_egger[[1]]$orig_res$method, n_sig_snps = res_egger[[1]]$summary_wc$Quantities[1], per_over = res_egger[[1]]$summary_wc$Quantities[2], per_sig_over = res_egger[[1]]$summary_wc$Quantities[3], MSE = res_egger[[1]]$summary_wc$Quantities[4])
for(i in 2:nrow(sim_params)){
  if(is.null(res_egger[[i]]$prss_res) == FALSE){
    vec <- c(res_egger[[i]]$params$sim, res_egger[[i]]$params$n_snps, res_egger[[i]]$params$h2, res_egger[[i]]$params$frac_overlap, res_egger[[i]]$orig_res$method, res_egger[[i]]$summary_wc$Quantities[1], res_egger[[i]]$summary_wc$Quantities[2], res_egger[[i]]$summary_wc$Quantities[3], res_egger[[i]]$summary_wc$Quantities[4])
    summary_results_wc_egger <- rbind(summary_results_wc_egger, vec)
  }
}
summary_results_wc_egger$scenario <- c(rep(scenarios, 5))

summary_results_wc_med <- data.frame(sim = res_med[[1]]$params$sim, n_snps = res_med[[1]]$params$n_snps, h2 = res_med[[1]]$params$h2, frac_overlap = res_med[[1]]$params$frac_overlap, method = res_med[[1]]$orig_res$method, n_sig_snps = res_med[[1]]$summary_wc$Quantities[1], per_over = res_med[[1]]$summary_wc$Quantities[2], per_sig_over = res_med[[1]]$summary_wc$Quantities[3], MSE = res_med[[1]]$summary_wc$Quantities[4])
for(i in 2:nrow(sim_params)){
  if(is.null(res_med[[i]]$prss_res) == FALSE){
    vec <- c(res_med[[i]]$params$sim, res_med[[i]]$params$n_snps, res_med[[i]]$params$h2, res_med[[i]]$params$frac_overlap, res_med[[i]]$orig_res$method, res_med[[i]]$summary_wc$Quantities[1], res_med[[i]]$summary_wc$Quantities[2], res_med[[i]]$summary_wc$Quantities[3], res_med[[i]]$summary_wc$Quantities[4])
    summary_results_wc_med <- rbind(summary_results_wc_med, vec)
  }
}
summary_results_wc_med$scenario <- c(rep(scenarios, 5))

summary_results_wc_all <- rbind(summary_results_wc_ivw, summary_results_wc_egger, summary_results_wc_med)
write.csv(summary_results_wc_all, "degreee_wc_20sim.csv")

################################################################################
################################################################################
