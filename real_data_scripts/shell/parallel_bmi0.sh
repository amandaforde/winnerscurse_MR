#!/bin/sh
#SBATCH -J bmi0
#SBATCH --partition=highmem


for i in {3..22}; do

sbatch -p highmem -N 1 -n 16  bmi0.sh $i;

done
