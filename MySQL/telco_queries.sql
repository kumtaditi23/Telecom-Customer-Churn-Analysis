SELECT COUNT(*) FROM telco_churn_table;
SELECT COUNT(*) FROM telco_churn_table WHERE churn = 'yes';
SELECT COUNT(*) FROM telco_churn_table WHERE churn = 'no';

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM telco_churn_table;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn_table
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT
    COUNT(*) AS total_customers,

    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,

    ROUND(
        SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM telco_churn_table
GROUP BY tenure_group
ORDER BY churn_rate DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn_table
GROUP BY tenure_group
ORDER BY churn_rate DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn_table
GROUP BY monthly_charge_group
ORDER BY churn_rate DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn_table
GROUP BY InternetService
ORDER BY churn_rate DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn_table
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM telco_churn_table
GROUP BY OnlineSecurity
ORDER BY churn_rate DESC;

SELECT
    TotalCharges,
    REPLACE(REPLACE(TotalCharges,'? ',''),',','') AS cleaned_value
FROM telco_churn_table
LIMIT 10;

SET SQL_SAFE_UPDATES = 0;

UPDATE telco_churn_table
SET TotalCharges_Clean =
CAST(
    REPLACE(
        REPLACE(TotalCharges,'? ',''),
        ',',''
    ) AS DECIMAL(12,2)
);

SET SQL_SAFE_UPDATES = 1;

SELECT
    COUNT(*) AS total_rows,
    COUNT(TotalCharges_Clean) AS populated_rows
FROM telco_churn_table;

SELECT
    ROUND(SUM(TotalCharges_Clean),2) AS revenue_lost
FROM telco_churn_table
WHERE Churn = 'Yes';

SELECT
    Contract,
    ROUND(SUM(TotalCharges_Clean),2) AS total_revenue
FROM telco_churn_table
GROUP BY Contract
ORDER BY total_revenue DESC;

SELECT
    Contract,
    ROUND(AVG(TotalCharges_Clean),2) AS avg_customer_value
FROM telco_churn_table
GROUP BY Contract;