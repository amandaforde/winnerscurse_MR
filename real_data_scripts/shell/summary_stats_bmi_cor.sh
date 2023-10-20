#! /bin/sh -l
#SBATCH -J stats
#SBATCH --partition=highmem
#SBATCH -N 1
#SBATCH -n 1

Rscript summary_stats_bmi_cor.R results_cor/bmi_res_1.PHENO1.glm.linear results_cor/bmi_res_2.PHENO1.glm.linear results_cor/bmi_res_3.PHENO1.glm.linear results_cor/bmi_res_4.PHENO1.glm.linear results_cor/bmi_res_5.PHENO1.glm.linear results_cor/bmi_res_6.PHENO1.glm.linear results_cor/bmi_res_7.PHENO1.glm.linear results_cor/bmi_res_8.PHENO1.glm.linear results_cor/bmi_res_9.PHENO1.glm.linear results_cor/bmi_res_10.PHENO1.glm.linear results_cor/bmi_res_11.PHENO1.glm.linear results_cor/bmi_res_12.PHENO1.glm.linear results_cor/bmi_res_13.PHENO1.glm.linear results_cor/bmi_res_14.PHENO1.glm.linear results_cor/bmi_res_15.PHENO1.glm.linear results_cor/bmi_res_16.PHENO1.glm.linear results_cor/bmi_res_17.PHENO1.glm.linear results_cor/bmi_res_18.PHENO1.glm.linear results_cor/bmi_res_19.PHENO1.glm.linear results_cor/bmi_res_20.PHENO1.glm.linear results_cor/bmi_res_21.PHENO1.glm.linear results_cor/bmi_res_22.PHENO1.glm.linear summary_stats_bmi_cor.txt
