# =============================================================
# Week 2 Task: Data Visualization and Insight Communication
# Dataset: Retail Sales Dataset (continued from Week 1)
# =============================================================

library(tidyverse)
library(scales)

sales <- read.csv("retail_sales_week2.csv", stringsAsFactors = FALSE)
sales$Order_Date <- as.Date(sales$Order_Date)

# ---- 1. Monthly Sales & Profit Trend (line chart) ----
monthly <- sales %>%
  mutate(Month = floor_date(Order_Date, "month")) %>%
  group_by(Month) %>%
  summarise(Total_Sales = sum(Sales_capped), Total_Profit = sum(Profit_capped))

scale_factor <- max(monthly$Total_Sales) / max(monthly$Total_Profit)

ggplot(monthly, aes(x = Month)) +
  geom_line(aes(y = Total_Sales, color = "Total Sales"), linewidth = 1) +
  geom_point(aes(y = Total_Sales, color = "Total Sales")) +
  geom_line(aes(y = Total_Profit * scale_factor, color = "Total Profit"), linewidth = 1) +
  geom_point(aes(y = Total_Profit * scale_factor, color = "Total Profit")) +
  scale_y_continuous(
    name = "Total Sales ($)",
    labels = dollar_format(),
    sec.axis = sec_axis(~ . / scale_factor, name = "Total Profit ($)", labels = dollar_format())
  ) +
  scale_color_manual(values = c("Total Sales" = "#4C72B0", "Total Profit" = "#C44E52")) +
  labs(title = "Monthly Sales and Profit Trend (Jan 2023 - Dec 2024)",
       x = NULL, color = NULL) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# ---- 2. Total Sales by Region (bar chart) ----
sales %>%
  group_by(Region) %>%
  summarise(Total_Sales = sum(Sales_capped)) %>%
  arrange(desc(Total_Sales)) %>%
  ggplot(aes(x = reorder(Region, -Total_Sales), y = Total_Sales)) +
  geom_col(fill = "#55A868") +
  geom_text(aes(label = dollar(round(Total_Sales))), vjust = -0.5, size = 3.5) +
  labs(title = "Total Sales by Region", x = "Region", y = "Total Sales ($)") +
  theme_minimal()

# ---- 3. Average Profit by Category and Segment (grouped bar chart) ----
sales %>%
  group_by(Category, Segment) %>%
  summarise(Avg_Profit = mean(Profit_capped), .groups = "drop") %>%
  ggplot(aes(x = Category, y = Avg_Profit, fill = Segment)) +
  geom_col(position = "dodge") +
  labs(title = "Average Profit by Category and Customer Segment",
       x = "Category", y = "Average Profit ($)") +
  theme_minimal()

# ---- 4. Distribution of Order Sales Value (histogram) ----
ggplot(sales, aes(x = Sales_capped)) +
  geom_histogram(bins = 30, fill = "#8172B2", color = "white") +
  geom_vline(xintercept = median(sales$Sales_capped), linetype = "dashed") +
  annotate("text", x = median(sales$Sales_capped) + 120, y = 120,
           label = paste0("Median = $", round(median(sales$Sales_capped)))) +
  labs(title = "Distribution of Order Sales Value", x = "Sales ($)", y = "Number of Orders") +
  theme_minimal()

# ---- 5. Sales vs Profit scatter with anomalies highlighted ----
detect_outliers <- function(x) {
  q1 <- quantile(x, 0.25); q3 <- quantile(x, 0.75); iqr <- q3 - q1
  x < (q1 - 1.5 * iqr) | x > (q3 + 1.5 * iqr)
}
sales$is_outlier <- detect_outliers(sales$Sales) | detect_outliers(sales$Profit)

ggplot(sales, aes(x = Sales, y = Profit, color = is_outlier, shape = is_outlier, size = is_outlier)) +
  geom_point(alpha = 0.6) +
  scale_color_manual(values = c("FALSE" = "#4C72B0", "TRUE" = "#C44E52"),
                      labels = c("Typical orders", "Anomalous orders (IQR outliers)")) +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 18),
                      labels = c("Typical orders", "Anomalous orders (IQR outliers)")) +
  scale_size_manual(values = c("FALSE" = 1.5, "TRUE" = 3), guide = "none") +
  labs(title = "Sales vs Profit, with Anomalies Highlighted",
       x = "Sales ($)", y = "Profit ($)", color = NULL, shape = NULL) +
  theme_minimal()

# ---- 6. Profit by Shipping Mode (boxplot) ----
ship_order <- sales %>% group_by(Ship_Mode) %>%
  summarise(med = median(Profit_capped)) %>% arrange(desc(med)) %>% pull(Ship_Mode)
sales$Ship_Mode <- factor(sales$Ship_Mode, levels = ship_order)

ggplot(sales, aes(x = Ship_Mode, y = Profit_capped)) +
  geom_boxplot(fill = "white", color = "black") +
  labs(title = "Profit Distribution by Shipping Mode", x = NULL, y = "Profit ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 15, hjust = 1))

# ---- 7. Correlation heatmap ----
library(corrplot)
num_vars <- sales[, c("Sales_capped", "Quantity", "Discount", "Profit_capped")]
corr_matrix <- cor(num_vars)
print(round(corr_matrix, 3))
corrplot(corr_matrix, method = "color", addCoef.col = "black",
         title = "Correlation Matrix", mar = c(0,0,1,0))
