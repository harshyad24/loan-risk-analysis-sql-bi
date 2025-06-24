-- ============================================
-- PHASE 1: DATA UNDERSTANDING & CLEANING
-- Dataset: loan_default
-- ============================================

-- STEP 1: INITIAL DATA EXPLORATION
DESCRIBE loan_default_prediction.loan_default;

-- ============================================

-- Check total records and basic structure
SELECT COUNT(*) as total_records
FROM `loan_default_prediction`.`loan_default`;

-- View first 10 rows to understand data structure
SELECT * 
FROM `loan_default_prediction`.`loan_default`
LIMIT 10;

-- Get column information and data types
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'loan_default_prediction' 
  AND TABLE_NAME = 'loan_default'
ORDER BY ORDINAL_POSITION;

-- STEP 2: DATA QUALITY ASSESSMENT
-- ============================================

-- Check for NULL values in all columns
SELECT 
    COUNT(*) as total_rows,
    COUNT(LoanID) as loan_id_count,
    COUNT(Age) as age_count,
    COUNT(Income) as income_count,
    COUNT(LoanAmount) as loan_amount_count,
    COUNT(CreditScore) as credit_score_count,
    COUNT(MonthsEmployed) as months_employed_count,
    COUNT(NumCreditLines) as num_credit_lines_count,
    COUNT(InterestRate) as interest_rate_count,
    COUNT(LoanTerm) as loan_term_count,
    COUNT(DTIRatio) as dti_ratio_count,
    COUNT(Education) as education_count,
    COUNT(EmploymentType) as employment_type_count,
    COUNT(MaritalStatus) as marital_status_count,
    COUNT(HasMortgage) as has_mortgage_count,
    COUNT(HasDependents) as has_dependents_count,
    COUNT(LoanPurpose) as loan_purpose_count,
    COUNT(HasCoSigner) as has_cosigner_count,
    COUNT(`Default`) as default_count
FROM `loan_default_prediction`.`loan_default`;


-- Check for duplicate records
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT LoanID) AS unique_loan_ids,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT LoanID) THEN 'No Duplicates'
        ELSE 'Duplicates Found'
    END AS duplicate_status
FROM loan_default_prediction.loan_default;


-- STEP 3: CATEGORICAL DATA ANALYSIS
-- ============================================

-- Check unique values in categorical columns
SELECT 'Education' as column_name, Education as value, COUNT(*) as count
FROM `loan_default_prediction`.`loan_default` 
GROUP BY Education
UNION ALL
SELECT 'EmploymentType', EmploymentType, COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY EmploymentType
UNION ALL
SELECT 'MaritalStatus', MaritalStatus, COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY MaritalStatus
UNION ALL
SELECT 'HasMortgage', HasMortgage, COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY HasMortgage
UNION ALL
SELECT 'HasDependents', HasDependents, COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY HasDependents
UNION ALL
SELECT 'LoanPurpose', LoanPurpose, COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY LoanPurpose
UNION ALL
SELECT 'HasCoSigner', HasCoSigner, COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY HasCoSigner
UNION ALL
SELECT 'Default', CAST(`Default` as CHAR), COUNT(*)
FROM `loan_default_prediction`.`loan_default` 
GROUP BY `Default`
ORDER BY column_name, value;

-- STEP 4: NUMERICAL DATA SUMMARY STATISTICS
-- ============================================

WITH ordered_age AS (
  SELECT Age, ROW_NUMBER() OVER (ORDER BY Age) AS rn
  FROM `loan_default_prediction`.`loan_default`
),
total_rows AS (
  SELECT COUNT(*) AS cnt FROM `loan_default_prediction`.`loan_default`
),
median_age AS (
  SELECT Age AS median
  FROM ordered_age, total_rows
  WHERE rn = FLOOR(cnt / 2) + 1
)

SELECT 
  'Age' AS column_name,
  MIN(ld.Age) AS min_value,
  MAX(ld.Age) AS max_value,
  AVG(ld.Age) AS avg_value,
  MAX(ma.median) AS median_value,
  STDDEV(ld.Age) AS std_dev,
  COUNT(ld.Age) AS non_null_count
FROM `loan_default_prediction`.`loan_default` ld
JOIN median_age ma ON 1=1;




