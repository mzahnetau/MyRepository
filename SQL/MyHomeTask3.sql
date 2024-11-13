--Таблицы
--Person.Person
--HumanResources.Employee
--HumanResources.Department

--Задание
--В базе данных компании хранятся таблицы с информацией о сотрудниках и их департаментах. 
--Ваша задача — выполнить следующие действия:

--Создать табличную переменную для хранения сотрудников, проработавших в компании более заданного количества лет.
--Извлечь уникальные записи об этих сотрудниках и заполнить табличную переменную.
--Используя табличную переменную, выполнить анализ и вывести департаменты с наибольшим числом таких сотрудников.
--Определить департаменты с менее чем 5 сотрудниками и отметить их специальным флагом.
--Добавить нового сотрудника в таблицу сотрудников с использованием данных о департаменте.
--Выполнить запрос, объединяющий таблицы сотрудников и департаментов, с применением CASE, GROUP BY, ORDER BY, и фильтров.

DECLARE @MinYears INT = 4;
DECLARE @OurEmployees TABLE (
    BusinessEntityID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentID INT
);

--Извлечь уникальные записи об этих сотрудниках и заполнить табличную переменную
INSERT INTO @OurEmployees
SELECT DISTINCT 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName,
    ed.DepartmentID
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON p.BusinessEntityID = e.BusinessEntityID
JOIN 
    HumanResources.EmployeeDepartmentHistory ed ON e.BusinessEntityID = ed.BusinessEntityID
WHERE 
    DATEDIFF(YEAR, ed.StartDate, GETDATE()) > @MinYears;

--Выполнить анализ и вывести департаменты с наибольшим числом сотрудников, проработавших более заданного количества лет
SELECT 
    d.Name AS DepartmentName,
    COUNT(oe.BusinessEntityID) AS EmployeeCount
FROM 
    @OurEmployees oe
JOIN 
    HumanResources.Department d ON d.DepartmentID = oe.DepartmentID
GROUP BY 
    d.Name
ORDER BY 
    EmployeeCount DESC;
