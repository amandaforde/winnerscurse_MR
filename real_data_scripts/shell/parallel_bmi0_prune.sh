#!/bin/sh
#SBATCH -J prune
#SBATCH --partition=highmem


for i in {1..22}; do

sbatch -p highmem -N 1 -n 16  bmi0_prune.sh $i;

done
