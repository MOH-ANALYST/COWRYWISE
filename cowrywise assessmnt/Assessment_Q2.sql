-- Q2: Transaction Frequency Analysis

WITH monthly_txn AS (
SELECT s.savings_id,
MONTH(s.transaction_date) AS txn_month,
count(*) AS transaction_in_month
FROM savings_savingsaccount S
GROUP BY s.savings_id ,
MONTH(s.transaction_date)
),
avg_txn_per_user AS (
SELECT savings_id,
AVG(transaction_in_month) AS avg_transactions_per_month
FROM monthly_txn
GROUP BY savings_id),
user_segments AS (
SELECT savings_id,
avg_transactions_per_month,
CASE
WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
WHEN avg_transactions_per_month <= 2 THEN 'Low Frequency'
ELSE 'UNKOWN'
END AS frequency_category
FROM avg_txn_per_user)
SELECT
frequency_category,
count(*) AS customer_count,
round(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM user_segments
GROUP BY frequency_category
ORDER BY customer_count DESC;
