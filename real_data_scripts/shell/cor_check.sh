#!/bin/sh
#SBATCH -J check
#SBATCH --partition=highmem
#SBATCH -N 1
#SBATCH -n 16

Rscript cor_check.R summary_stats_bmi_prune.txt summary_stats_height_prune.txt est_cor.txt
