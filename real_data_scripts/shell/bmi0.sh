#!/bin/sh

input=$1

plink2 --pfile /data/lfahey/ukb_qc/qcd_files2/${input}_qcd --rm-dup force-first --keep /data/aforde/MRSimSS_realdata/bmi0.txt --pheno /data/aforde/MRSimSS_realdata/bmi0.txt --make-bed --out ${input}_qcd_bmi0

plink2 --bfile ${input}_qcd_bmi0 --extract /data/aforde/MRSimSS_realdata/pruned/${input}_bmi0.prune.in --glm omit-ref hide-covar --covar covariates.txt --covar-variance-standardize PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 AGE --out bmi0_res_${input}

rm ${input}_qcd_bmi0*
