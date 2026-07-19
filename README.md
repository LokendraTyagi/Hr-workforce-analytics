# HR Workforce Analytics Dashboard

End-to-end HR analytics project built on a 1,000-employee dataset — cleaned in Excel, queried in SQL, analyzed in Python, and visualized in Power BI and Tableau. The goal was simple: figure out where the company was actually losing people, and why.

## Why this project

Attrition is expensive, but most companies only look at the headline number. I wanted to go one level deeper — not just "what's the attrition rate," but "which departments, which experience bands, and what behavior (leaves, overtime, rating) actually correlates with someone leaving."

## Tools used

| Tool | What it was used for |
|---|---|
| Excel | Initial data cleaning, structuring, pivot summaries |
| SQL (SQLite) | 15+ queries — aggregations, `CASE WHEN` logic, `RANK()` window functions |
| Python (Pandas, Matplotlib) | Statistical summaries, binning (age/experience bands), chart generation |
| Power BI | Interactive dashboard — headcount, attrition, pay bands |
| Tableau | Parallel dashboard build for cross-tool comparison |

## Dataset

1,000 employee records with fields including `Department`, `Designation_Level`, `Designation_Title`, `Monthly_Salary`, `Annual_CTC`, `Age`, `Gender`, `Experience_Years`, `Performance_Rating`, `Attrition`, `Leaves_Taken`, `Overtime_Hours`, `Join_Date`, `State`, `Manager_Name`, `Education`.

## Key findings

- **Overall attrition rate: 17.6%** (176 of 1,000 employees) — used as the baseline to compare every department against.
- Department-wise attrition varied noticeably from the average, flagging specific teams as higher-risk for retention.
- Comparing attrited vs. retained employees on **rating, leaves taken, and overtime hours** showed attrition wasn't just about pay — behavioral signals (overtime load, leave patterns) told part of the story too.
- Designation-level pay bands and gender-wise salary comparison were built to check for structural pay gaps.
- Manager-wise team size and average rating, ranked with SQL `RANK()`, surfaced which managers were running the largest and best-performing teams.

## Analysis breakdown (SQL queries included)

1. Headline KPIs (headcount, attrition rate, avg salary, avg rating)
2. Monthly new-hire trend
3. Department-wise headcount and average CTC
4. State-wise headcount
5. Designation-level average salary
6. Employment type split (%)
7. Manager-wise team size and rating (ranked)
8. Attrition by department (sorted by rate)
9. Performance rating distribution
10. Gender pay comparison
11. Age group analysis
12. Experience band analysis
13. Attrited vs. retained comparison (rating, leaves, overtime)
14. Top designation title per department
15. Education-wise headcount and average salary

## Repo structure

```
hr-workforce-analytics/
├── HR_Employee_Data_Raw.xlsx        # Raw dataset
├── hr_sql_analysis.sql              # All 15 SQL queries
├── hr_python_analysis.py            # Pandas + Matplotlib analysis and chart export
├── hr_python_analysis_charts.png    # Generated chart grid (hiring trend, headcount, attrition)
├── HR_Dashboard.pbix                # Power BI dashboard
├── HR_Dashboard.twbx                # Tableau dashboard
└── README.md
```

## What I'd do next

Add a simple logistic regression in Python to predict attrition probability per employee, and compare which features (rating, overtime, tenure) actually carry the most predictive weight — right now the analysis is descriptive, not predictive.
