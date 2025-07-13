# Churn-Analysis-Dashboard




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
  - [Time Intelligence](#time-intelligence)
- [Dashboard Design](#dashboard-design)
  - [Visuals Used](#visuals-used)
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
## Excle: Data Cleaning & Exploration
### Purpose:
To perform initial data cleaning, formatting, and exploratory analysis before moving into advanced querying.
### Tasks Completed:
- Identified and handled blank, inconsistent, and incorrectly formatted values.
- Converted data types: e.g., Monthly Charges and Total Charges set as numeric.
- Created a Tenure Group column (e.g., "0–6 months", "7–12 months", "1+ years") for segmentation.
- Renamed ambiguous columns for clarity (e.g., tenure → tenure_months).
- Created pivot tables and charts to:
  - Calculate overall churn rate
  - Analyze churn by contract, internet service, and payment method
  - Explore average tenure and charges of churned vs retained customers
- Used histograms and conditional formatting to identify outliers in Monthly Charges and Tenure.
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
- Used CASE, GROUP BY, JOIN, and WINDOW FUNCTIONS (e.g., RANK, LAG) for advanced segmentation.
- Prepared clean, query-ready datasets for Power BI consumption.
## Power BI: Dashboard Development
### Purpose:
To visualize churn insights and enable interactive data exploration for business users.
### Tasks Completed:
- Imported SQL output tables into Power BI and built a star schema model.
- Created DAX measures for key KPIs:
  - Overall Churn Rate
  - Churn Rate by Segment
  - Average Monthly Charges (Churned vs Retained)
- Built visuals including:
  - KPI Cards for summary insights
  - Bar Charts for churn by category (contract, internet service)
  - Heatmaps and Stacked Columns for layered churn trends
  - Slicers for interactive filtering by demographics, service type, and payment method
- Enabled drill-down and tooltip features for exploratory analysis.

# Data Collection
## Source
The dataset used for this project is the Telco Customer Churn dataset from Kaggle. It simulates customer activity for a fictional telecommunications company and is widely used in churn prediction case studies.
## Structure & Format
The dataset was originally provided in CSV and Excel format and contains detailed information on:
- Customer Demographics
  - customerID, gender, SeniorCitizen, Partner, Dependents
- Account Information
  - tenure, Contract, PaperlessBilling, PaymentMethod
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
| tenure













