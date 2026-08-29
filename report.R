# =============================================================
# Week 1 Task: Data Cleaning and Preliminary Analysis with R
# Dataset: Retail Sales Dataset (business/sales domain)
# =============================================================

# ---- 0. Setup ----
# install.packages(c("tidyverse","corrplot","fastDummies"))  # run once if needed
library(tidyverse)
library(corrplot)
library(fastDummies)

sales <- read.csv("retail_sales_raw.csv", stringsAsFactors = FALSE)
sales$Order_Date <- as.Date(sales$Order_Date)
sales$Ship_Date  <- as.Date(sales$Ship_Date)

# ---- 1. Initial structure & summary ----
str(sales)
summary(sales)

# ---- 2. Missing value assessment ----
missing_counts <- sapply(sales, function(x) sum(is.na(x)))
missing_pct    <- round(missing_counts / nrow(sales) * 100, 2)
missing_table  <- data.frame(missing_count = missing_counts,
                              missing_pct   = missing_pct) %>%
  filter(missing_count > 0) %>%
  arrange(desc(missing_count))
print(missing_table)

# Visualize missingness
missing_df <- missing_table %>% rownames_to_column("column")
ggplot(missing_df, aes(x = reorder(column, -missing_count), y = missing_count)) +
  geom_col(fill = "#4C72B0") +
  labs(title = "Missing Values by Column", x = NULL, y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

# ---- 3. Handle missing values ----
# Numeric columns -> median imputation (robust to outliers/skew)
num_cols <- c("Sales", "Quantity", "Discount", "Profit")
for (col in num_cols) {
  med <- median(sales[[col]], na.rm = TRUE)
  sales[[col]][is.na(sales[[col]])] <- med
}

# Categorical columns -> mode imputation
get_mode <- function(x) {
  ux <- na.omit(unique(x))
  ux[which.max(tabulate(match(x, ux)))]
}
cat_cols <- c("Ship_Mode", "Region")
for (col in cat_cols) {
  mode_val <- get_mode(sales[[col]])
  sales[[col]][is.na(sales[[col]])] <- mode_val
}

sum(is.na(sales))   # confirm 0 remaining

# ---- 4. Outlier detection (IQR method) ----
detect_outliers <- function(x) {
  q1 <- quantile(x, 0.25); q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lower <- q1 - 1.5 * iqr
  upper <- q3 + 1.5 * iqr
  list(lower = lower, upper = upper,
       n_outliers = sum(x < lower | x > upper))
}
detect_outliers(sales$Sales)
detect_outliers(sales$Profit)

boxplot(sales$Sales, main = "Sales - Before Capping")

# Winsorize (cap) outliers instead of deleting rows, to preserve sample size
cap_outliers <- function(x) {
  q1 <- quantile(x, 0.25); q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lower <- q1 - 1.5 * iqr; upper <- q3 + 1.5 * iqr
  pmin(pmax(x, lower), upper)
}
sales$Sales_capped  <- cap_outliers(sales$Sales)
sales$Profit_capped <- cap_outliers(sales$Profit)

boxplot(sales$Sales_capped, main = "Sales - After IQR Capping")

# ---- 5. Normalization (min-max scaling) ----
min_max_scale <- function(x) (x - min(x)) / (max(x) - min(x))
sales <- sales %>%
  mutate(Sales_norm    = min_max_scale(Sales_capped),
         Profit_norm   = min_max_scale(Profit_capped),
         Quantity_norm = min_max_scale(Quantity),
         Discount_norm = min_max_scale(Discount))

# ---- 6. Encode categorical variables ----
sales$Category <- factor(sales$Category)
sales$Segment  <- factor(sales$Segment)
sales$Category_enc <- as.numeric(sales$Category)
sales$Segment_enc  <- as.numeric(sales$Segment)

# One-hot encoding for nominal variables used in modeling
sales <- dummy_cols(sales, select_columns = c("Region", "Ship_Mode"),
                    remove_selected_columns = FALSE)

write.csv(sales, "retail_sales_cleaned.csv", row.names = FALSE)

# ---- 7. Exploratory Data Analysis ----
summary(sales[, c("Sales", "Quantity", "Discount", "Profit")])

# Distribution of Sales
ggplot(sales, aes(x = Sales_capped)) +
  geom_histogram(bins = 30, fill = "#55A868", color = "white") +
  labs(title = "Distribution of Sales (capped)", x = "Sales", y = "Frequency") +
  theme_minimal()

# Profit by Category
ggplot(sales, aes(x = Category, y = Profit_capped)) +
  geom_boxplot(fill = "#DD8452") +
  labs(title = "Profit (capped) by Category") +
  theme_minimal()

# Total sales by region
sales %>%
  group_by(Region) %>%
  summarise(Total_Sales = sum(Sales_capped)) %>%
  arrange(desc(Total_Sales)) %>%
  ggplot(aes(x = reorder(Region, -Total_Sales), y = Total_Sales)) +
  geom_col(fill = "#C44E52") +
  labs(title = "Total Sales by Region", x = "Region", y = "Total Sales") +
  theme_minimal()

# Correlation matrix & heatmap
num_vars <- sales[, c("Sales_capped", "Quantity", "Discount", "Profit_capped")]
corr_matrix <- cor(num_vars)
print(round(corr_matrix, 3))
corrplot(corr_matrix, method = "color", addCoef.col = "black",
         title = "Correlation Matrix", mar = c(0,0,1,0))

# Sales vs Profit relationship
ggplot(sales, aes(x = Sales_capped, y = Profit_capped)) +
  geom_point(alpha = 0.4, color = "#8172B2") +
  labs(title = "Sales vs Profit (capped)", x = "Sales", y = "Profit") +
  theme_minimal()
