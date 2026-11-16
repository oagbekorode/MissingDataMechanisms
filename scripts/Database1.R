# =====================================================================
# Lab Assignment: Identifying Missing Data Mechanisms (MCAR vs. MNAR)
# Dataset 1: Simulated E-commerce Transaction Data (Missing Transaction Amounts)
# =====================================================================

# 1. Load Required Libraries
library(readxl)
library(stats)

# 2. Load the Dataset
Ecommerce <- read_excel("Documents/Jax State /Fall 26/CS445/Assignment (This)/Ecommerce.xlsx")

print("--- Initial Dataset Summary ---")
summary(Ecommerce)

# Check missing value counts per column
print("--- Missing Values Count per Column ---")
print(colSums(is.na(Ecommerce)))


# 3. Create Missingness Indicator Variable for Transaction_Amount
# R = 1 if Transaction_Amount is missing (NA), 0 if observed
Ecommerce$Missing_Transaction <- ifelse(is.na(Ecommerce$Transaction_Amount), 1, 0)

print("--- Missingness Frequency Table ---")
print(table(Ecommerce$Missing_Transaction))


print("TEST 1: Logistic Regression Model")

# Predicting missing transaction amount using Customer_Age and Product_Rating
logit_model <- glm(Missing_Transaction ~ Customer_Age + Product_Rating, 
                   data = Ecommerce, 
                   family = binomial(link = "logit"))
print(summary(logit_model))

print("TEST 2: Correlation Analysis")

cor_age <- cor.test(Ecommerce$Missing_Transaction, Ecommerce$Customer_Age)
print("Correlation with Customer_Age:")
print(cor_age)

cor_rating <- cor.test(Ecommerce$Missing_Transaction, Ecommerce$Product_Rating)
print("Correlation with Product_Rating:")
print(cor_rating)


print("TEST 3: ANOVA / T-Test Group Comparisons")

# Independent t-test for Customer_Age grouped by missing transaction status
print("T-Test for Customer_Age across Missingness Groups:")
ttest_age <- t.test(Customer_Age ~ Missing_Transaction, data = Ecommerce)
print(ttest_age)

# Independent t-test for Product_Rating grouped by missing transaction status
print("T-Test for Product_Rating across Missingness Groups:")
ttest_rating <- t.test(Product_Rating ~ Missing_Transaction, data = Ecommerce)
print(ttest_rating)

# One-Way ANOVA equivalent using aov() for Customer Age
print("One-Way ANOVA for Customer_Age:")
anova_age <- aov(Customer_Age ~ as.factor(Missing_Transaction), data = Ecommerce)
print(summary(anova_age))