-- STEP 5: OUTLIER DETECTION
-- ============================================

-- Detect outliers using IQR method (values beyond Q1-1.5*IQR or Q3+1.5*IQR)

WITH
-- Assign quartiles for Age
quartiles_age AS (
  SELECT Age, NTILE(4) OVER (ORDER BY Age) AS quartile
  FROM loan_default_prediction.loan_default
),
q_age AS (
  SELECT 
    MAX(CASE WHEN quartile = 1 THEN Age END) AS Q1,
    MAX(CASE WHEN quartile = 3 THEN Age END) AS Q3
  FROM quartiles_age
),
-- Assign quartiles for Income
quartiles_income AS (
  SELECT Income, NTILE(4) OVER (ORDER BY Income) AS quartile
  FROM loan_default_prediction.loan_default
),
q_income AS (
  SELECT 
    MAX(CASE WHEN quartile = 1 THEN Income END) AS Q1,
    MAX(CASE WHEN quartile = 3 THEN Income END) AS Q3
  FROM quartiles_income
),
-- Assign quartiles for LoanAmount
quartiles_loan AS (
  SELECT LoanAmount, NTILE(4) OVER (ORDER BY LoanAmount) AS quartile
  FROM loan_default_prediction.loan_default
),
q_loan AS (
  SELECT 
    MAX(CASE WHEN quartile = 1 THEN LoanAmount END) AS Q1,
    MAX(CASE WHEN quartile = 3 THEN LoanAmount END) AS Q3
  FROM quartiles_loan
),
-- Calculate IQR and join original data with quartiles for Age
outliers_age AS (
  SELECT ld.Age, q.Q1, q.Q3, (q.Q3 - q.Q1) AS IQR
  FROM loan_default_prediction.loan_default ld
  CROSS JOIN q_age q
),
-- Calculate IQR and join original data with quartiles for Income
outliers_income AS (
  SELECT ld.Income, q.Q1, q.Q3, (q.Q3 - q.Q1) AS IQR
  FROM loan_default_prediction.loan_default ld
  CROSS JOIN q_income q
),
-- Calculate IQR and join original data with quartiles for LoanAmount
outliers_loan AS (
  SELECT ld.LoanAmount, q.Q1, q.Q3, (q.Q3 - q.Q1) AS IQR
  FROM loan_default_prediction.loan_default ld
  CROSS JOIN q_loan q
)

SELECT 
  -- Count Age outliers
  (SELECT COUNT(*) FROM outliers_age
   WHERE Age < (Q1 - 1.5 * IQR) OR Age > (Q3 + 1.5 * IQR)
  ) AS age_outliers,

  -- Count Income outliers
  (SELECT COUNT(*) FROM outliers_income
   WHERE Income < (Q1 - 1.5 * IQR) OR Income > (Q3 + 1.5 * IQR)
  ) AS income_outliers,

  -- Count LoanAmount outliers
  (SELECT COUNT(*) FROM outliers_loan
   WHERE LoanAmount < (Q1 - 1.5 * IQR) OR LoanAmount > (Q3 + 1.5 * IQR)
  ) AS loan_amount_outliers;



-- STEP 6: DATA CLEANING - CREATE CLEANED VERSION
-- ============================================



