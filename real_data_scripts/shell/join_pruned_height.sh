#!/bin/sh
#SBATCH -J prune_join
#SBATCH --partition=highmem
#SBATCH -N 1
#SBATCH -n 16

cd /data/aforde/pruned_cor

Rscript /data/aforde/prune_join.R height_prune_1.prune.in height_prune_2.prune.in height_prune_3.prune.in height_prune_4.prune.in height_prune_5.prune.in height_prune_6.prune.in height_prune_7.prune.in height_prune_8.prune.in height_prune_9.prune.in height_prune_10.prune.in height_prune_11.prune.in height_prune_12.prune.in height_prune_13.prune.in height_prune_14.prune.in height_prune_15.prune.in height_prune_16.prune.in height_prune_17.prune.in height_prune_18.prune.in height_prune_19.prune.in height_prune_20.prune.in height_prune_21.prune.in height_prune_22.prune.in pruned_SNPs_height.txt
