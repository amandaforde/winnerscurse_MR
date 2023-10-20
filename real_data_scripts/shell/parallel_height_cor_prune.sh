#!/bin/sh
#SBATCH -J height_cor
#SBATCH --partition=highmem

for i in {1..22}; do

sbatch -p highmem -N 1 -n 16  height_cor_prune.sh $i;

done
