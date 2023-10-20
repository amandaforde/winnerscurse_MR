#!/bin/sh
#SBATCH -J stats_prune
#SBATCH --partition=highmem
#SBATCH -N 1
#SBATCH -n16

Rscript summary_stats_prune.R pruned_cor/pruned_SNPs_bmi.txt summary_stats_bmi_cor.txt summary_stats_bmi_prune.txt
Rscript summary_stats_prune.R pruned_cor/pruned_SNPs_height.txt summary_stats_height_cor.txt summary_stats_height_prune.txt
