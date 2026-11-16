# Identifying Missing Data Mechanisms (MCAR vs. MNAR)

A statistical analysis project in **R** that diagnoses whether missing data in three simulated datasets are **Missing Completely at Random (MCAR)** or **Missing Not at Random (MNAR)**, and explains how missingness affects the data and any analysis built on it.

## Overview

Missing data is only harmless when it is unrelated to the values themselves. When it is not, estimates such as the mean and standard deviation become biased. For each dataset, a binary missingness indicator (1 = missing, 0 = observed) was created for the variable with missing values and tested against the remaining observed variables using three diagnostics. The findings are written up in one report per dataset.

## Diagnostic Tests

| # | Test | Purpose |
|---|------|---------|
| 1 | **Logistic regression** | Predict missingness from the other variables. Significant predictors suggest missingness is systematically related to observed data. |
| 2 | **Correlation analysis** | Correlate the missingness indicator with the other variables to look for systematic relationships. |
| 3 | **t-tests and one-way ANOVA** | Compare means of the observed variables between the missing and non-missing groups. |

A p-value above α = 0.05 on all tests means there is no evidence that missingness depends on the observed data.

## Datasets and Results

All datasets are simulated, with 1,000 records each.

| Dataset | Context | Variable with missing data | Records missing | Complete cases left | Conclusion |
|---------|---------|---------------------------|-----------------|---------------------|------------|
| 1 | E-commerce transactions | `Transaction_Amount` | 190 | 810 | **MCAR** |
| 2 | Hospital patients | `Blood_Pressure` | 218 | 782 | **MCAR** |
| 3 | Employee performance | `Performance_Score` | 229 | 771 | **MCAR** |

### Dataset 1: E-commerce Transactions
Predictors tested: `Customer_Age`, `Product_Rating`.
- Logistic regression: Customer_Age p = 0.793, Product_Rating p = 0.805
- Correlation with missingness: r = -0.0083 (Age), r = 0.0078 (Rating)
- ANOVA (Customer_Age): F = 0.068, p = 0.794

### Dataset 2: Hospital Patients
Predictors tested: `Age`, `BMI`.
- Logistic regression: Age p = 0.198, BMI p = 0.247
- Correlation with missingness: r = -0.0416 (Age), r = -0.0376 (BMI)
- ANOVA (Age): F = 1.731, p = 0.189

### Dataset 3: Employee Performance
Predictors tested: `Experience_Years`, `Salary`.
- Logistic regression: Experience_Years p = 0.949, Salary p = 0.306
- Correlation with missingness: r = -0.00002 (Experience), r = 0.0323 (Salary)
- ANOVA (Experience_Years): F ≈ 0, p = 0.999

### Takeaway
No diagnostic showed missingness related to the observed variables in any dataset, so the data are consistent with MCAR. Under MCAR, complete-case analysis does not bias the mean or standard deviation, but listwise deletion still costs 19–23% of the records. That lowers statistical power, widens confidence intervals and wastes valid information in the other columns. Multiple imputation or model-based estimation is recommended over listwise deletion.

## Repository Structure

```
.
├── README.md
├── assignment/
│   └── Assignment_Instructions.docx
├── reports/
│   ├── Dataset1_Ecommerce_Report.docx
│   ├── Dataset2_Hospital_Report.docx
│   └── Dataset3_Employee_Report.docx
└── scripts/
    └── (R script goes here)
```

## Running the Analysis

**Requirements:** R 4.0+ (RStudio optional).

```r
source("scripts/<your_script_name>.R")
```

## Skills Demonstrated

- Missing data diagnostics (MCAR vs. MNAR)
- Logistic regression, correlation analysis, t-tests and ANOVA in R
- Assessing the impact of missingness on bias, variance and statistical power
- Communicating statistical findings in a short written report

## Author

**Your Name** · [GitHub](https://github.com/oagbekorode)
