#!/bin/sh

input=$1

plink2 --pfile /data/lfahey/ukb_qc/qcd_files2/${input}_qcd --rm-dup force-first --keep bmi_cor.txt --pheno bmi_cor.txt --make-bed --out /data/aforde/bmi_gwas_cor/${input}_qcd_bmi

plink2 --bfile /data/aforde/bmi_gwas_cor/${input}_qcd_bmi --indep-pairwise 50 5 0.5 --out /data/aforde/pruned_cor/bmi_prune_${input}

rm /data/aforde/bmi_gwas_cor/${input}_qcd_bmi.*
