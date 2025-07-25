# Churn-Analysis-Dashboard

![Image Failed to Load](assets/images/Churn_Analysis_Image.png)


# Table of contents

- [Project Overview](#project-overview)
  - [Executive Summary](#executive-summary)
  - [Business Problem](#business-problem)
  - [Project Objective](#project-objective)
  - [Key Metrics & KPIs](#keymetrics-&-kpi)
    - [Churn Overview](#churn-overview)
    - [Risk Segmentation](#risk-segmentation)
    - [Customer Profile Analysis](#customer-profile-analysis)
    - [Retention Opportunities](#retention-opportunities)
- [Tools & Workflow](#tools-&-workflow)
  - [Excel: Data Cleaning & Exploration](#excel:-data-cleaning-&-exploration)
  - [PostgreSQL: SQL Analysis](#postgresql:-sql-analysis)
  - [Power BI: Dashboard Development](#power-bi:-dashboard-development)
- [Data Collection](#data-collection)
  - [Source](#source)
  - [Structure & Format](#structure-&-format)
- [Data Preparation](#data-preparation)
  - [Data Types & Formatting](#data-types-&-formatting)
- [SQL Analysis](#sql-analysis)
  - [Business Questions Answered](#business-questioned-answered)
- [DAX Calculations](#dax-calculations)
  - [Core Measures](#core-measures)
- [Dashboard Design](#dashboard-design) 
  - [Visuals Used](#visuals-used)
  - [User Interaction & Features](#user-interaction-&-features)
- [Key Insights](#key-insights)
  - [Trends Identified](#trends-identified)
  - [Recommendations](#recommendations)
 
# Project Overview
## Executive Summary
The telecommunications company is experiencing significant customer churn, particularly among month-to-month contract holders, fiber optic internet users, and customers using manual payment methods. Existing churn reports are static, spreadsheet-based, and lack clarity on the root causes of churn.

This project presents a comprehensive, end-to-end churn analysis solution using Excel, PostgreSQL, and Power BI. By analysing customer behaviours and service usage patterns, we uncover key churn drivers and build an interactive dashboard to help the Customer Success Leadership Team make informed decisions and target high-risk customer segments more effectively.
## Business Problem
Customer churn directly impacts revenue, customer acquisition cost, and lifetime value. However, the company lacks:
- Real-time insights into which customer segments are churning the most
- Understanding of how churn correlates with contract type, tenure, services, or payment method
- Tools to support proactive, data-driven retention campaigns

As a result, retention efforts are reactive and inefficient.
## Project Objective
The objective of this project is to design a churn analysis dashboard that enables:
- Tracking of overall churn rate and segment-wise churn patterns
- Deeper understanding of customer behaviours associated with churn
- Identification of high-risk segments for targeted retention
- Empowerment of decision-makers to act quickly using visual, filterable insights

This solution leverages SQL and DAX calculations to generate KPIs, segment views, and trends that inform strategic interventions.
## Key Metrics & KPIs
### Churn 
- Overall churn rate (%)
- Churn by contract type (month-to-month, one year, two year)
- Monthly charges vs churn rate
- Internet service type vs churn rate


  
### Risk Segmentation
- High-risk customer count by segment
- Churn by tenure group (0–6 months, 7–12 months, 1+ years)
- Manual vs auto payment method churn


  
### Customer Profile Analysis
- Impact of senior citizen status, partner status, and dependents on churn
- Churn likelihood based on services subscribed
- Gender-based churn patterns


  
### Retention Opportunities
- Top factors influencing churn (e.g., contract type, fiber internet, billing method)
- Churn-prone customers based on tenure or charges
- Suggestions for retention campaigns (e.g., discounts, service upgrades)

# Tools & Workflow
This project was executed using a structured 3-phase workflow across Excel, PostgreSQL, and Power BI — each tool serving a specific purpose in the data analytics lifecycle.
## Excel: Data Cleaning & Exploration
### Purpose:
To perform initial data cleaning, formatting, and exploratory analysis before moving into advanced querying.
### Tasks Completed:
- Identified and handled blank, inconsistent, and incorrectly formatted values.
- Converted data types: e.g., Monthly Charges and Total Charges set as numeric.
- Created a Tenure Group column (e.g., "0–6 months", "7–12 months", "1+ years") for segmentation.
- Renamed ambiguous columns for clarity (e.g., tenure → tenure_months).
- Created pivot tables and charts to:
  - Calculate overall churn rate
  - Analyse churn by contract, internet service, and payment method
  - Explore average tenure and charges of churned vs retained customers
- Used histograms to identify outliers in Monthly Charges and Tenure.

## PostgreSQL: SQL Analysis
### Purpose:
To answer complex business questions through segmentation, grouping, ranking, and filtering logic.
### Tasks Completed:
- Imported the cleaned Excel data into a PostgreSQL database.
- Wrote SQL queries to answer questions such as:
  - What is the churn rate by contract type, internet service, and payment method?
  - Which tenure groups have the highest churn?
  - Which segments show the highest revenue loss?
  - How do service subscriptions correlate with churn?
- Used CASE, GROUP BY, CTEs, and WINDOW FUNCTIONS for advanced segmentation.
- Prepared clean, query-ready datasets for Power BI consumption.

## Power BI: Dashboard Development
### Purpose:
To visualise churn insights and enable interactive data exploration for business users.
### Tasks Completed:
- Imported SQL output tables into Power BI.
- Created DAX measures for key KPIs:
  - Overall Churn Rate
  - Average Monthly Charges (Churned vs Retained)
  - Total Revenue
- Built visuals including:
  - KPI Cards for summary insights
  - Bar Charts for churn by segments (contract, internet service, payment method)
  - Stacked Column and Donut Chart for churn by trend (tenure group, senior citizen)
  - Slicers for interactive filtering by demographics, service type, and payment method
- Enabled drill-down and tooltip features for exploratory analysis.

# Data Collection
## Source
The dataset used for this project is the Telco Customer Churn dataset from Kaggle. It simulates customer activity for a fictional telecommunications company and is widely used in churn prediction case studies.
## Structure & Format
The dataset was originally provided in CSV and Excel format and contains detailed information on:
- Customer Demographics
  - CustomerID, Gender, SeniorCitizen, Partner, Dependents
- Account Information
  - Tenure, Contract, PaperlessBilling, PaymentMethod
- Services Subscribed
  - PhoneService, MultipleLines, InternetService, OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies
- Financial Metrics
  - MonthlyCharges, TotalCharges
- Target Variable
  - Churn (Yes/No)

# Data Preparation
## Data Types & Formatting
Before importing into PostgreSQL, the dataset was cleaned and structured in Excel to ensure consistency and compatibility. The following preparation steps were taken:
### Data Type Corrections
| Column | Original Format | Final Format | Reason|
| --- | --- | --- | --- |
| tenure | General | Number (Renamed to teneure_months) | For numerical calculations & grouping |
| monthly charges | General | Number (Renamed monthly_charges) | Required for aggregations (AVG, SUM) |
| total charges | General | Number (Renamed total_charges after blanks replaced) | Ensures consistency in churn/lifetime value analysis |
| senior citizen | Numeric (0/1) | Categorical (Yes/No) | Enhanced interpretability |
| churn | General | Categorical (Yes/No) | Used for filtering and conditional calculations |
### Cleaning & Enrichment Steps
- Handled Missing Values:
  - Verified that no critical fields were null
- Standardised Categories:
 - Removed white spaces and case mismatches in text fields
- Created Tenure Groups:
  - Added a derived column tenure_group for churn segmentation:
    - 0–6 months, 7–12 months, 1+ years
- Renamed Columns:
  - Changed ambiguous names (e.g., tenure → tenure_months) for clarity during SQL queries and DAX formulas
- Validated Data Types in SQL:
  - Ensured correct type mapping upon import (e.g., numeric, text, boolean)

# SQL Analysis
## Business Questions Answered
After importing the cleaned dataset into PostgreSQL, several SQL queries were executed to explore and analyse churn behavior across various dimensions. Below are the key business questions addressed along with how they were solved:
- What is the churn rate segmented by contract type, internet service, and payment method?
``` sql

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

```
![Image Failed to Load](assets/images/Churn_Rate_by_Segment_Sol_1.png)

- How does churn vary by customer tenure groups (e.g., 0-6 months, 7-12 months, 1+ years)?
``` sql

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

```
![Image Failed to Load](assets/images/Churn_Rate_by_Tenure_Group_Sol_2.png)

- Which customer segments have the highest churn counts and rates?
``` sql

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

```
![Image Failed to Load](assets/images/Churn_Rate_Rank_by_Segment_Sol_3.png)

- Can I calculate customer lifetime value (CLTV) or average revenue per user (ARPU) by segment?
``` sql

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

```
![Image Failed to Load](assets/images/CLTV_Sol_4.png)

- What is the correlation between monthly charges and churn (using window functions or ranking)?
``` sql

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

```
![Image Failed to Load](assets/images/Monthly_Charges_and_Churn_Sol_5.png)

- Which customers have multiple services and are they more or less likely to churn?
``` sql

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

```
![Image Failed to Load](assets/images/Churn_Probability_Sol_6.png)

-  How many customers are churned versus active by region or demographic group?
``` sql

SELECT 
	gender, senior_citizen, partner, dependents,
	COUNT(customer_id) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(customer_id), 2) AS churn_rate_percentage
FROM telco_churn
GROUP BY gender, senior_citizen, partner, dependents
ORDER BY churn_rate_percentage DESC;

```
![Image Failed to Load](assets/images/Churn_vs_Active_Sol_7.png)

- Can I generate datasets for “high-risk” customers based on churn probability thresholds?
``` sql

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

```
![Image Failed to Load](assets/images/High_Risk_Customers_Sol_8.png)

# DAX Calculations
## Core Measures
| Measure | DAX Formula | Purpose |
| --- | --- | --- |
| Total Customers | Total Customers = COUNT(telco_churn[customer_id]) | Count of unique customers |
| Churned Customers | Churned Customers = CALCULATE(COUNT(telco_churn[customer_id]), telco_churn[churn] = "Yes") | Total number of churned customers |
| Churn Rate % | Churn Rate % = DIVIDE([Churned Customers], [Total Customers], 0) | Proportion of churned customers |
| Average Monthly Charges | Avg Monthly Charges = AVERAGE(telco_churn[monthly_charges]) | Overall average biling |
| Average Tenure | Avg Tenure = AVERAGE(telco_churn[tenure_months]) | Used to compare churned vs retained |
| Avg Charges (Chruned) | Avg Charges (Churned) = CALCULATE(AVERAGE(telco_churn[monthly_charges]), telco_churn[churn] = "Yes") | Avg. charges for churned customers |
Avg Charges (Retained) | Avg Charges (Retained) = CALCULATE(AVERAGE(telco_churn[monthly_charges]), telco_churn[churn] = "No") | Avg. charges for retained customers |

# Dashboard Design
The Power BI dashboard was designed to provide leadership and the Customer Success team with real-time visibility into churn trends, high-risk segments, and customer behavior patterns. It enables data-driven decisions through clear, interactive visuals.
## Visuals Used
| Visual | Purpose |
| --- | --- |
| KPI Cards | Display overall churn rate and  number of churrned customers |
| Bar Chart | Show churn rate by contract type, payment method, and internet service; churn rate by partner and dependents |
| Stacked Column Chart | Compare churn vs retained customers by tenure group |
| Donut Chart | Show churn rate by senior citizen |
| Slicer | Allow users to filter dashbaord by contract type, payment method, internet service, tenure group, churrned customers, dependants, senior citizen, gender |
## User Interaction & Features
- Slicers & Filters:
  - Enable filtering by contract, payment method, internet type, demographic segments (senior citizen, partner, dependents)
- Drill-Down Interactivity:
  - Allows users to click into visuals to explore customer subgroups with high churn
- Tooltips:
  - Hover-over info reveals specific customer counts and churn rates for each segment

![Image Failed to Load](assets/images/Telco_Customer_Churn_Dashboard.jpg)

# Key Insights
This section highlights the most important patterns, discoveries, and strategic takeaways from the analysis.
## Trend Identified
- High Churn Among Month-to-Month Contracts
  - Customers on month-to-month contracts show the highest churn rate by far — indicating a lack of long-term commitment.
- Fiber Optic Internet Users Are More Likely to Churn
  - Despite offering faster speeds, fiber optic users churn more than DSL or customers without internet service, suggesting possible dissatisfaction or pricing concerns.
- Manual Payment Methods Have Higher Churn
  - Customers who pay via electronic check churn significantly more than those using automatic payments (e.g., bank transfer, credit card).
- Short Tenure = High Risk
  - Customers within their first 6 months are far more likely to churn, especially if they also have month-to-month contracts.
- Add-On Services Help Retain Customers
  - Users with services like online security, device protection, and tech support are less likely to churn — bundled offerings appear to improve retention.
- Demographics: Senior Citizens Churn Slightly More
  - Senior citizens and customers without partners or dependents are marginally more prone to churn, suggesting opportunity for more personalised engagement.

# Recommendations
- Incentivise Long-Term Contracts
  - Offer discounts or bundled packages for 1–2 year contracts to move customers away from month-to-month.
- Encourage AutoPay Adoption
  - Introduce incentives for customers to use automatic payment methods, which correlate with lower churn.
- Improve Onboarding for New Customers
  - Focus retention efforts on customers in their first 6 months through welcome campaigns, check-ins, and satisfaction surveys.
- Bundle Add-On Services
  - Create value-based bundles including tech support, online backup, and device protection to increase stickiness.
- Target High-Risk Segments with Campaigns
  - Use churn models or segmentation logic to identify and prioritise outreach to fiber optic + month-to-month + manual pay customers.
- Explore Pricing or Service Quality Issues
  - Investigate whether higher churn among fiber optic users is due to cost, reliability, or unmet expectations.














