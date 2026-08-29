Retail Sales Analysis — Data Cleaning, EDA & Predictive Modeling in R

End-to-end analysis of a 1,000-record retail sales dataset (Jan 2023 – Dec 2024), completed over four weekly milestones: data cleaning, exploratory analysis, statistical hypothesis testing, and predictive modeling, culminating in a comprehensive final report.

Project Overview

This project takes a raw retail orders dataset through a full analytics pipeline in R:

Week 1 — Data Cleaning & Preliminary Analysis: missing value treatment, IQR-based outlier capping, structural checks
Week 2 — Data Visualization & Insight Communication: trend, regional, categorical, and correlation analysis with visualizations
Week 3 — Statistical Analysis & Predictive Modeling: hypothesis testing (normality, correlation, t-test, ANOVA, chi-square) and a multiple linear regression model with cross-validation
Week 4 — Comprehensive Final Report: integration of all prior work into a single narrative report with conclusions and recommendations
Repository Structure
├── Week1_Data_Cleaning/
│   ├── retail_sales_raw.csv
│   ├── retail_sales_cleaned.csv
│   ├── report.R
│   └── Retail_sales_data_Cleaning_Report.docx
│
├── Week2_Data_Visualization/
│   ├── retail_sales_week2.csv
│   ├── week2_report.R
│   └── Week2_Data_Visualization_R_Report.docx
│
├── Week3_Statistical_Modeling/
│   ├── week3_report.R
│   └── Week3_Statistical_Modeling_R_Report.docx
│
├── Week4_Final_Report/
│   └── Week4_Final_Comprehensive_Report.docx
│
└── README.md
Dataset

Retail order-level sales data with fields including Order_Date, Ship_Date, Ship_Mode, Region, Category, Segment, Sales, Quantity, Discount, and Profit. The raw dataset is cleaned in Week 1 and carried forward through subsequent weeks as Sales_capped / Profit_capped (outlier-capped versions used for modeling).

Tools & Packages
Language: R
Data wrangling & visualization: tidyverse, ggplot2, corrplot
Data prep: fastDummies
Statistical modeling: car (VIF), caret (cross-validation)
Weekly Highlights
Week	Focus	Key Outputs
1	Data cleaning	Median/mode imputation for missing values; IQR-based outlier capping on Sales & Profit
2	Data visualization	Monthly sales/profit trend line chart, sales-by-region bar chart, category/segment profit comparison, sales distribution histogram, anomaly-highlighted scatter plot, shipping-mode boxplot, correlation heatmap
3	Statistical modeling	Shapiro-Wilk, Pearson correlation, Welch t-test, one-way ANOVA + Tukey HSD, chi-square test; multiple linear regression (R² ≈ 0.70, 5-fold CV) with residual diagnostics
4	Final report	End-to-end synthesis, limitations (heteroscedasticity, capping artifacts), and recommendations for future modeling (log/Box-Cox transform, regularization, non-linear models)
How to Run
Clone the repo and open the relevant week's folder in Posit Cloud or RStudio.
Install required packages (run once):
r
   install.packages(c("tidyverse", "corrplot", "fastDummies", "car", "caret"))
Run the .R script in that folder — each script reads its corresponding CSV from the same directory.
Diagnostic and EDA plots are saved directly to PNG files in the working directory rather than relying on the RStudio Plots pane.
Reports

Each week's .docx report documents methodology, R code, outputs, and interpretation in full, and is intended to be read alongside its corresponding script.

Author

Pavithra — B.Tech Computer Science Engineering, Keshav Memorial Engineering College (KMEC)
