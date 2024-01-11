#! /bin/sh -l
#SBATCH -J stats0
#SBATCH --partition=highmem
#SBATCH -N 1
#SBATCH -n 1

Rscript summary_data_T2D.R T2D0_res_1.PHENO1.glm.logistic.hybrid T2D0_res_2.PHENO1.glm.logistic.hybrid T2D0_res_3.PHENO1.glm.logistic.hybrid T2D0_res_4.PHENO1.glm.logistic.hybrid T2D0_res_5.PHENO1.glm.logistic.hybrid T2D0_res_6.PHENO1.glm.logistic.hybrid T2D0_res_7.PHENO1.glm.logistic.hybrid T2D0_res_8.PHENO1.glm.logistic.hybrid T2D0_res_9.PHENO1.glm.logistic.hybrid T2D0_res_10.PHENO1.glm.logistic.hybrid T2D0_res_11.PHENO1.glm.logistic.hybrid T2D0_res_12.PHENO1.glm.logistic.hybrid T2D0_res_13.PHENO1.glm.logistic.hybrid T2D0_res_14.PHENO1.glm.logistic.hybrid T2D0_res_15.PHENO1.glm.logistic.hybrid T2D0_res_16.PHENO1.glm.logistic.hybrid T2D0_res_17.PHENO1.glm.logistic.hybrid T2D0_res_18.PHENO1.glm.logistic.hybrid T2D0_res_19.PHENO1.glm.logistic.hybrid T2D0_res_20.PHENO1.glm.logistic.hybrid T2D0_res_21.PHENO1.glm.logistic.hybrid T2D0_res_22.PHENO1.glm.logistic.hybrid summary_data_T2D0.txt
