/* Напишите скрипт, который с помощью цикла и переменной выводит таблицу умножения для заданного числа.*/

DECLARE @OurNumber INT = 3;  
DECLARE @Counter INT = 1; 

PRINT 'Multiplication table for number ' + CAST(@OurNumber AS VARCHAR) + ':';

WHILE @Counter <= 10
BEGIN
    PRINT CAST(@OurNumber AS VARCHAR) + ' x ' + CAST(@Counter AS VARCHAR) + ' = ' + CAST(@OurNumber * @Counter AS VARCHAR);
    SET @Counter = @Counter + 1;
END


/*Таблицы: HumanResources.Employee
Описание задачи: С помощью переменной найдите всех сотрудников, 
которые работают в компании дольше заданного количества лет. */

DECLARE @MyVariable INT = 10; /* например 10 */

SELECT BusinessEntityID, HireDate
FROM HumanResources.Employee
WHERE YEAR(HireDate) <= YEAR(GETDATE()) - @MyVariable;


/*Таблицы: Sales.Customer, Sales.SalesOrderHeader
Описание задачи: Напишите запрос с переменной и подзапросом, чтобы найти всех клиентов, 
которые потратили в сумме больше заданной суммы на все свои заказы. */

DECLARE @TotalSpent INT;
SET @TotalSpent = 15000;

SELECT 
    c.CustomerID,
    SUM(soh.TotalDue) AS TotalAmountSpent
FROM 
    Sales.Customer c
JOIN 
    Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerID
HAVING 
    SUM(soh.TotalDue) > @TotalSpent
ORDER BY 
    c.CustomerID

/* Таблицы:
Sales.SalesOrderDetail
Sales.SalesOrderHeader
Production.Product
Описание задачи: Напишите запрос, который с использованием переменной 
и подзапроса определяет самый продаваемый товар (по количеству проданных единиц) для каждого года.*/

DECLARE @OurYear INT;
SET @OurYear = 2014;

SELECT 
    YEAR(soh.OrderDate) AS OrderYear,
    p.ProductID,
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold
FROM 
    Sales.SalesOrderDetail sod
JOIN 
    Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Production.Product p ON p.ProductID = sod.ProductID
WHERE 
    YEAR(soh.OrderDate) = @OurYear
GROUP BY 
    YEAR(soh.OrderDate), p.ProductID, p.Name
HAVING 
    SUM(sod.OrderQty) = (
        SELECT MAX(TotalQuantity) 
        FROM (
            SELECT 
                SUM(sod1.OrderQty) AS TotalQuantity
            FROM 
                Sales.SalesOrderDetail sod1
            JOIN 
                Sales.SalesOrderHeader soh1 ON soh1.SalesOrderID = sod1.SalesOrderID
            WHERE 
                YEAR(soh1.OrderDate) = @OurYear 
            GROUP BY 
                sod1.ProductID
        ) AS SubQuery 
    )
ORDER BY 
    TotalQuantitySold ASC;
