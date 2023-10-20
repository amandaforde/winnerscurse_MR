#!/bin/sh

input=$1

plink2 --pfile /data/lfahey/ukb_qc/qcd_files2/${input}_qcd --rm-dup force-first --keep height_cor.txt --pheno height_cor.txt --make-bed --out /data/aforde/height_gwas_cor/${input}_qcd_height

plink2 --bfile /data/aforde/height_gwas_cor/${input}_qcd_height --indep-pairwise 50 5 0.5 --out /data/aforde/pruned_cor/height_prune_${input}

rm /data/aforde/height_gwas_cor/${input}_qcd_height.*
