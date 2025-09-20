---Shiwlee Rahman
-- Prof: Petter Heller 
-- Group # 2
-- I used ChatGPT for study guidance, and some queries I created to understand better, but most of the work is mine.

--- 1. List all orders with their customers
-- Proposition: List every order and the customer who placed it.

Use WideWorldImporters;
SELECT O.OrderID, O.OrderDate, C.CustomerID, C.CustomerName
FROM Sales.Orders AS O
INNER JOIN Sales.Customers AS C
  ON O.CustomerID = C.CustomerID
ORDER BY O.OrderID;



-- Proposition 2: For each order line, show the product, quantity, and price
SELECT 
    O.OrderID,            -- Order ID from Orders table
    O.OrderDate,          -- Date when the order was placed
    SI.StockItemName,     -- Product name from StockItems table
    OL.Quantity,          -- Quantity of that product in the order
    OL.UnitPrice          -- Price per unit
FROM Sales.Orders AS O
INNER JOIN Sales.OrderLines AS OL
    ON O.OrderID = OL.OrderID           -- match each order with its line items
INNER JOIN Warehouse.StockItems AS SI
    ON OL.StockItemID = SI.StockItemID  -- match each line item with the product details
ORDER BY O.OrderID, SI.StockItemName;   -- sort neatly by order and product name


---3.Left join — include customers even if they have no orders
-- Proposition: Show all customers; if they have orders, show them.

SELECT C.CustomerID, C.CustomerName, O.OrderID, O.OrderDate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
  ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerID, O.OrderID;

/*SELECT *
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
ON C.CustomerID = O.CustomerID;



 
SELECT COUNT(*) AS TotalOrders
FROM Sales.Orders AS O
INNER JOIN Sales.Customers AS C
  ON O.CustomerID = C.CustomerID;*/


---4. Show all customers, and highlight only the ones who placed orders on February 12, 2015.

SELECT 
  C.CustomerID,
  C.CustomerName,
  O.OrderID,
  O.OrderDate
FROM Sales.Customers AS C
LEFT JOIN Sales.Orders AS O
  ON C.CustomerID = O.CustomerID
 AND O.OrderDate = '2015-02-12'   -- only attach orders from this one day
ORDER BY C.CustomerID;


---5 Right join Proposition: List all orders, and if there is a customer, show them
SELECT 
  C.CustomerID,
  C.CustomerName,
  O.OrderID,
  O.OrderDate
FROM Sales.Customers AS C
RIGHT JOIN Sales.Orders AS O
  ON C.CustomerID = O.CustomerID
ORDER BY O.OrderID;

--6 Show all orders placed on February 12, 2013, and include the customer details if available.
SELECT 
  C.CustomerID,
  C.CustomerName,
  O.OrderID,
  O.OrderDate
FROM Sales.Customers AS C
RIGHT JOIN Sales.Orders AS O
  ON C.CustomerID = O.CustomerID
WHERE O.OrderDate = '2013-02-12'
ORDER BY O.OrderID;


--7 Proposition:List all possible combinations of customers and salespeople (only include people who are salespersons).
SELECT
  C.CustomerID,
  C.CustomerName,
  P.PersonID     AS SalespersonID,
  P.FullName     AS SalespersonName
FROM Sales.Customers AS C
CROSS JOIN Application.People AS P
WHERE P.IsSalesperson = 1;




--8 
-- Proposition: Show all customers and all orders,
-- even if some customers never ordered or some orders don’t have a customer
SELECT 
    C.CustomerID,
    C.CustomerName,
    O.OrderID,
    O.OrderDate
FROM Sales.Customers AS C
FULL OUTER JOIN Sales.Orders AS O
    ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerID, O.OrderID;


---9: Show all customers and all suppliers, even if some customers are not suppliers or some suppliers are not customers.

 SELECT 
    C.CustomerID,
    C.CustomerName,
    S.SupplierID,
    S.SupplierName
FROM Sales.Customers AS C
FULL OUTER JOIN Purchasing.Suppliers AS S
    ON C.CustomerName = S.SupplierName
ORDER BY C.CustomerID, S.SupplierID;


--10 Proposition: For each customer, show their customer ID, name, and the country they are located in.

SELECT C.CustomerID, C.CustomerName, Ctry.CountryName
FROM Sales.Customers AS C
INNER JOIN Application.Cities AS City
  ON C.DeliveryCityID = City.CityID
INNER JOIN Application.StateProvinces AS SP
  ON City.StateProvinceID = SP.StateProvinceID
INNER JOIN Application.Countries AS Ctry
  ON SP.CountryID = Ctry.CountryID
ORDER BY C.CustomerID;













