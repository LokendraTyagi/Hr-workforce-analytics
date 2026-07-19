-- ============================================================
-- HR Workforce Analytics — Analysis Queries (MySQL Workbench)
-- Run hr_mysql_schema_and_data.sql FIRST to create the database and load data.
-- Then run these queries against the `hr_analytics` database.
-- ============================================================

USE hr_analytics;

-- 1. HEADLINE KPIs
SELECT
    COUNT(*)                                          AS total_employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)  AS total_attrition,
    ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END) / COUNT(*), 4) AS attrition_rate,
    ROUND(AVG(Monthly_Salary), 0)                     AS avg_monthly_salary,
    ROUND(AVG(Annual_CTC), 0)                         AS avg_annual_ctc,
    ROUND(AVG(Age), 1)                                AS avg_age,
    ROUND(AVG(Performance_Rating), 2)                 AS avg_rating,
    ROUND(AVG(Experience_Years), 1)                   AS avg_experience
FROM employees;

-- 2. MONTHLY NEW HIRES TREND
SELECT
    MONTH(Join_Date)              AS month_num,
    COUNT(*)                      AS new_hires,
    ROUND(AVG(Monthly_Salary), 0) AS avg_starting_salary
FROM employees
GROUP BY month_num
ORDER BY month_num;

-- 3. DEPARTMENT-WISE HEADCOUNT & AVG CTC
SELECT
    Department,
    COUNT(*)                    AS headcount,
    ROUND(AVG(Annual_CTC), 0)   AS avg_ctc,
    ROUND(AVG(Performance_Rating), 2) AS avg_rating
FROM employees
GROUP BY Department
ORDER BY headcount DESC;

-- 4. STATE-WISE HEADCOUNT
SELECT
    State,
    COUNT(*) AS headcount
FROM employees
GROUP BY State
ORDER BY headcount DESC;

-- 5. DESIGNATION LEVEL — AVG SALARY
SELECT
    Designation_Level,
    COUNT(*)                      AS headcount,
    ROUND(AVG(Monthly_Salary), 0) AS avg_salary
FROM employees
GROUP BY Designation_Level
ORDER BY avg_salary DESC;

-- 6. EMPLOYMENT TYPE SPLIT
SELECT
    Employment_Type,
    COUNT(*) AS headcount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 1) AS pct_of_total
FROM employees
GROUP BY Employment_Type
ORDER BY headcount DESC;

-- 7. MANAGER-WISE TEAM SIZE & AVG RATING (ranked)
SELECT
    Manager_Name,
    COUNT(*)                          AS team_size,
    ROUND(AVG(Performance_Rating), 2) AS avg_rating,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS size_rank
FROM employees
GROUP BY Manager_Name;

-- 8. ATTRITION BY DEPARTMENT
SELECT
    Department,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition_count,
    COUNT(*) AS headcount,
    ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END) / COUNT(*), 4) AS attrition_rate
FROM employees
GROUP BY Department
ORDER BY attrition_rate DESC;

-- 9. PERFORMANCE RATING DISTRIBUTION
SELECT
    Performance_Rating,
    COUNT(*) AS employees_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 1) AS pct_of_total
FROM employees
GROUP BY Performance_Rating
ORDER BY Performance_Rating;

-- 10. GENDER PAY GAP
SELECT
    Gender,
    COUNT(*)                          AS headcount,
    ROUND(AVG(Monthly_Salary), 0)     AS avg_salary,
    ROUND(AVG(Performance_Rating), 2) AS avg_rating
FROM employees
GROUP BY Gender;

-- 11. AGE GROUP ANALYSIS
SELECT
    CASE
        WHEN Age BETWEEN 22 AND 30 THEN '22-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51-58'
    END AS age_group,
    COUNT(*) AS headcount,
    ROUND(AVG(Monthly_Salary), 0) AS avg_salary
FROM employees
GROUP BY age_group
ORDER BY age_group;

-- 12. EXPERIENCE BAND ANALYSIS
SELECT
    CASE
        WHEN Experience_Years BETWEEN 0 AND 5 THEN '0-5 yrs'
        WHEN Experience_Years BETWEEN 6 AND 10 THEN '6-10 yrs'
        WHEN Experience_Years BETWEEN 11 AND 20 THEN '11-20 yrs'
        ELSE '21-30 yrs'
    END AS experience_band,
    COUNT(*) AS headcount,
    ROUND(AVG(Monthly_Salary), 0) AS avg_salary
FROM employees
GROUP BY experience_band
ORDER BY experience_band;

-- 13. ATTRITED vs RETAINED — RATING COMPARISON
SELECT
    Attrition,
    COUNT(*)                          AS headcount,
    ROUND(AVG(Performance_Rating), 2) AS avg_rating,
    ROUND(AVG(Leaves_Taken), 1)       AS avg_leaves,
    ROUND(AVG(Overtime_Hours), 1)     AS avg_overtime
FROM employees
GROUP BY Attrition;

-- 14. TOP DESIGNATION TITLE PER DEPARTMENT (highest headcount)
SELECT Department, Designation_Title, headcount FROM (
    SELECT
        Department, Designation_Title,
        COUNT(*) AS headcount,
        RANK() OVER (PARTITION BY Department ORDER BY COUNT(*) DESC) AS rnk
    FROM employees
    GROUP BY Department, Designation_Title
) ranked
WHERE rnk = 1;

-- 15. EDUCATION-WISE HEADCOUNT & AVG SALARY
SELECT
    Education,
    COUNT(*) AS headcount,
    ROUND(AVG(Monthly_Salary), 0) AS avg_salary
FROM employees
GROUP BY Education
ORDER BY avg_salary DESC;
