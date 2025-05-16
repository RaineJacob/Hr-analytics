-- ========================================
-- EMPLOYEE ATTRITION ANALYSIS (SQL REPORT)
-- ========================================

-- SECTION 1: Overall Attrition Rate
SELECT
	COUNT(*) AS TotalEmployees,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees;

-- SECTION 2: Attrition by Department
SELECT 
	COUNT(*) AS TotalEmployees,
	Department,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY Department
ORDER BY AttritionRate DESC;

-- SECTION 3: Attrition by Job Role
SELECT 
	COUNT(*) AS TotalEmployees,
	JobRole,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY JobRole
ORDER BY AttritionRate DESC;

-- SECTION 4: Attrition Based on Years at Company
SELECT 
	COUNT(*) AS TotalEmployees,
	YearsAtCompany,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany DESC;

-- SECTION 5: Average Monthly Income by Job Role
SELECT 	
	JobRole,
	ROUND(AVG(MonthlyIncome), 2) AS AvgIncome
FROM Employees
GROUP BY JobRole
ORDER BY AvgIncome DESC;

-- SECTION 6: Key Drivers of Attrition (Multi-Factor Breakdown)
SELECT
	BusinessTravel,
	OverTime,
	JobRole,
	MaritalStatus,
	EducationField,
	COUNT(*) AS TotalEmployees,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY BusinessTravel, OverTime, JobRole, MaritalStatus, EducationField
HAVING COUNT(*) > 10
ORDER BY AttritionRate DESC;

-- SECTION 7: Work-Life Balance vs Attrition
SELECT 
	WorkLifeBalance,
	COUNT(*) AS TotalEmployees,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY WorkLifeBalance
ORDER BY AttritionRate DESC;

-- SECTION 8: Total Working Years Distribution
SELECT 
	TotalWorkingYears,
	COUNT(*) AS Employees
FROM Employees
GROUP BY TotalWorkingYears
ORDER BY TotalWorkingYears;

-- SECTION 9: Most Common Job Roles
SELECT TOP 5
	JobRole,
	COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY JobRole
ORDER BY TotalEmployees DESC;

-- SECTION 10: Income Bracket vs Attrition
SELECT
	CASE 
		WHEN MonthlyIncome < 3000 THEN 'Low'
		WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
		ELSE 'High'
	END AS IncomeBracket,
	COUNT(*) AS TotalEmployees,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY 
	CASE 
		WHEN MonthlyIncome < 3000 THEN 'Low'
		WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium'
		ELSE 'High'
	END
ORDER BY AttritionRate DESC;

-- SECTION 11: Training & Development Effectiveness
SELECT 
	TrainingTimesLastYear,
	AVG(PerformanceRating) AS AvgPerformance,
	COUNT(*) AS Employees
FROM Employees
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear;

-- SECTION 12: Promotion vs Attrition Rate
SELECT 
	YearsInCurrentRole,
	YearsSinceLastPromotion,
	COUNT(*) AS TotalEmployees,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY YearsInCurrentRole, YearsSinceLastPromotion
ORDER BY AttritionRate DESC;

-- SECTION 13: Current Manager Relationship vs Attrition
SELECT 
	YearsInCurrentRole,
	yearswithCurrmanager,
	COUNT(*) AS TotalEmployees,
	SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) AS EmployeesLeft,
	ROUND(SUM(CASE WHEN Attrition = '1' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRate
FROM Employees
GROUP BY YearsInCurrentRole, yearswithCurrmanager
ORDER BY AttritionRate DESC;

-- SECTION 14: Churn Risk Index (Custom Rule-Based)
-- Identifies employees with multiple attrition risk factors
SELECT 
	EmployeeNumber,
	OverTime,
	WorkLifeBalance,
	YearsSinceLastPromotion,
	MonthlyIncome,
	CASE 
		WHEN OverTime = 1 AND WorkLifeBalance = 1 AND YearsSinceLastPromotion >= 3 AND MonthlyIncome < 3000 THEN 'High Risk'
		WHEN OverTime = 1 AND WorkLifeBalance <= 2 THEN 'Medium Risk'
		ELSE 'Low Risk'
	END AS ChurnRiskCategory
FROM Employees;
