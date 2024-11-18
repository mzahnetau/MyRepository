/* Цель: Написать хранимую процедуру, которая анализирует количество товаров на складе и выводит 
для каждого товара общее количество.

Описание:
Процедура должна:

Подсчитать общее количество каждого товара на складе.
Результат сохранить в таблице ProductInventorySummary, где будут храниться ProductID и TotalQuantity 
(общее количество данного товара на складе).
Для обработки данных использовать цикл WHILE.
Используемые таблицы:
Production.ProductInventory: Содержит данные о наличии товаров на складе, включая ProductID и Quantity.
Логика:
Для каждого товара нужно вычислить общее количество с учетом всех записей в таблице ProductInventory.
Создаем таблицу для хранения результатов.
Затем, используя цикл, обновляем таблицу с общими данными для каждого товара. */


CREATE TABLE ProductInventorySummary (
    ProductID INT
    , TotalQuantity INT
);
    DELETE FROM ProductInventorySummary;

DECLARE @RowCounter INT = 1;
DECLARE @TotalRows INT;
DECLARE @ProductID INT;
DECLARE @TotalQuantity INT;

SET @TotalRows = (SELECT COUNT(DISTINCT ProductID) FROM Production.ProductInventory);

WHILE @RowCounter <= @TotalRows
BEGIN
    SELECT @ProductID = ProductID
    FROM (
        SELECT DISTINCT ProductID, ROW_NUMBER() OVER (ORDER BY ProductID) AS RowNum
        FROM Production.ProductInventory
    ) AS Temp
    WHERE Temp.RowNum = @RowCounter;

    SELECT @TotalQuantity = SUM(Quantity)
    FROM Production.ProductInventory
    WHERE ProductID = @ProductID;

    INSERT INTO ProductInventorySummary (ProductID, TotalQuantity)
    VALUES (@ProductID, @TotalQuantity);

    SET @RowCounter = @RowCounter + 1;
END;

SELECT * FROM ProductInventorySummary;
