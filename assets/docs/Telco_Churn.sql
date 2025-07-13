----------- Exploratory Analysis ------------


-- 1. What is the churn rate segmented by contract type, internet service, and payment method?

SELECT 
	contract,
	internet_service,
	payment_method,
	COUNT(customer_id) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customer_id), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY contract, internet_service, payment_method
ORDER BY churn_rate_percentage DESC;

-- 2. How does churn vary by customer tenure groups (e.g., 0-6 months, 7-12 months, 1+ years)?

SELECT 
	tenure_group,
	COUNT(customer_id) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customer_id), 2) AS churn_rate_percentage
FROM
(
	SELECT customer_id, churn,
		CASE
			WHEN tenure_months <= '6' THEN '0-6 months'
			WHEN tenure_months <= '12' THEN '7-12 months'
			ELSE '+1 years'
		END AS tenure_group
	FROM telco_churn
) AS grouped
GROUP BY tenure_group
ORDER BY churn_rate_percentage DESC;

-- 3. Which customer segments have the highest churn counts and rates?

SELECT 
	contract,
	internet_service,
	payment_method,
	COUNT(customer_id) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customer_id), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY contract, internet_service, payment_method
ORDER BY churn_rate_percentage DESC, total_customers DESC;

-- 4. Can I calculate customer lifetime value (CLTV) or average revenue per user (ARPU) by segment?

WITH CTE_customer_cltv AS (
    SELECT 
        customer_id,
        contract,
        internet_service,
        payment_method,
        monthly_charges,
        tenure_months,
        (monthly_charges * tenure_months) AS cltv
    FROM telco_churn
)

SELECT 
    contract,
    internet_service,
    payment_method,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_revenue,
    ROUND(AVG(cltv), 2) AS avg_cltv
FROM CTE_customer_cltv
GROUP BY contract, internet_service, payment_method
ORDER BY avg_cltv DESC;

-- 5. What is the correlation between monthly charges and churn (using window functions or ranking)?

WITH CTE_ranked_customers AS (
    SELECT 
        customer_id,
		internet_service,
        payment_method,
        monthly_charges,
        churn,
        NTILE(4) OVER (ORDER BY monthly_charges) AS charge_quartile,
		CASE 
            WHEN NTILE(4) OVER (ORDER BY monthly_charges) = 1 THEN 'Low'
            WHEN NTILE(4) OVER (ORDER BY monthly_charges) = 2 THEN 'Medium-Low'
            WHEN NTILE(4) OVER (ORDER BY monthly_charges) = 3 THEN 'Medium-High'
            ELSE 'High'
        END AS charge_level
    FROM telco_churn
)
SELECT 
    charge_quartile,
    COUNT(customer_id) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(customer_id), 2) AS churn_rate_percentage
FROM CTE_ranked_customers
GROUP BY charge_quartile, charge_level
ORDER BY charge_quartile;

-- 6. Which customers have multiple services and are they more or less likely to churn?

WITH CTE_service_counts AS (
    SELECT 
        customer_id,
        churn,
-- Count how many services are active for each customer
        (
            (CASE WHEN phone_service = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN multiple_lines = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN internet_service != 'No' THEN 1 ELSE 0 END) +
            (CASE WHEN online_security = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN online_backup = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN device_protection = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN tech_support = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN streaming_tv = 'Yes' THEN 1 ELSE 0 END) +
            (CASE WHEN streaming_movies = 'Yes' THEN 1 ELSE 0 END)
        ) AS service_count
    FROM telco_churn
),
CTE_bucketed_customers AS (
    SELECT 
        customer_id,
        churn,
        service_count,
        CASE 
            WHEN service_count <= 2 THEN '1-2 Services'
            WHEN service_count BETWEEN 3 AND 5 THEN '3-5 Services'
            ELSE '6+ Services'
        END AS service_tier
    FROM CTE_service_counts
)
SELECT 
    service_tier,
    COUNT(customer_id) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customer_id), 2) AS churn_rate_percentage
FROM CTE_bucketed_customers
GROUP BY service_tier
ORDER BY churn_rate_percentage DESC;

-- 7. How many customers are churned versus active by region or demographic group?

SELECT 
	gender, senior_citizen, partner, dependents,
	COUNT(customer_id) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customer_id), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY gender, senior_citizen, partner, dependents
ORDER BY churn_rate_percentage DESC;

-- 8. Can I generate datasets for “high-risk” customers based on churn probability thresholds?

WITH CTE_scored_customers AS (
    SELECT 
        customer_id,
        gender,
        senior_citizen,
        partner,
        dependents,
        tenure_months,
        contract,
        monthly_charges,
        internet_service,
        online_security,
        tech_support,
        paperless_billing,
        churn,  
-- Assign points based on churn risk factors
        (CASE WHEN contract = 'Month-to-month' THEN 1 ELSE 0 END) +
        (CASE WHEN tenure_months <= 6 THEN 1 ELSE 0 END) +
        (CASE WHEN monthly_charges >= 80 THEN 1 ELSE 0 END) +
        (CASE WHEN online_security = 'No' THEN 1 ELSE 0 END) +
        (CASE WHEN tech_support = 'No' THEN 1 ELSE 0 END) +
        (CASE WHEN paperless_billing = 'Yes' THEN 1 ELSE 0 END)
        AS risk_score
    FROM telco_churn
)
SELECT 
    *
FROM CTE_scored_customers
WHERE risk_score >= 4
ORDER BY risk_score DESC, tenure_months;

