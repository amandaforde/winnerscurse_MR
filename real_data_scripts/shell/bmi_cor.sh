#!/bin/sh

input=$1

plink2 --pfile /data/lfahey/ukb_qc/qcd_files2/${input}_qcd --rm-dup force-first --keep bmi_cor.txt --pheno bmi_cor.txt --make-bed --out /data/aforde/bmi_gwas_cor/${input}_qcd_bmi

plink2 --bfile /data/aforde/bmi_gwas_cor/${input}_qcd_bmi --glm omit-ref hide-covar --covar covariates.txt --covar-variance-standardize PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 AGE --out /data/aforde/results_cor/bmi_res_${input}
