-- Q3: Account Inactivity Alert
WITH txn_inflows AS 
(
SELECT sa.plan_id,
MAX(sa.transaction_date) AS last_transaction_date
FROM savings_savingsaccount sa
GROUP BY sa.plan_id
),
inactive_accounts AS (
    SELECT
        pp.id AS plan_id,
        pp.owner_id,
        ti.last_transaction_date,
        DATEDIFF(CURDATE(), ti.last_transaction_date) AS inactivity_days
    FROM plans_plan pp
    LEFT JOIN txn_inflows ti ON pp.id = ti.plan_id
    WHERE 
	ti.last_transaction_date IS NULL
	OR ti.last_transaction_date < CURDATE() - INTERVAL 365 DAY
)
SELECT *
FROM inactive_accounts;
