/* Подсчитайте общее количество заказов и среднюю сумму заказа по каждому году. 
Включите только те годы, где средняя сумма заказа превышает 2000. 
Добавьте категорию: "High Demand" для лет с более чем 500 заказами, "Medium Demand" 
для лет с 300-500 заказами и "Low Demand" для остальных. Укажите дату, количество заказов, 
среднюю сумму заказа и категорию.
Используйте таблицу Sales.SalesOrderHeader */

/* тут в результате покажет только категорию high demand, потому что, видимо, только такие значения есть */

SELECT 
    YEAR(OrderDate) AS Year,
    COUNT(SalesOrderID) AS OrderCount,
    AVG(TotalDue) AS AverageOrderAmount,
    CASE 
        WHEN COUNT(SalesOrderID) > 500 THEN 'High Demand'
        WHEN COUNT(SalesOrderID) BETWEEN 300 AND 500 THEN 'Medium Demand'
        ELSE 'Low Demand'
    END AS Category
FROM 
    Sales.SalesOrderHeader
GROUP BY 
    YEAR(OrderDate)
HAVING 
    AVG(TotalDue) > 2000; 



/* Найдите общую сумму продаж и средний процент скидки по каждой категории продукта. 
Выберите только категории, где общая сумма продаж превышает 50,000. 
Добавьте категорию: "Top Category" для категорий с суммой продаж более 200,000, 
"Mid Category" для категорий с суммой от 100,000 до 200,000 
и "Low Category" для всех остальных. 
Укажите категорию, общую сумму продаж, средний процент скидки и категорию уровня продаж.
Используйте таблицы Sales.SalesOrderDetail, Production.Product, Production.ProductSubcategory, и Production.ProductCategory. */

/* тут в результате покажет только категорию top category, как и в первой задаче */


SELECT 
    pc.Name AS ProductCategory,
    SUM(sod.LineTotal) AS TotalSales,
    AVG(sod.UnitPriceDiscount * 100) AS AverageDiscountPercent,
    CASE 
        WHEN SUM(sod.LineTotal) > 200000 THEN 'Top Category'
        WHEN SUM(sod.LineTotal) BETWEEN 100000 AND 200000 THEN 'Mid Category'
        ELSE 'Low Category'
    END AS SalesCategory
FROM 
    Sales.SalesOrderDetail AS sod
JOIN 
    Production.Product AS p ON p.ProductID = sod.ProductID
JOIN 
    Production.ProductSubcategory AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN 
    Production.ProductCategory AS pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY 
    pc.Name
HAVING 
    SUM(sod.LineTotal) > 50000;

/* Подсчитайте среднюю стоимость заказа и общее количество заказов по каждому региону (StateProvince). 
Включите только регионы, где средняя стоимость заказа превышает 1500. 
Добавьте категорию: "Expensive" для регионов со средней стоимостью заказа выше 3000, "Moderate" 
для стоимости от 2000 до 3000 и "Affordable" для остальных. 
Укажите регион, среднюю стоимость заказа, количество заказов и категорию.
Используйте таблицы Sales.SalesOrderHeader, Person.Address, и Person.StateProvince. */

SELECT 
    sp.Name AS Region,
    AVG(soh.TotalDue) AS AverageOrderCost,
    COUNT(soh.SalesOrderID) AS OrderCount,
    CASE 
        WHEN AVG(soh.TotalDue) > 3000 THEN 'Expensive'
        WHEN AVG(soh.TotalDue) BETWEEN 2000 AND 3000 THEN 'Moderate'
        ELSE 'Affordable'
    END AS Category
FROM 
    Sales.SalesOrderHeader AS soh
JOIN 
    Person.Address AS a ON soh.ShipToAddressID = a.AddressID
JOIN 
    Person.StateProvince AS sp ON sp.StateProvinceID = a.StateProvinceID
GROUP BY 
    sp.Name
HAVING 
    AVG(soh.TotalDue) > 1500;
