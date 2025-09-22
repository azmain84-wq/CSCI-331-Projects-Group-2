/* =========================================================
   Name: Zarrin Cherry
   Course: CSCI 331 - Database Systems
   Project 3 - Chapter 3 SQL Queries
   Database: WideWorldImporters (via Docker + DBeaver)
   Note: Each query below includes a comment describing 
         the proposition and the type of JOIN used.
   ========================================================= */


/* =========================================================
Q1. Proposition: List a small sample of customers with their category names.
Join type: INNER JOIN (Customers → CustomerCategories)
========================================================= */
SELECT TOP (10)
       c.CustomerID,             -- customer unique ID
       c.CustomerName,           -- customer name
       cc.CustomerCategoryName   -- category name from CustomerCategories table
FROM Sales.Customers AS c        -- Customers table (alias = c)
INNER JOIN Sales.CustomerCategories AS cc               -- join to categories
  ON cc.CustomerCategoryID = c.CustomerCategoryID       -- match category IDs
ORDER BY c.CustomerID;           -- sort by customer ID


/* =========================================================
Q2. Proposition: Show every customer category and how many customers are in each.
Join type: LEFT OUTER JOIN (preserve all categories, even with 0 customers)
========================================================= */
SELECT cc.CustomerCategoryID,           -- category ID
       cc.CustomerCategoryName,         -- category name
       COUNT(c.CustomerID) AS CustomersInCategory      -- number of customers in each category
FROM Sales.CustomerCategories AS cc                    -- base table for categories
LEFT JOIN Sales.Customers AS c          -- join customers to categories
  ON c.CustomerCategoryID = cc.CustomerCategoryID
GROUP BY cc.CustomerCategoryID, cc.CustomerCategoryName    -- group by category
ORDER BY cc.CustomerCategoryID;         -- order by ID for readability


/* =========================================================
 Q3. Proposition: Find customers with a missing WebsiteURL, 
   include their total number of orders, and flag who is missing.
   Join type: LEFT OUTER JOIN (customers preserved) */

SELECT
    c.CustomerID,            -- customer ID
    c.CustomerName,          -- customer name
    c.WebsiteURL,            -- website URL (may be missing)
    CASE
        WHEN c.WebsiteURL IS NULL OR LTRIM(RTRIM(c.WebsiteURL)) = '' THEN 1
        ELSE 0
    END AS IsMissingWebsite,           -- flag if website is missing (1 = missing)
    COUNT(o.OrderID) AS TotalOrders    -- total number of orders for that customer
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
  ON o.CustomerID = c.CustomerID       -- match customers to orders
GROUP BY
    c.CustomerID, c.CustomerName, c.WebsiteURL,
    CASE
        WHEN c.WebsiteURL IS NULL OR LTRIM(RTRIM(c.WebsiteURL)) = '' THEN 1
        ELSE 0
    END
ORDER BY IsMissingWebsite DESC, TotalOrders DESC, c.CustomerID;


/* =========================================================
Q4. Proposition: List customers with bad phone numbers, 
   show their delivery country, and flag bad ones.
   Join type: INNER JOIN chain (Customers → Cities → States → Countries) */

SELECT
    c.CustomerID,              -- customer ID
    c.CustomerName,            -- customer name
    c.PhoneNumber,             -- phone number
    co.CountryName,            -- country name
    CASE
        WHEN c.PhoneNumber IS NULL
             OR c.PhoneNumber IN ('', 'N/A', '000-000-0000')
        THEN 1 ELSE 0
    END AS IsBadPhone          -- flag if phone is invalid
FROM Sales.Customers AS c
INNER JOIN Application.Cities AS ci
  ON ci.CityID = c.DeliveryCityID
INNER JOIN Application.StateProvinces AS sp
  ON sp.StateProvinceID = ci.StateProvinceID
INNER JOIN Application.Countries AS co
  ON co.CountryID = sp.CountryID
ORDER BY IsBadPhone DESC, c.CustomerID;


