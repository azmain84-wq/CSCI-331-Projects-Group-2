
-- 1) Select customer names and their order info
SELECT 
    c.CustomerName,   -- customer name from Customers table
    o.OrderID,        -- order ID from Orders table
    o.OrderDate       -- order date from Orders table
FROM Sales.Customers AS c   -- Customers table alias = c
INNER JOIN Sales.Orders AS o   -- Orders table alias = o
    ON c.CustomerID = o.CustomerID;   -- match orders to the correct customer
    
    
 -- 2) Show orders and the salesperson who handled them
SELECT 
    o.OrderID,             -- unique order ID
    e.FullName AS Salesperson,  -- name of salesperson from People table
    o.OrderDate            -- date when the order was placed
FROM Sales.Orders AS o         -- Orders table
INNER JOIN Application.People AS e   -- People table has employees
    ON o.SalespersonPersonID = e.PersonID;  -- join using salesperson’s PersonID
    

-- 3) Show customers who placed fewer than 12 orders
SELECT
    c.CustomerName,                   -- name of customer
    COUNT(o.OrderID) AS TotalOrders   -- total orders placed
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID    -- join customers to orders
GROUP BY c.CustomerName               -- one row per customer
HAVING COUNT(o.OrderID) < 12;          -- filter: fewer than 3 orders, LLM help needed 

    
-- 4) List customers who never placed an order
SELECT 
    c.CustomerName,   -- name of customer
    o.OrderID         -- if NULL = no order placed
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID   -- try to match customers to orders
WHERE o.OrderID IS NULL;   -- filter: only customers with no orders


-- 5) Show orders and the delivery method used (from the invoice)
SELECT
    o.OrderID,                  -- order ID from Sales.Orders
    o.OrderDate,                -- order date
    dm.DeliveryMethodName       -- delivery method name from Application.DeliveryMethods
FROM Sales.Orders AS o
LEFT JOIN Sales.Invoices AS i
    ON i.OrderID = o.OrderID    -- link each order to its invoice(s), if any
LEFT JOIN Application.DeliveryMethods AS dm
    ON i.DeliveryMethodID = dm.DeliveryMethodID;  -- get the method used on the invoice
    
  
-- 6) Show suppliers and the products they supply
SELECT 
    s.SupplierName,       -- supplier name
    si.StockItemName      -- product name (can be NULL if no product)
FROM Warehouse.StockItems AS si
RIGHT JOIN Purchasing.Suppliers AS s
    ON si.SupplierID = s.SupplierID;  -- link suppliers to their items
    
    
-- 7) Show each customer and their primary contact details
SELECT 
    c.CustomerName,        -- customer name
    p.FullName AS PrimaryContact,  -- contact person
    p.PhoneNumber,         -- phone of contact
    p.EmailAddress         -- email of contact
FROM Sales.Customers AS c
LEFT JOIN Application.People AS p
    ON c.PrimaryContactPersonID = p.PersonID;  -- join customers to their contact person
    
    
-- 8) Show orders with customer and salesperson details
SELECT 
    o.OrderID,             -- order ID
    c.CustomerName,        -- customer name
    e.FullName AS Salesperson,  -- salesperson name
    o.OrderDate            -- order date
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON o.CustomerID = c.CustomerID    -- link orders to customers
INNER JOIN Application.People AS e
    ON o.SalespersonPersonID = e.PersonID;  -- link orders to salesperson
    
    
-- 9) Count how many orders each customer placed
SELECT 
    c.CustomerName,                 -- customer name
    COUNT(o.OrderID) AS TotalOrders -- total orders (0 if none)
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID   -- join customers to orders
GROUP BY c.CustomerName              -- group so each customer shows once
ORDER BY TotalOrders DESC, c.CustomerName;  -- order results


-- 10) Rank salespeople based on the total quantity of items they sold
-- assistance from LLM chatgpt.
SELECT 
    e.FullName AS Salesperson,     -- salesperson name
    SUM(ol.Quantity) AS TotalItemsSold,  -- total number of items sold
    RANK() OVER (ORDER BY SUM(ol.Quantity) DESC) AS SalesRank
        -- rank salespeople (1 = highest sales)
FROM Sales.OrderLines AS ol
INNER JOIN Sales.Orders AS o
    ON ol.OrderID = o.OrderID      -- link order lines to orders
INNER JOIN Application.People AS e
    ON o.SalespersonPersonID = e.PersonID   -- link orders to salespeople
GROUP BY e.FullName;               -- group results per salesperson

--11) Show every possible combination of customers and delivery methods
SELECT 
    c.CustomerName,          -- customer name
    dm.DeliveryMethodName    -- delivery method
FROM Sales.Customers AS c
CROSS JOIN Application.DeliveryMethods AS dm;  -- all pairs
   
   
    
   
    
