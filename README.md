# COWRYWISE  
# SQL Assessment – README

Hi there! 👋  
This document walks through how I approached each question in the SQL assessment, the challenges I encountered, and how I tackled them. My focus was not just on writing correct queries, but on making sure they made sense and aligned with what the questions were really asking.

---

## Question 1: High-Value Customers with Multiple Products

### 💡 Approach  
The task was to identify customers who have both savings and investment products and rank them by total confirmed deposits. Here's what I did:
- Used `CASE` inside `COUNT(DISTINCT ...)` to count the different types of products each customer had.
- Joined the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables to link users to their plans and transactions.
- Filtered out archived and deleted plans so only active ones were considered.
- Aggregated confirmed deposits and sorted users by total deposit amount in descending order.

### ⚠️ Challenges  
- Understanding the relationship between `is_regular_savings` and `is_a_fund` got a bit confusing at first — I wasn’t sure if both could be true at the same time.
- I had to be careful with `DISTINCT` to avoid double-counting any products.
- At first, I didn’t filter out inactive or deleted plans, and my results looked off. Adding those filters fixed it.

---

## Question 2: Transaction Frequency Analysis

### 💡 Approach  
The goal here was to group users based on how often they make transactions. What I did:
- Counted how many transactions happened per month for each account.
- Averaged those monthly transaction counts at the user level.
- Categorized users into high, medium, or low-frequency groups based on their averages.
- Counted how many users were in each group and calculated their average transaction frequency.

### ⚠️ Challenges  
- I found out that using just `MONTH()` would group transactions from the same month across different years, which wasn’t accurate. That’s something I’d definitely fix with a better date grouping approach in the future.
- Broke the query into CTEs to make it easier to read and debug step by step.
- Honestly, I struggled a bit with getting the logic right — especially the part where I had to get the monthly average from raw transaction counts.
- I wasn’t 100% sure using `COUNT(*)` as `transaction_in_month` and then averaging that across months would work, but it did, and I was happy with the outcome.

---

## Question 3: Identifying Inactive Accounts

### 💡 Approach  
This one was about finding accounts that haven’t had any activity in over a year, or never had a transaction at all. My approach:
- Used `MAX(transaction_date)` to get the most recent transaction for each account.
- Used `DATEDIFF()` to check how long it’s been since the last activity.
- Used `LEFT JOIN` so accounts with no transactions would still show up in the result.
- Filtered for accounts where the last activity was over 365 days ago, or the transaction date was `NULL`.

### ⚠️ Challenges  
- Handling `NULL` values was a bit tricky — I had to use `IS NULL` properly to make sure those accounts were captured.
- I had to make sure I wasn’t misclassifying accounts that had borderline dates (just around 365 days).
- I wasn’t sure if `NULL` really meant no activity or just missing data — something I’d double-check if I had access to the data team.
- Also, I didn’t see anything like a "plan type" field in the tables provided, so I had to focus on what was available.

---

## Question 4: Estimating Customer Lifetime Value (CLV)

### 💡 Approach  
The idea here was to estimate each customer’s value over time using how long they’ve been active and how frequently they transact. Here's my breakdown:
- Calculated how long each user has been active in months by comparing join date to the current date.
- Counted total transactions.
- Estimated CLV using a simple formula: assumed all customer generate the same profit 
  `CLV = (monthly transaction rate) × 12 × 0.001`
- finally rounded the CLV estimate to 2 decimal place and ordered the result from highest to the lowest

### ⚠️ Challenges  
- SQL doesn’t really have a direct way to calculate full months between two dates, so I had to break it down using `EXTRACT(YEAR)` and `EXTRACT(MONTH)`.
- I used `GREATEST(..., 1)` in the denominator to avoid dividing by zero for users with very short tenures.
- The 0.001 profit rate was just an assumption for this case — in reality, I know this would be based on real financial metrics.
- 

### 🙌 Final Notes

This assessment really helped me put my SQL knowledge to the test. Some parts were tricky, but I enjoyed figuring them out and making sure my logic matched real-world expectations.  

If you’re reviewing this for a job opportunity — thank you for reading. I’m excited about opportunities to grow and contribute as a data analyst, and I’d love the chance to work with your team.

— **Mustapha Oladimeji Hamzat**  

[🔗 GitHub](https://github.com/MOH-ANALYST) | [🌐 Portfolio](https://moh-analyst.github.io/) | [💼 LinkedIn](https://www.linkedin.com/in/h%C3%A1mz%C3%A4-mustapha-a41088238/)

