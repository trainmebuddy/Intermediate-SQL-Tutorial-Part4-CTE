USE MyStoreDB
--CTE (Common Table Expression)
--GET 3RD HIGHEST PAID EMPLOYEE
WITH EmpSalaryCTE(FirstName,LastName,Salary,RN) AS
(
SELECT 
 FirstName
,LastName
,Salary
,DENSE_RANK() OVER(ORDER BY Salary DESC) RN
FROM Employee AS E
)
SELECT * 
FROM EmpSalaryCTE
WHERE RN=3

--NON-RECURSIVE CTE
--GET EMPLOYEE RECORDS WITH AVERAGE SALARY OF THEIR RESPECTIVE DEPARTMENT
WITH EmpDeptSalCTE (DepartmentID,DepartmentName,AvgSalary) AS
(
SELECT D.DepartmentID,D.DepartmentName, AVG(Salary) AvgSalary
FROM Employee AS E
INNER JOIN Department AS D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentID,D.DepartmentName
)
SELECT E.FirstName,E.LastName,E.Salary,D.AvgSalary
FROM Employee AS E
INNER JOIN EmpDeptSalCTE AS D 
ON E.DepartmentID = D.DepartmentID

--RECURSIVE CTE
--Get hierarchical employee org structure to find all the subordinates
WITH EmpOrgcte AS (
  SELECT EmployeeID, FirstName, ManagerID
  FROM Employee
  WHERE EmployeeID = 1 -- starting point
  UNION ALL
  SELECT e.EmployeeID, e.FirstName, e.ManagerID
  FROM Employee e
  JOIN EmpOrgcte cte ON e.ManagerID = cte.EmployeeID
)
SELECT EmployeeID, FirstName,ManagerID
FROM EmpOrgcte


--NESTED CTE
--GET EMPLOYEE RECORDS WITH AVERAGE SALARY OF THEIR RESPECTIVE DEPARTMENT
--AND TOTAL SALES BY EMPLOYEE
WITH EmpDeptSalCTE (DepartmentID,DepartmentName,AvgSalary) AS
(
SELECT D.DepartmentID,D.DepartmentName, AVG(Salary) AvgSalary
FROM Employee AS E
INNER JOIN Department AS D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentID,D.DepartmentName
),
SalesByEmp(EmployeeID,TotalSales) AS
(
SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
FROM Sales
GROUP BY EmployeeID
)
SELECT A.EmployeeID,A.FirstName,A.LastName,B.DepartmentName,A.Salary,B.AvgSalary,ISNULL(C.TotalSales,0) AS TotalSales
FROM Employee AS A
INNER JOIN EmpDeptSalCTE AS B 
ON A.DepartmentID = B.DepartmentID
LEFT JOIN SalesByEmp AS C ON A.EmployeeID = C.EmployeeID


--DROP TABLE [dbo].[AverageSalaryByDept]
--CTE WITH INSERT
--CREATE A TABLE WITH DEPARTMENT AVERAGE SALARY
WITH EmpDeptSalCTE (DepartmentID,DepartmentName,AvgSalary) AS
(
SELECT D.DepartmentID,D.DepartmentName, AVG(Salary) AvgSalary
FROM Employee AS E
INNER JOIN Department AS D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentID,D.DepartmentName
)
SELECT *
INTO AverageSalaryByDept
FROM EmpDeptSalCTE

SELECT * FROM AverageSalaryByDept

--CTE WITH UPDATE
--UPDATE BONUS OF 1K FOR THE EMPLOYEES WITH TOP 3 TOTAL SALES
WITH SalesByEmp(EmployeeID,TotalSales,RN) AS
(
SELECT 
 EmployeeID
,SUM(SalesAmount) AS TotalSales
,DENSE_RANK() OVER(ORDER BY SUM(SalesAmount) DESC) RN
FROM Sales
GROUP BY EmployeeID
)
UPDATE E SET E.Salary = E.Salary + 1000
--SELECT e.EmployeeID,e.Salary,E.Salary + 1000
FROM Employee AS E
INNER JOIN SalesByEmp AS S
ON E.EmployeeID = S.EmployeeID
WHERE S.RN<=3

SELECT * FROM Employee

--CTE WITH DELETE
WITH EmpCTE(EmployeeID,FirstName,RN) AS
(
SELECT 
 EmployeeID
,FirstName
,ROW_NUMBER() OVER(PARTITION BY EmployeeID ORDER BY EmployeeID) RN
FROM Employee
)
DELETE
--SELECT * 
FROM EmpCTE
WHERE RN>1