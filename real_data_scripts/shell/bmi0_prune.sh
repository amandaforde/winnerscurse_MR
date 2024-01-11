#!/bin/sh

input=$1

plink2 --pfile /data/lfahey/ukb_qc/qcd_files2/${input}_qcd --rm-dup force-first --keep bmi0.txt --pheno bmi0.txt --make-bed --out ${input}_qcd_bmi0

plink2 --bfile ${input}_qcd_bmi0 --indep-pairwise 100 10 0.001 --out pruned/${input}_bmi0

rm ${input}_qcd_bmi0*
