
-- ============================================
-- E-COMMERCE CUSTOMER ANALYTICS PROJECT
-- Author: Nurbek Shavkatov
-- Date: February 2026

-- ============================================
-- SECTION 1: CUSTOMER SEGMENT ANALYSIS
-- ============================================

-- 1.1 Total customers
SELECT COUNT(*) as total_customers FROM ecommerce;

-- 1.2 Gender Analysis
SELECT 
    Gender,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(SUM(`Total Spend`), 2) as total_spend,
    ROUND(AVG(`Items Purchased`), 1) as avg_items
FROM ecommerce
GROUP BY Gender;

-- 1.3 City Analysis
SELECT 
    City,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(SUM(`Total Spend`), 2) as total_spend
FROM ecommerce
GROUP BY City
ORDER BY total_spend DESC;

-- 1.4 Age Group Analysis
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25 years'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35 years'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45 years'
        WHEN Age > 45 THEN '45+ years'
    END as age_group,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(SUM(`Total Spend`), 2) as total_spend
FROM ecommerce
GROUP BY age_group
ORDER BY avg_spend DESC;

-- 1.5 Membership Analysis
SELECT 
    `Membership Type`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(SUM(`Total Spend`), 2) as total_spend,
    ROUND(AVG(`Items Purchased`), 1) as avg_items,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive
FROM ecommerce
GROUP BY `Membership Type`
ORDER BY avg_spend DESC;

-- 1.6 Top 10 Customers
SELECT 
    `Customer ID`,
    Gender,
    Age,
    City,
    `Membership Type`,
    `Total Spend`,
    `Items Purchased`
FROM ecommerce
ORDER BY `Total Spend` DESC
LIMIT 10;

-- ============================================
-- SECTION 2: DISCOUNT IMPACT ANALYSIS
-- ============================================

-- 2.1 Overall Discount Impact
SELECT 
    `Discount Applied`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(AVG(`Items Purchased`), 1) as avg_items,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive,
    ROUND(AVG(`Average Rating`), 2) as avg_rating
FROM ecommerce
GROUP BY `Discount Applied`;

-- 2.2 Discount by Membership
SELECT 
    `Membership Type`,
    `Discount Applied`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive,
    ROUND(AVG(`Total Spend`), 2) as avg_spend
FROM ecommerce
GROUP BY `Membership Type`, `Discount Applied`
ORDER BY `Membership Type`, `Discount Applied` DESC;

-- 2.3 Loyalty Rate
SELECT 
    `Discount Applied`,
    COUNT(*) as total_customers,
    COUNT(CASE WHEN `Days Since Last Purchase` < 30 THEN 1 END) as active_customers,
    ROUND(
        (COUNT(CASE WHEN `Days Since Last Purchase` < 30 THEN 1 END) * 100.0) / COUNT(*), 
        1
    ) as loyalty_rate_percent
FROM ecommerce
GROUP BY `Discount Applied`;

-- ============================================
-- SECTION 3: SATISFACTION ANALYSIS
-- ============================================

-- 3.1 Satisfaction by Membership
SELECT 
    `Membership Type`,
    `Satisfaction Level`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive
FROM ecommerce
GROUP BY `Membership Type`, `Satisfaction Level`
ORDER BY `Membership Type`;

-- 3.2 Satisfaction by City
SELECT 
    City,
    `Satisfaction Level`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend
FROM ecommerce
GROUP BY City, `Satisfaction Level`
ORDER BY City;

-- 3.3 Satisfaction by Discount
SELECT 
    `Satisfaction Level`,
    `Discount Applied`,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_days_inactive
FROM ecommerce
GROUP BY `Satisfaction Level`, `Discount Applied`
ORDER BY `Satisfaction Level`;

-- ============================================
-- SECTION 4: CHURN RISK ANALYSIS
-- ============================================

-- 4.1 Churn Status
SELECT 
    CASE 
        WHEN `Days Since Last Purchase` < 15 THEN 'Active (0-15 days)'
        WHEN `Days Since Last Purchase` BETWEEN 15 AND 30 THEN 'At Risk (15-30 days)'
        WHEN `Days Since Last Purchase` > 30 THEN 'High Churn Risk (30+ days)'
    END as churn_status,
    COUNT(*) as customer_count,
    ROUND(AVG(`Total Spend`), 2) as avg_spend,
    ROUND(AVG(`Average Rating`), 2) as avg_rating
FROM ecommerce
GROUP BY churn_status;

-- 4.2 City-wise Churn Risk
SELECT 
    City,
    COUNT(*) as total_customers,
    COUNT(CASE WHEN `Days Since Last Purchase` > 30 THEN 1 END) as churn_risk_count,
    ROUND(
        (COUNT(CASE WHEN `Days Since Last Purchase` > 30 THEN 1 END) * 100.0) / COUNT(*), 
        1
    ) as churn_risk_percent,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_inactive_days
FROM ecommerce
GROUP BY City
ORDER BY churn_risk_percent DESC;

-- 4.3 High Churn Risk Customers
SELECT 
    `Customer ID`,
    Gender,
    Age,
    City,
    `Membership Type`,
    `Total Spend`,
    `Days Since Last Purchase`,
    `Satisfaction Level`
FROM ecommerce
WHERE `Days Since Last Purchase` > 30
ORDER BY `Days Since Last Purchase` DESC;

-- 4.4 Unsatisfied Customers
SELECT 
    `Customer ID`,
    Gender,
    Age,
    City,
    `Membership Type`,
    `Total Spend`,
    `Average Rating`,
    `Discount Applied`,
    `Days Since Last Purchase`
FROM ecommerce
WHERE `Satisfaction Level` = 'Unsatisfied'
ORDER BY `Average Rating` ASC;

-- ============================================
-- SECTION 5: SUMMARY STATISTICS
-- ============================================

-- 5.1 Overall KPIs
SELECT 
    COUNT(DISTINCT `Customer ID`) as total_customers,
    ROUND(SUM(`Total Spend`), 2) as total_revenue,
    ROUND(AVG(`Total Spend`), 2) as avg_customer_value,
    ROUND(AVG(`Days Since Last Purchase`), 1) as avg_inactive_days
FROM ecommerce;

-- 5.2 Satisfaction Breakdown
SELECT 
    `Satisfaction Level`,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / 350, 1) as percentage
FROM ecommerce
GROUP BY `Satisfaction Level`;

-- 5.3 Membership Breakdown
SELECT 
    `Membership Type`,
    COUNT(*) as customer_count,
    ROUND(SUM(`Total Spend`), 2) as total_spend,
    ROUND(AVG(`Total Spend`), 2) as avg_spend
FROM ecommerce
GROUP BY `Membership Type`
ORDER BY avg_spend DESC;
