# Hr-analytics# 📊 Employee Attrition Analysis – SQL + Power BI

This project analyzes HR data to understand and visualize employee attrition trends using SQL and Power BI. It helps HR teams identify risk factors and create data-driven retention strategies.

---

## 🧩 Project Summary

- **Dataset**: IBM HR Analytics (1470 employees, 30+ features)
- **Tools Used**: SQL Server, Power BI, DAX
- **Focus Areas**:
  - Attrition by department, role, and income
  - Impact of overtime, promotions, and work-life balance
  - Custom churn risk scoring for HR decision-making

---

## 🔍 Key Insights

- 💼 Sales and R&D departments have the highest attrition rates (20%+)
- ⚠️ Employees with low income, frequent overtime, and no promotions in 3+ years are at high risk of leaving
- 🧘 Work-life balance and training investment impact employee retention

---

## 📁 Files Included

| File                                | Description                            |
|-------------------------------------|----------------------------------------|
| `Employee_Attrition_Analysis.sql`   | SQL queries for all insights           |
| `Employee_Attrition.pbix`           | Power BI dashboard (2 pages)           |
| `report.pdf` *(optional)*           | Project summary with screenshots       |
| `/images/*.png`                     | Screenshots of dashboards              |

---

## 📊 Dashboards

### 📌 Executive Summary
![Executive Dashboard](images/executive_dashboard.png)

### 📌 Deep Dive Dashboard
![Deep Dive Dashboard](images/attrition_deep_dive.png)

---

## 🛠 DAX Measures Used

```DAX
Employees Left = CALCULATE(COUNTROWS(Employees), FILTER(Employees, Employees[Attrition] = "Yes"))
Attrition Rate = DIVIDE([Employees Left], [Total Employees])
Income Bracket = SWITCH(TRUE(), [MonthlyIncome] < 3000, "Low", [MonthlyIncome] <= 7000, "Medium", "High")
