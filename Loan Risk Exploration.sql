-- Exploratory Analysis for Loan Risk Analysis
-- Check Loan Status Distribution
SELECT `Loan Status`, COUNT(*) AS total
FROM loan_risk_sample
GROUP BY `Loan Status`;

-- Average Loan Amount by Employment Duration
SELECT Employement_Duration, 
       COUNT(*) AS total_loans, 
       AVG(Loan_Amount) AS avg_loan_amount
FROM loan_risk_sample
GROUP BY Employement_Duration
ORDER BY avg_loan_amount DESC;

-- Loan Default Rate by Grade
SELECT Grade, 
       COUNT(*) AS total, 
       SUM(CASE WHEN `Loan Status` = 1 THEN 1 ELSE 0 END) AS defaults,
       ROUND(100.0 * SUM(CASE WHEN `Loan Status` = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_risk_sample
GROUP BY Grade
ORDER BY default_rate_pct DESC;
-- Debt to Imcome Comparison
SELECT 
    CASE 
        WHEN Debit_ToIncome < 10 THEN 'Low DTI'
        WHEN Debit_ToIncome BETWEEN 10 AND 20 THEN 'Medium DTI'
        ELSE 'High DTI'
    END AS DTI_Category,
    COUNT(*) AS total,
    AVG(Loan_Amount) AS avg_loan,
    ROUND(100.0 * SUM(CASE WHEN `Loan Status` = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_risk_sample
GROUP BY DTI_Category;
-- Default Rate by Employement Type 
SELECT Employement_Duration, 
       COUNT(*) AS total_applicants,
       SUM(CASE WHEN `Loan Status` = 1 THEN 1 ELSE 0 END) AS defaulted,
       ROUND(100.0 * SUM(CASE WHEN `Loan Status` = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_risk_sample
GROUP BY Employement_Duration
ORDER BY default_rate_pct DESC;
