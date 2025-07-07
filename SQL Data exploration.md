# Loan Default Dataset – Data Understanding

## Phase 1: Exploratory Data Analysis (EDA) 

This project performs exploratory data analysis, quality assessment, and data cleaning on the `loan_default` dataset. The goal is to produce a clean dataset ready for machine learning modeling and insights generation.

---

## 📂 Dataset Source

This project uses the **Loan Default Prediction** dataset available on Kaggle:

**Kaggle URL:** [https://www.kaggle.com/datasets/nikhil1e9/loan-default](https://www.kaggle.com/datasets/nikhil1e9/loan-default)

- **Author:** [Nikhil1e9](https://www.kaggle.com/nikhil1e9)
- **License:** Public Domain (CC0)
- **Format:** CSV
- **File Size:** ~7 MB

The dataset contains anonymized financial and demographic attributes of loan applicants, used to build predictive models for identifying potential defaults. It includes features such as:

- Personal attributes: `Age`, `Education`, `EmploymentType`, `MaritalStatus`
- Financial metrics: `Income`, `LoanAmount`, `CreditScore`, `InterestRate`, `LoanTerm`, `DTIRatio`
- Flags: `HasMortgage`, `HasDependents`, `HasCoSigner`
- Target variable: `Default`

If you use this dataset, consider acknowledging the source on Kaggle.


---

## 🔍 Steps Covered

### 1. Initial Data Exploration
- Reviewed schema using `DESCRIBE` and `INFORMATION_SCHEMA`.
- Previewed sample records and checked row count.

### 2. Data Quality Assessment
- Identified missing values across key fields.
- Checked for duplicates based on `LoanID`.

### 3. Categorical Data Analysis
- Analyzed distributions of:
  - `Education`, `EmploymentType`, `MaritalStatus`, `HasMortgage`, `HasDependents`, `LoanPurpose`, `HasCoSigner`, and `Default`.

### 4. Numerical Data Summary
- Computed min, max, average, median, standard deviation, and non-null counts for numeric columns like `Age`.

### 5. Outlier Detection
- Detected outliers in:
  - `Age`, `Income`, `LoanAmount`
- Used the IQR (Interquartile Range) method.

### 6. Data Cleaning & Transformation
- Created new table `loan_default_clean` with:
  - Cleaned categorical variables (standardized text)
  - Binary transformation of Yes/No fields
  - Derived features:
    - `Age_Group`: Young / Middle / Mature / Senior
    - `Credit_Grade`: Excellent / Good / Fair / Poor
    - `DTI_Risk_Level`: Low / Medium / High Risk

### 7. Final Validation
- Verified counts, averages, and default rate.
- Checked distributions of newly created features.

---

## ✅ Cleaned Output Table

The cleaned table `loan_default_clean` is suitable for:

- Machine Learning pipelines
- Business Intelligence dashboards
- Statistical modeling

---

## 📈 Next Steps

- Phase 2: Feature Engineering  
- Phase 3: Predictive Modeling  
- Phase 4: Model Deployment & Monitoring

---

## 🛠 Technologies

- SQL (BigQuery-compatible)
- INFORMATION_SCHEMA metadata querying
- CTEs and window functions
- IQR-based statistical methods

---

## 📈 Key Findings

### 🎯 Default Rate

> **11.61%** of all loans were marked as defaulted
> (≈ **29,645 defaults** out of **255,347** total loans)

---

### 👥 Age Group Breakdown

| Age Group      | Count  | Percent |
| -------------- | ------ | ------- |
| Mature (41–60) | 97,975 | 38.4%   |
| Middle (25–40) | 78,994 | 30.9%   |
| Senior (61+)   | 44,202 | 17.3%   |
| Young (<25)    | 34,176 | 13.4%   |

---

### 💳 Credit Grade Distribution

| Credit Grade     | Count   | Percent |
| ---------------- | ------- | ------- |
| Poor (<650)      | 162,766 | 63.8%   |
| Fair (650–699)   | 23,151  | 9.1%    |
| Good (700–749)   | 22,856  | 9.0%    |
| Excellent (750+) | 46,574  | 18.2%   |

---

### 💡 DTI Risk Levels

| DTI Risk Level        | Count   | Percent |
| --------------------- | ------- | ------- |
| High Risk (>0.4)      | 157,978 | 61.9%   |
| Medium Risk (0.2–0.4) | 63,856  | 25.0%   |
| Low Risk (≤0.2)       | 33,513  | 13.1%   |


---

## 👤 Author

**Prepared by:** Harsh Yadav  
**Last Updated:** June 2025
