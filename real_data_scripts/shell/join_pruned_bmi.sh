#!/bin/sh
#SBATCH -J prune_join
#SBATCH --partition=highmem
#SBATCH -N 1
#SBATCH -n 16

cd /data/aforde/pruned_cor

Rscript /data/aforde/prune_join.R bmi_prune_1.prune.in bmi_prune_2.prune.in bmi_prune_3.prune.in bmi_prune_4.prune.in bmi_prune_5.prune.in bmi_prune_6.prune.in bmi_prune_7.prune.in bmi_prune_8.prune.in bmi_prune_9.prune.in bmi_prune_10.prune.in bmi_prune_11.prune.in bmi_prune_12.prune.in bmi_prune_13.prune.in bmi_prune_14.prune.in bmi_prune_15.prune.in bmi_prune_16.prune.in bmi_prune_17.prune.in bmi_prune_18.prune.in bmi_prune_19.prune.in bmi_prune_20.prune.in bmi_prune_21.prune.in bmi_prune_22.prune.in pruned_SNPs_bmi.txt
