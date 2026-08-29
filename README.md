# Retail Sales Data Cleaning & Preliminary Analysis in R

A complete data cleaning and preliminary exploratory data analysis (EDA) project performed in **R** using a retail sales dataset. This project transforms raw, imperfect data into an analysis-ready dataset through missing value treatment, outlier handling, feature engineering, and descriptive analysis.

## Project Overview

The objective of this project is to prepare a retail sales dataset for future analytics and machine learning by identifying data quality issues and applying appropriate preprocessing techniques.

## Dataset

* **Records:** 1,000 retail orders
* **Time Period:** January 2023 – December 2024
* **Programming Language:** R

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

## Data Cleaning Workflow

### 1. Data Inspection

* Examined data structure using `str()`
* Generated descriptive statistics with `summary()`
* Assessed missing values and variable types

### 2. Missing Value Treatment

* Median imputation for numerical variables
* Mode imputation for categorical variables
* Resolved all missing values while preserving every record

### 3. Outlier Detection

* Identified outliers using the **Interquartile Range (IQR)** method
* Applied **Winsorization (capping)** instead of removing observations
* Retained the complete dataset of 1,000 records

### 4. Feature Engineering

* Min–Max normalization
* Label encoding
* One-hot encoding for categorical variables

## Exploratory Analysis

The project includes:

* Descriptive statistics
* Missing value assessment
* Sales distribution analysis
* Profit by product category
* Regional sales comparison
* Correlation matrix
* Sales vs Profit relationship

## Key Findings

| Finding                       |            Result |
| ----------------------------- | ----------------: |
| Missing values after cleaning |             **0** |
| Records retained              | **1,000 / 1,000** |
| Sales–Profit correlation      |         **0.747** |
| Discount–Profit correlation   |        **-0.354** |

## Technologies Used

* **R**
* tidyverse
* ggplot2
* corrplot
* fastDummies

## Repository Structure

```text
├── README.md
├── week1_data_cleaning.R
├── retail_sales_raw.csv
├── retail_sales_cleaned.csv
└── Week1_Data_Cleaning_Report.pdf
```

## Learning Outcomes

This project demonstrates practical skills in:

* Data preprocessing
* Missing value imputation
* Outlier treatment using IQR
* Feature normalization & encoding
* Exploratory Data Analysis (EDA)
* Business-oriented data visualization

## Author

**Pavithra**
B.Tech Computer Science Engineering
Keshav Memorial Engineering College (KMEC)