/* =========================================================
Q5. Proposition: Show the 15 newest customers and their MOST RECENT order date (if any).
Join type: LEFT OUTER JOIN (keep customers with zero orders)
========================================================= */
SELECT TOP (15)
       c.CustomerID,              -- customer ID
       c.CustomerName,            -- customer name
       c.AccountOpenedDate,       -- account creation date
       MAX(o.OrderDate) AS LastOrderDate                   -- most recent order date (if any)
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
  ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.AccountOpenedDate
ORDER BY c.AccountOpenedDate DESC, c.CustomerID;           -- newest first


/* =========================================================
Q6. Proposition: List all customers, show credit hold status,  
and how many orders they have.  
Join type: LEFT OUTER JOIN (customers preserved)  
*/
SELECT 
    c.CustomerID,           -- customer ID
    c.CustomerName,         -- customer name
    CASE 
        WHEN c.IsOnCreditHold = 1 THEN 'On Hold'
        ELSE 'Clear'
    END AS CreditStatus,                   -- status based on IsOnCreditHold flag
    COUNT(o.OrderID) AS TotalOrders        -- number of orders placed
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
    ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.IsOnCreditHold
ORDER BY c.IsOnCreditHold DESC, TotalOrders DESC, c.CustomerID;


/* =========================================================
Q7. Proposition: Show customers with long payment terms (>=45 days) and their country.
Join type: INNER JOIN chain (Customers → Cities → States → Countries)
========================================================= */
SELECT c.CustomerID,              -- customer ID
       c.CustomerName,            -- customer name
       c.PaymentDays,             -- payment term length
       co.CountryName             -- country name
FROM Sales.Customers AS c
INNER JOIN Application.Cities AS ci
  ON ci.CityID = c.DeliveryCityID
INNER JOIN Application.StateProvinces AS sp
  ON sp.StateProvinceID = ci.StateProvinceID
INNER JOIN Application.Countries AS co
  ON co.CountryID = sp.CountryID
WHERE c.PaymentDays >= 45         -- filter for long payment terms
ORDER BY c.PaymentDays DESC, c.CustomerID;


/* =========================================================
Q8. Proposition: Create a 5×5 multiplication table by generating values with a CROSS JOIN.
Join type: CROSS JOIN (Cartesian product)
========================================================= */
SELECT n1.v AS N1,                                  -- first number
       n2.v AS N2,                                  -- second number
       n1.v * n2.v AS Product                       -- multiplication result
FROM (VALUES (1),(2),(3),(4),(5)) AS n1(v)          -- values 1 to 5 as first set
CROSS JOIN (VALUES (1),(2),(3),(4),(5)) AS n2(v)    -- values 1 to 5 as second set
ORDER BY n1.v, n2.v;                                -- order results like a table


/* =========================================================
Q9. Proposition: List the 20 most expensive stock items and their supplier names.
Join type: INNER JOIN (StockItems → Suppliers)
========================================================= */
SELECT TOP (20)
       si.StockItemID,                        -- stock item ID
       si.StockItemName,                      -- stock item name
       s.SupplierName,                        -- supplier name
       si.UnitPrice                           -- price of the item
FROM Warehouse.StockItems AS si
INNER JOIN Purchasing.Suppliers AS s
  ON s.SupplierID = si.SupplierID
ORDER BY si.UnitPrice DESC, si.StockItemID;   -- most expensive first


/* =========================================================
Q10. Proposition: Show the 20 most recent orders with the customer and salesperson names.
Join type: INNER JOINs (Orders → Customers, Orders → People)
========================================================= */
SELECT TOP (20)
       o.OrderID,                              -- order ID
       o.OrderDate,                            -- date of order
       c.CustomerName,                         -- customer name
       p.FullName AS Salesperson               -- salesperson full name
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
  ON c.CustomerID = o.CustomerID
INNER JOIN Application.People AS p
  ON p.PersonID = o.SalespersonPersonID
ORDER BY o.OrderDate DESC, o.OrderID DESC;     -- most recent first


