-- Q4: Estimate CLV based on account tenure and transaction volume
SELECT
    u.id AS customer_id,
    u.name,

    -- Tenure in months since sign-up
    (EXTRACT(YEAR FROM CURRENT_DATE) * 12 + EXTRACT(MONTH FROM CURRENT_DATE)) -
    (EXTRACT(YEAR FROM u.date_joined) * 12 + EXTRACT(MONTH FROM u.date_joined)) AS tenure_months,

    COUNT(s.id) AS total_transactions,

    -- CLV = (total_tx / tenure) * 12 * avg_profit_per_transaction
    -- Profit per transaction = 0.1% = 0.001
    ROUND(
        (
            COUNT(s.id)/
            GREATEST(
                (EXTRACT(YEAR FROM CURRENT_DATE) * 12 + EXTRACT(MONTH FROM CURRENT_DATE)) -
                (EXTRACT(YEAR FROM u.date_joined) * 12 + EXTRACT(MONTH FROM u.date_joined)), 1
            )
        ) * 12 * 0.001,
        2
    ) AS estimated_clv
FROM users_customuser u
JOIN plans_plan p ON p.owner_id = u.id
JOIN savings_savingsaccount s ON s.plan_id = p.id
GROUP BY u.id, u.name, u.date_joined
ORDER BY estimated_clv DESC;
