# Retail Sales Data Cleaning & Exploratory Data Analysis in R

A complete data cleaning and preliminary exploratory data analysis (EDA) project performed in **R** on a retail sales dataset. This project demonstrates handling missing values, treating outliers, feature engineering, and generating business insights through statistical analysis and visualizations.

## Project Overview

The project uses a retail sales dataset containing **1,000 order-level records** and **14 variables**. The objective was to transform raw, imperfect data into a clean, analysis-ready dataset suitable for future statistical modeling or machine learning.

## Dataset Information

* **Records:** 1,000
* **Features:** 14
* **Domain:** Retail Sales
* **Language:** R

### Numerical Variables

* Sales
* Quantity
* Discount
* Profit

### Categorical Variables

* Region
* Segment
* Category
* Ship Mode
* State
* Sub-Category

## Data Cleaning Tasks Performed

### 1. Data Inspection

* Examined data structure using `str()`
* Generated summary statistics with `summary()`
* Identified missing values and variable types

### 2. Missing Value Treatment

* Median imputation for numerical variables
* Mode imputation for categorical variables
* Removed **100% of missing values** while preserving all records

### 3. Outlier Detection & Treatment

* Detected outliers using the **Interquartile Range (IQR)** method
* Applied **Winsorization (capping)** instead of deleting observations
* Preserved the complete dataset of 1,000 rows

### 4. Feature Engineering

* Min–Max normalization of numerical features
* Label encoding for Category and Segment
* One-hot encoding for Region and Ship Mode

## Exploratory Data Analysis

The analysis includes:

* Distribution of Sales
* Profit by Product Category
* Total Sales by Region
* Correlation Matrix
* Sales vs Profit Scatter Plot

## Key Insights

| Finding                       |            Result |
| ----------------------------- | ----------------: |
| Sales ↔ Profit correlation    |         **0.747** |
| Discount ↔ Profit correlation |        **-0.354** |
| Missing values after cleaning |             **0** |
| Records retained              | **1,000 / 1,000** |

**Business observations:**

* Higher sales generally lead to higher profit.
* Larger discounts tend to reduce profit margins.
* Quantity has very little linear relationship with sales or profit.
* Product categories differ noticeably in profitability.

## Technologies Used

* R
* tidyverse
* ggplot2
* corrplot
* fastDummies

## Repository Structure

```text
├── report.R                         # Complete R script
├── retail_sales_raw.csv             # Original dataset
├── retail_sales_cleaned.csv         # Cleaned dataset
├── Week1_Data_Cleaning_R_Report.docx # Project report
└── README.md
```

## Learning Outcomes

Through this task, I practiced:

* Data preprocessing in R
* Missing value imputation
* Outlier handling using IQR
* Feature normalization & encoding
* Exploratory Data Analysis (EDA)
* Data visualization for business insights
