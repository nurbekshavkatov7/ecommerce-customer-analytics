-- E-Commerce Customer Analytics SQL Queries
-- Author: Nurbek Shavkatov
-- Date: February 2026

USE ecommerce_project;
-- 1. Gender Analysis
SELECT 
    Gender,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend
FROM ecommerce
GROUP BY Gender;

-- 2. City Analysis
SELECT 
    City,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend
FROM ecommerce
GROUP BY City
ORDER BY avg_spend DESC;

-- 3. Membership Analysis
SELECT 
    `Membership Type`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive
FROM ecommerce
GROUP BY `Membership Type`;

-- 4. Discount Impact
SELECT 
    `Discount Applied`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive
FROM ecommerce
GROUP BY `Discount Applied`;
