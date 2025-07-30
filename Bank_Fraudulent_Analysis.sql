create database bank_fraudulant_analysis
use bank_fraudulant_analysis

--Q1. Total transactions and frauds
SELECT 
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS Total_Frauds,
    ROUND(100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*), 4) AS Fraud_Percentage
FROM creditcard;

select * from creditcard

--Q2. Fraud count per hour
SELECT 
    FLOOR(Time / 3600) AS Hour_Block,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS Fraud_Count,
    ROUND(100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*), 4) AS Fraud_Rate
FROM creditcard
GROUP BY FLOOR(Time / 3600)
ORDER BY Fraud_Rate DESC;

Q3. Fraud % by amount bucket
Assume you want to group amounts as:

Low: < 100

Medium: 100–1000

High: > 1000


SELECT 
    CASE 
        WHEN Amount < 100 THEN 'Low'
        WHEN Amount BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS Amount_Bucket,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS Fraud_Count,
    ROUND(100.0 * SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) / COUNT(*), 4) AS Fraud_Rate
FROM creditcard
GROUP BY 
    CASE 
        WHEN Amount < 100 THEN 'Low'
        WHEN Amount BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY Fraud_Rate DESC;

--Q4. Top 10 highest fraud transactions

SELECT top 10 *
FROM creditcard
WHERE Class = 1
ORDER BY Amount DESC

 Q5. Compare overall vs fraud averages (V1 to V4)

 SELECT 
    ROUND(AVG(CASE WHEN Class = 1 THEN V1 ELSE NULL END), 4) AS V1_Fraud_Avg,
    ROUND(AVG(CASE WHEN Class = 0 THEN V1 ELSE NULL END), 4) AS V1_Legit_Avg,
    ROUND(AVG(CASE WHEN Class = 1 THEN V2 ELSE NULL END), 4) AS V2_Fraud_Avg,
    ROUND(AVG(CASE WHEN Class = 0 THEN V2 ELSE NULL END), 4) AS V2_Legit_Avg
FROM creditcard;

