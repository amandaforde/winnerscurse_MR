#!/bin/sh

input=$1

plink2 --pfile /data/lfahey/ukb_qc/qcd_files2/${input}_qcd --rm-dup force-first --keep /data/aforde/MRSimSS_realdata/T2D0.txt --pheno /data/aforde/MRSimSS_realdata/T2D0.txt --make-bed --out ${input}_qcd_T2D0

plink2 --bfile ${input}_qcd_T2D0 --extract /data/aforde/MRSimSS_realdata/pruned/${input}_bmi0.prune.in --glm firth-fallback omit-ref hide-covar --covar covariates.txt --covar-variance-standardize PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 AGE --out T2D0_res_${input}

rm ${input}_qcd_T2D0*
