# =====================================================================
# Lab Assignment: Identifying Missing Data Mechanisms (MCAR vs. MNAR)
# Dataset 2: Simulated Hospital Patient Data
# =====================================================================

# 1. Load Required Libraries
library(readxl)
library(stats)

# 2. Load Dataset 2 
Hospital_Data <- read_excel("Documents/Jax State /Fall 26/CS445/Assignment (This)/Patient.xlsx")

print("--- Initial Dataset Summary ---")
summary(Hospital_Data)

# Check missing value counts per column to locate which variable has NAs
print("--- Missing Values Count per Column ---")
print(colSums(is.na(Hospital_Data)))


# 3. Create Missingness Indicator Variable
Hospital_Data$Missing_BP <- ifelse(is.na(Hospital_Data$Blood_Pressure), 1, 0)

print("--- Missingness Frequency Table ---")
print(table(Hospital_Data$Missing_BP))


# Diagnostic Test 1: Logistic Regression Model
# Predict missingness indicator using the other two variables
print("TEST 1: Logistic Regression Model")

logit_model_hosp <- glm(Missing_BP ~ Age + BMI, 
                        data = Hospital_Data, 
                        family = binomial(link = "logit"))
print(summary(logit_model_hosp))

# Diagnostic Test 2: Correlation Analysis
# Check linear relationships between missingness and observed features
print("TEST 2: Correlation Analysis")

cor_age_hosp <- cor.test(Hospital_Data$Missing_BP, Hospital_Data$Age)
print("Correlation with Age:")
print(cor_age_hosp)

cor_bmi_hosp <- cor.test(Hospital_Data$Missing_BP, Hospital_Data$BMI)
print("Correlation with BMI:")
print(cor_bmi_hosp)

# Diagnostic Test 3: ANOVA / Independent T-Test
print("TEST 3: ANOVA / T-Test Group Comparisons")

# Independent t-test for Age grouped by missingness
print("T-Test for Age across Missingness Groups:")
ttest_age_hosp <- t.test(Age ~ Missing_BP, data = Hospital_Data)
print(ttest_age_hosp)

# Independent t-test for BMI grouped by missingness
print("T-Test for BMI across Missingness Groups:")
ttest_bmi_hosp <- t.test(BMI ~ Missing_BP, data = Hospital_Data)
print(ttest_bmi_hosp)

# One-Way ANOVA for Age across Missingness Groups
print("One-Way ANOVA for Age:")
anova_age_hosp <- aov(Age ~ as.factor(Missing_BP), data = Hospital_Data)
print(summary(anova_age_hosp))