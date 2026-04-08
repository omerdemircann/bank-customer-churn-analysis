# 🏦 Bank Customer Churn Analysis: A Product Engineering Perspective

## 📌 Project Overview
This project investigates the hidden drivers of bank customer churn using SQL. The primary objective is to approach the dataset not just as a database developer, but as a **Product Engineer and Data Scientist**. By querying the data, this project uncovers critical flaws in the bank's cross-selling strategy, identifies User Experience (UX) gaps for specific demographics, and highlights localized market failures in Europe. 

The ultimate goal is to transform raw database rows into actionable product strategies.

## 🗄️ Dataset
- **Source:** [Kaggle - Bank Customer Churn Dataset](https://www.kaggle.com/datasets/mathchi/churn-for-bank-customers)
- **Size:** 10,000 rows, 14 columns
- **Domain:** Fintech, Retail Banking, Product Analytics

## 🛠️ Tech Stack
- **Database:** MySQL
- **Techniques Used:** Data Aggregation (`GROUP BY`), Conditional Logic (`CASE WHEN`), Multi-dimensional Analysis, Mathematical Operations.

---

## 🚀 Business Insights & SQL Implementation

### 1. The Cross-Sell Paradox
**Hypothesis:** Customers holding more products are more loyal to the bank.  
**Reality:** The data proves the exact opposite.

- **Product Insight:** Customers using 3 or 4 products exhibit abnormally high churn rates (approx. 82% and 100%, respectively). This severe drop-off suggests a critical failure in the product architecture. It may indicate a poor UI/UX when managing multiple accounts simultaneously, the existence of frustrating hidden fees, or aggressive, non-user-centric upselling tactics by the bank.

<details>
<summary><b>View SQL Query</b></summary>

```sql
-- BUSINESS QUESTION 1: How does the number of products a customer uses impact their churn rate?
SELECT 
    NumOfProducts,
    COUNT(CustomerId) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(CustomerId)) * 100, 2) AS Churn_Rate_Percentage
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

2. Demographics and UX/UI Disconnect

Hypothesis: Younger generations are more agile and likely to switch banks frequently.

Reality: The highest churn rate is heavily concentrated in the 51-60+ age groups.

Product Insight: The digital product (mobile app/web platform) is likely failing older demographics. The interface might be overly complex, lacking intuitive navigation or accessible design (e.g., small fonts). To mitigate this, the Product Development team should strongly consider introducing an "Easy Mode" interface or a dedicated digital concierge service specifically tailored for the 50+ user segment.

<details>
<summary><b>View SQL Query</b></summary>


-- BUSINESS QUESTION 2: Is there a specific age group that is more likely to churn?
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 30 THEN '1. 18-30 Years'
        WHEN Age BETWEEN 31 AND 40 THEN '2. 31-40 Years'
        WHEN Age BETWEEN 41 AND 50 THEN '3. 41-50 Years'
        WHEN Age BETWEEN 51 AND 60 THEN '4. 51-60 Years'
        ELSE '5. 60+ Years'
    END AS Age_Group,
    COUNT(CustomerId) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(CustomerId)) * 100, 2) AS Churn_Rate_Percentage
FROM bank_churn
GROUP BY Age_Group
ORDER BY Age_Group;

</details>

3. Market Localization Failure

Hypothesis: Churn is distributed evenly across European regions and genders.

Reality: Female customers in Germany are churning at a significantly higher rate than any other segment.

Product Insight: This indicates a localized product-market fit issue. The bank may be facing an aggressive local Fintech competitor in Germany that targets female demographics more effectively. Alternatively, the bank's marketing localization and specific financial products in the German market might be failing to resonate with or build trust among female users.

<details>
<summary><b>View SQL Query</b></summary>


-- BUSINESS QUESTION 3: How do geography and gender combined affect the churn rate?
SELECT 
    Geography,
    Gender,
    COUNT(CustomerId) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(CustomerId)) * 100, 2) AS Churn_Rate_Percentage
FROM bank_churn
GROUP BY Geography, Gender
ORDER BY Churn_Rate_Percentage DESC;

How to Run This Project
Clone this repository to your local machine.

Download the dataset from the Kaggle link provided above.

Open your SQL environment (e.g., MySQL Workbench).

Create the schema and load the data using the following setup script:


CREATE DATABASE churn_project;
USE churn_project;

CREATE TABLE bank_churn (
    RowNumber INT,
    CustomerId INT,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15,2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary DECIMAL(15,2),
    Exited INT
);

-- Remember to adjust the file path below according to your local machine
LOAD DATA LOCAL INFILE '/path/to/your/Churn_Modelling.csv'
INTO TABLE bank_churn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
Execute the analysis queries provided in the insights section to view the results.

Designed to bridge the gap between raw data and product strategy.
