# Hospital Length of Stay Analysis in R

This project conducts a one-way ANOVA to examine inpatient hospital stays across four U.S. regions using R. The goal is to investigate geographic disparities in average length of stay and provide insights to inform healthcare resource planning.

## Project Overview

We use the **Senic** dataset to analyze regional variation in patient length of stay. The analysis includes model diagnostics, outlier detection, and validation of ANOVA assumptions to ensure statistical reliability.

## Structure of the Report

- **Introduction**  
  This study applies a single-factor ANOVA model across four geographic regions: **Northeast, West, South, and North Central**. The main objective is to assess whether regional differences significantly affect hospital stay duration.

- **Data Visualization**  
  Initial exploration includes boxplots and histograms to illustrate the distribution of stay lengths by region.  
  ![Boxplot of Stay Length by Region](https://github.com/user-attachments/assets/318f4ad1-f84c-4348-a8e7-11f655f3ad27)

- **Diagnostics**  
  We remove outliers using studentized residuals and verify ANOVA assumptions:
  - **Normality**: Assessed using Q-Q plots and the Shapiro-Wilk test  
  - **Homogeneity of Variance**: Checked using residual plots and the Brown-Forsythe test

- **Analysis & Interpretation**  
  Patients in the **Northeast** exhibit significantly longer average hospital stays. This may suggest more complex care needs or regional variations in discharge practices. We recommend that healthcare administrators consider these disparities when allocating resources (e.g., beds, staff, monitoring equipment) to ensure system efficiency and patient care quality.

## Tools Used
- R
- ANOVA
