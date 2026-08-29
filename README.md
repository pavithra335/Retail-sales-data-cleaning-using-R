# Retail Sales Analysis in R

### Data Cleaning, EDA, Statistical Analysis & Predictive Modeling

An end-to-end retail sales analytics project completed over **four weeks** using **R**. The project transforms a raw 1,000-record retail dataset into an analysis-ready dataset, communicates insights through visualizations, validates business hypotheses using statistical tests, and builds a predictive regression model for profit.

---

## Project Overview

This repository follows a complete data analytics workflow:

| Week       | Focus                     | Outcome                                                                   |
| ---------- | ------------------------- | ------------------------------------------------------------------------- |
| **Week 1** | Data Cleaning             | Missing value imputation, IQR outlier treatment, normalization & encoding |
| **Week 2** | Exploratory Data Analysis | Business visualizations and insight communication                         |
| **Week 3** | Statistical Analysis      | Hypothesis testing and multiple linear regression                         |
| **Week 4** | Final Report              | Consolidated analysis with conclusions and recommendations                |

---

## Dataset

* **1,000 retail order records**
* **Time period:** January 2023 – December 2024
* **Target variable:** Profit
* **Features:** Sales, Quantity, Discount, Region, Category, Segment, Ship Mode and other order-level attributes

---

## Key Techniques Used

### Week 1 — Data Cleaning

* Median & mode imputation
* IQR-based outlier capping
* Min–Max normalization
* Label & one-hot encoding

### Week 2 — Data Visualization

* Monthly Sales & Profit trend
* Regional sales comparison
* Category vs Segment profitability
* Sales distribution histogram
* Correlation heatmap
* Scatter & boxplot analysis

### Week 3 — Statistical Modeling

* Shapiro–Wilk normality test
* Pearson correlation
* Welch t-test
* One-way ANOVA + Tukey HSD
* Chi-square independence test
* Multiple Linear Regression
* 5-Fold Cross Validation
* VIF & residual diagnostics

### Week 4 — Final Analysis

* Business interpretation
* Model evaluation
* Limitations & future improvements

---

## Repository Structure

```text
Retail-Sales-Analysis/
│
├── Week1_Data_Cleaning/
│   ├── retail_sales_raw.csv
│   ├── retail_sales_cleaned.csv
│   ├── report.R
│   └── Retail_Sales_Data_Cleaning_Report.pdf
│
├── Week2_Data_Visualization/
│   ├── retail_sales_week2.csv
│   ├── week2_report.R
│   └── Week2_Data_Visualization_Report.pdf
│
├── Week3_Statistical_Modeling/
│   ├── week3_report.R
│   └── Week3_Statistical_Modeling_Report.pdf
│
├── Week4_Final_Report/
│   └── Week4_Final_Comprehensive_Report.pdf
│
└── README.md
```

---

## Tools & Libraries

* **Language:** R
* **Visualization:** ggplot2, corrplot
* **Data Wrangling:** tidyverse
* **Feature Engineering:** fastDummies
* **Statistical Analysis:** car, caret

---

## Highlights

* Cleaned and prepared **1,000 retail records** without losing observations.
* Identified a strong **Sales–Profit correlation (r ≈ 0.75)**.
* Demonstrated the negative impact of **Discount** on profitability.
* Built a regression model achieving **R² ≈ 0.70** on unseen test data.
* Evaluated the model using cross-validation and diagnostic analysis.

---

## Author

**Pavithra**
B.Tech Computer Science Engineering
Keshav Memorial Engineering College (KMEC)

