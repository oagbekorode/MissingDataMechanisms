# =====================================================================
# Lab Assignment: Identifying Missing Data Mechanisms (MCAR vs. MNAR)
# Dataset 3: Simulated Employee Performance Data

# 1. Load Required Libraries
library(readxl)
library(stats)

# 2. Load Dataset 3 
Employee_Data <- read_excel("Documents/Jax State /Fall 26/CS445/Assignment (This)/Parformance.xlsx")

summary(Employee_Data)

# Check missing value counts per column to locate which variable has NAs
print("--- Missing Values Count per Column ---")
print(colSums(is.na(Employee_Data)))

# 3. Create Missingness Indicator Variable
Employee_Data$Missing_Performance <- ifelse(is.na(Employee_Data$Performance_Score), 1, 0)

print("--- Missingness Frequency Table ---")
print(table(Employee_Data$Missing_Performance))


# Diagnostic Test 1: Logistic Regression Model
# Predict missingness indicator using the other two variables

print("TEST 1: Logistic Regression Model")

logit_model_emp <- glm(Missing_Performance ~ Experience_Years + Salary, 
                       data = Employee_Data, 
                       family = binomial(link = "logit"))
print(summary(logit_model_emp))


# Diagnostic Test 2: Correlation Analysis
# Check linear relationships between missingness and observed features

print("TEST 2: Correlation Analysis")

cor_exp_emp <- cor.test(Employee_Data$Missing_Performance, Employee_Data$Experience_Years)
print("Correlation with Experience_Years:")
print(cor_exp_emp)

cor_sal_emp <- cor.test(Employee_Data$Missing_Performance, Employee_Data$Salary)
print("Correlation with Salary:")
print(cor_sal_emp)


# Diagnostic Test 3: ANOVA / Independent T-Test
# Compare means of observed variables between missing and non-missing groups

print("TEST 3: ANOVA / T-Test Group Comparisons")

# Independent t-test for Experience_Years grouped by missingness
print("T-Test for Experience_Years across Missingness Groups:")
ttest_exp_emp <- t.test(Experience_Years ~ Missing_Performance, data = Employee_Data)
print(ttest_exp_emp)

# Independent t-test for Salary grouped by missingness
print("T-Test for Salary across Missingness Groups:")
ttest_sal_emp <- t.test(Salary ~ Missing_Performance, data = Employee_Data)
print(ttest_sal_emp)

# One-Way ANOVA for Experience_Years across Missingness Groups
print("One-Way ANOVA for Experience_Years:")
anova_exp_emp <- aov(Experience_Years ~ as.factor(Missing_Performance), data = Employee_Data)
print(summary(anova_exp_emp))