CREATE TABLE `loan_default_prediction`.`loan_default_clean` AS
SELECT 
    LoanID,
    Age,
    Income,
    LoanAmount,
    CreditScore,
    MonthsEmployed,
    NumCreditLines,
    InterestRate,
    LoanTerm,
    DTIRatio,
    
    -- Standardize categorical variables
    CASE 
        WHEN UPPER(TRIM(Education)) IN ('HIGH SCHOOL', 'HIGHSCHOOL') THEN 'High School'
        WHEN UPPER(TRIM(Education)) IN ('BACHELOR', 'BACHELORS') THEN 'Bachelor'
        WHEN UPPER(TRIM(Education)) IN ('MASTER', 'MASTERS') THEN 'Master'
        WHEN UPPER(TRIM(Education)) = 'PHD' THEN 'PhD'
        ELSE TRIM(Education)
    END as Education_Clean,
    
    CASE 
        WHEN UPPER(TRIM(EmploymentType)) = 'FULL-TIME' THEN 'Full-time'
        WHEN UPPER(TRIM(EmploymentType)) = 'PART-TIME' THEN 'Part-time'
        WHEN UPPER(TRIM(EmploymentType)) = 'SELF-EMPLOYED' THEN 'Self-employed'
        WHEN UPPER(TRIM(EmploymentType)) = 'UNEMPLOYED' THEN 'Unemployed'
        ELSE TRIM(EmploymentType)
    END as EmploymentType_Clean,
    
    CASE 
        WHEN UPPER(TRIM(MaritalStatus)) = 'SINGLE' THEN 'Single'
        WHEN UPPER(TRIM(MaritalStatus)) = 'MARRIED' THEN 'Married'
        WHEN UPPER(TRIM(MaritalStatus)) = 'DIVORCED' THEN 'Divorced'
        ELSE TRIM(MaritalStatus)
    END as MaritalStatus_Clean,
    
    -- Convert Yes/No to consistent format
    CASE 
        WHEN UPPER(TRIM(HasMortgage)) IN ('YES', 'Y', '1', 'TRUE') THEN 1
        WHEN UPPER(TRIM(HasMortgage)) IN ('NO', 'N', '0', 'FALSE') THEN 0
        ELSE NULL
    END as HasMortgage_Binary,
    
    CASE 
        WHEN UPPER(TRIM(HasDependents)) IN ('YES', 'Y', '1', 'TRUE') THEN 1
        WHEN UPPER(TRIM(HasDependents)) IN ('NO', 'N', '0', 'FALSE') THEN 0
        ELSE NULL
    END as HasDependents_Binary,
    
    CASE 
        WHEN UPPER(TRIM(HasCoSigner)) IN ('YES', 'Y', '1', 'TRUE') THEN 1
        WHEN UPPER(TRIM(HasCoSigner)) IN ('NO', 'N', '0', 'FALSE') THEN 0
        ELSE NULL
    END as HasCoSigner_Binary,
    
    TRIM(LoanPurpose) as LoanPurpose_Clean,
    
    -- Target variable
    `Default` as Default_Target,
    
    -- Create derived features
    CASE 
        WHEN Age < 25 THEN 'Young'
        WHEN Age BETWEEN 25 AND 40 THEN 'Middle'
        WHEN Age BETWEEN 41 AND 60 THEN 'Mature'
        ELSE 'Senior'
    END as Age_Group,
    
    CASE 
        WHEN CreditScore >= 750 THEN 'Excellent'
        WHEN CreditScore >= 700 THEN 'Good'
        WHEN CreditScore >= 650 THEN 'Fair'
        ELSE 'Poor'
    END as Credit_Grade,
    
    CASE 
        WHEN DTIRatio <= 0.2 THEN 'Low Risk'
        WHEN DTIRatio <= 0.4 THEN 'Medium Risk'
        ELSE 'High Risk'
    END as DTI_Risk_Level

FROM `loan_default_prediction`.`loan_default`
-- Filter out any problematic records if needed
WHERE Age IS NOT NULL 
  AND Income IS NOT NULL
  AND LoanAmount IS NOT NULL
  AND CreditScore IS NOT NULL
  AND `Default` IS NOT NULL;

-- STEP 7: FINAL DATA QUALITY CHECK
-- ============================================

-- Verify cleaned data
SELECT 
    COUNT(*) as total_clean_records,
    COUNT(DISTINCT LoanID) as unique_loans,
    AVG(Age) as avg_age,
    AVG(Income) as avg_income,
    AVG(CreditScore) as avg_credit_score,
    SUM(Default_Target) as total_defaults,
    ROUND(AVG(Default_Target) * 100, 2) as default_rate_percent
FROM `loan_default_prediction`.`loan_default_clean`;

-- Check distribution of cleaned categorical variables
SELECT 'Education_Clean' as variable, Education_Clean as category, COUNT(*) as count
FROM `loan_default_prediction`.`loan_default_clean` GROUP BY Education_Clean
UNION ALL
SELECT 'Credit_Grade', Credit_Grade, COUNT(*)
FROM `loan_default_prediction`.`loan_default_clean` GROUP BY Credit_Grade
UNION ALL
SELECT 'Age_Group', Age_Group, COUNT(*)
FROM `loan_default_prediction`.`loan_default_clean` GROUP BY Age_Group
ORDER BY variable, category;