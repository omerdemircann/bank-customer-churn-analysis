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
LOAD DATA LOCAL INFILE '/Users/omerdemircan/Desktop/churn.csv'
INTO TABLE bank_churn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- BUSINESS QUESTION 1: How does the number of products a customer uses impact their churn rate?
-- Hypothesis: Customers using more products are more engaged and less likely to leave.

SELECT 
    NumOfProducts,
    COUNT(CustomerId) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(CustomerId)) * 100, 2) AS Churn_Rate_Percentage
FROM bank_churn
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- BUSINESS QUESTION 2: Is there a specific age group that is more likely to churn?
-- Hypothesis: Younger customers might switch banks easily, while older customers are more loyal. Let's test this.

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

-- BUSINESS QUESTION 3: How do geography and gender combined affect the churn rate?
-- Hypothesis: Cultural and regional differences, along with gender, might reveal hidden churn patterns in the European market.

SELECT 
    Geography,
    Gender,
    COUNT(CustomerId) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(CustomerId)) * 100, 2) AS Churn_Rate_Percentage
FROM bank_churn
GROUP BY Geography, Gender
ORDER BY Churn_Rate_Percentage DESC;

