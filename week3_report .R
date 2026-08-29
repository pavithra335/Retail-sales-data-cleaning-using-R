# =============================================================
# Week 3 Task: Statistical Analysis and Predictive Modeling
# Dataset: Retail Sales Dataset (continued from Weeks 1-2)
# =============================================================

library(tidyverse)
library(car)      # vif()
library(caret)     # cross-validation

sales <- read.csv("retail_sales_week2.csv", stringsAsFactors = FALSE)
sales$Order_Date <- as.Date(sales$Order_Date)

# =============================================================
# 1. EXPLORATORY STATISTICAL ANALYSIS
# =============================================================

# ---- 1.1 Normality tests (Shapiro-Wilk) ----
shapiro.test(sample(sales$Sales_capped, 5000, nrow(sales))))
shapiro.test(sample(sales$Profit_capped, 5000, nrow(sales))))

# ---- 1.2 Correlation test: Sales vs Profit ----
cor.test(sales$Sales_capped, sales$Profit_capped, method = "pearson")

# ---- 1.3 Two-sample t-test: Profit, Consumer vs Corporate segment ----
consumer <- sales$Profit_capped[sales$Segment == "Consumer"]
corporate <- sales$Profit_capped[sales$Segment == "Corporate"]
leveneTest(Profit_capped ~ Segment, data = subset(sales, Segment %in% c("Consumer","Corporate")))
t.test(consumer, corporate)   # Welch two-sample t-test (default)

# ---- 1.4 One-way ANOVA: Profit by Category ----
anova_model <- aov(Profit_capped ~ Category, data = sales)
summary(anova_model)
leveneTest(Profit_capped ~ Category, data = sales)   # check equal-variance assumption
TukeyHSD(anova_model)                                # post-hoc pairwise comparisons

# ---- 1.5 Chi-square test: Region vs Category (independence) ----
tab <- table(sales$Region, sales$Category)
chisq.test(tab)

# =============================================================
# 2. MODEL BUILDING: MULTIPLE LINEAR REGRESSION
# =============================================================

sales$Category <- factor(sales$Category)                          # baseline: Furniture
sales$Segment  <- factor(sales$Segment)                            # baseline: Consumer
sales$Region   <- factor(sales$Region, levels = c("Central","East","South","West"))  # baseline: Central

set.seed(42)
train_idx <- createDataPartition(sales$Profit_capped, p = 0.8, list = FALSE)
train <- sales[train_idx, ]
test  <- sales[-train_idx, ]

model <- lm(Profit_capped ~ Sales_capped + Quantity + Discount + Category + Segment + Region,
            data = train)
summary(model)

# ---- Multicollinearity check ----
vif(model)

# ---- 5-fold cross-validation ----
train_control <- trainControl(method = "cv", number = 5)
cv_model <- train(Profit_capped ~ Sales_capped + Quantity + Discount + Category + Segment + Region,
                   data = train, method = "lm", trControl = train_control)
print(cv_model)
cv_model$resample

# ---- Holdout test set evaluation ----
predictions <- predict(model, newdata = test)
postResample(pred = predictions, obs = test$Profit_capped)

# =============================================================
# 3. DIAGNOSTIC ANALYSIS
# =============================================================

png("diagnostic_plots.png", width = 800, height = 800)
par(mfrow = c(2,2))
plot(model)     # Residuals vs Fitted, Q-Q, Scale-Location, Residuals vs Leverage
par(mfrow = c(1,1))
dev.off()

# Predicted vs Actual (test set)
png("predicted_vs_actual.png", width = 700, height = 600)
plot(test$Profit_capped, predictions,
     xlab = "Actual Profit ($)", ylab = "Predicted Profit ($)",
     main = "Predicted vs Actual Profit (Test Set)")
abline(0, 1, col = "red", lty = 2)
dev.off()
