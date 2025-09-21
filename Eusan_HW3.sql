
/* 1) Orders per customer in 2016 */
SELECT
  c.CustomerID,                                -- customer id
  c.CustomerName,                             -- customer name
  COUNT(*) AS Orders2016                      -- number of orders in 2016
FROM Sales.Customers AS c                     -- Sales schema
JOIN Sales.Orders AS o                        -- orders placed by customers
  ON o.CustomerID = c.CustomerID              -- match customer → order
WHERE o.OrderDate >= '2016-01-01'             -- start of 2016
  AND o.OrderDate <  '2017-01-01'             -- end of 2016 (exclusive)
GROUP BY c.CustomerID, c.CustomerName         -- one row per customer
ORDER BY Orders2016 DESC;                     -- most active first


/* 2) customer with no orders */
SELECT
  c.CustomerID,                               -- customer id
  c.CustomerName                              -- customer name
FROM Sales.Customers AS c
LEFT JOIN Sales.Orders AS o
  ON o.CustomerID = c.CustomerID              -- try to find their orders
WHERE o.OrderID IS NULL;                      -- keep only those with none

/* 3) All stock items and their supplier */
SELECT
  si.StockItemID,                             -- item id
  si.StockItemName,                           -- item name
  s.SupplierName                              -- supplier 
FROM Purchasing.Suppliers AS s
RIGHT JOIN Warehouse.StockItems AS si
  ON si.SupplierID = s.SupplierID             -- ensure all items appear
ORDER BY si.StockItemName;                    -- alphabetical items

/* 4) Order lines > 10 units */
SELECT
  o.OrderID,                                  -- order id
  o.OrderDate,                                -- order date
  si.StockItemName,                           -- product name
  ol.Quantity                                 -- quantity ordered
FROM Sales.Orders AS o
JOIN Sales.OrderLines AS ol
  ON ol.OrderID = o.OrderID                   -- order → lines
JOIN Warehouse.StockItems AS si
  ON si.StockItemID = ol.StockItemID          -- line → product
WHERE ol.Quantity > 10                         -- only bigger lines
ORDER BY o.OrderID, si.StockItemName;         -- tidy output

/* 5) Avg items per invoice by city (compute per-invoice qty, then average per city) */
WITH InvoiceQty AS (                           -- helper: items per invoice
  SELECT
    il.InvoiceID,                              -- invoice id
    SUM(il.Quantity) AS TotalQty               -- total items on invoice
  FROM Sales.InvoiceLines AS il
  GROUP BY il.InvoiceID
)
SELECT
  ci.CityName,                                 -- delivery city
  AVG(iq.TotalQty) AS AvgItemsPerInvoice       -- average items per invoice
FROM Sales.Invoices AS i
JOIN InvoiceQty AS iq
  ON iq.InvoiceID = i.InvoiceID                -- invoice → qty
JOIN Sales.Customers AS c
  ON c.CustomerID = i.CustomerID               -- invoice → customer
JOIN Application.Cities AS ci
  ON ci.CityID = c.DeliveryCityID              -- customer → city
GROUP BY ci.CityName
ORDER BY AvgItemsPerInvoice DESC;              -- biggest averages first


/* 6) Cities in the same state/province */
SELECT
  sp.StateProvinceName,                        -- the state/province
  a.CityName  AS CityA,                        -- first city
  b.CityName  AS CityB                         -- paired city in same state
FROM Application.Cities AS a
JOIN Application.Cities AS b
  ON a.StateProvinceID = b.StateProvinceID     -- same state/province
 AND a.CityID < b.CityID                       -- avoid duplicate/reverse pairs
JOIN Application.StateProvinces AS sp
  ON sp.StateProvinceID = a.StateProvinceID    -- show the state/province name
ORDER BY sp.StateProvinceName, CityA, CityB;   -- readable ordering

/* 7) Orders not yet invoiced */
SELECT
  o.OrderID,                                   -- order id
  o.OrderDate                                  -- order date
FROM Sales.Orders AS o
LEFT JOIN Sales.Invoices AS i
  ON i.OrderID = o.OrderID                     -- try to find invoice
WHERE i.InvoiceID IS NULL                      -- keep orders with no invoice
ORDER BY o.OrderID;                            -- stable order

/* 8) List every customer name together with each delivery method, 
 so we can see all possible customer–delivery options. */
SELECT
  c.CustomerName,           -- customer
  dm.DeliveryMethodName     -- delivery method
FROM Sales.Customers AS c
CROSS JOIN Application.DeliveryMethods AS dm
ORDER BY c.CustomerName, dm.DeliveryMethodName;


/* 9) Customers with their city/state/country
      (Customers → Cities → StateProvinces → Countries) */
SELECT
  c.CustomerName,                              -- customer
  ct.CityName,                                 -- city
  sp.StateProvinceName,                        -- state/province
  co.CountryName                               -- country
FROM Sales.Customers AS c
JOIN Application.Cities AS ct
  ON ct.CityID = c.DeliveryCityID              -- customer → city
JOIN Application.StateProvinces AS sp
  ON sp.StateProvinceID = ct.StateProvinceID   -- city → state/province
JOIN Application.Countries AS co
  ON co.CountryID = sp.CountryID               -- state/province → country
ORDER BY co.CountryName, sp.StateProvinceName, c.CustomerName;

/* 10) All purchase orders with item info */
SELECT
  po.PurchaseOrderID,                          -- PO id
  po.OrderDate,                                -- PO date
  si.StockItemName,                            -- item name (can be NULL)
  pol.OrderedOuters,                           -- ordered outers (WWI column)
  pol.Description                              -- line description
FROM Warehouse.StockItems AS si
RIGHT JOIN Purchasing.PurchaseOrderLines AS pol
  ON pol.StockItemID = si.StockItemID          -- line → item (keep all lines)
RIGHT JOIN Purchasing.PurchaseOrders AS po
  ON po.PurchaseOrderID = pol.PurchaseOrderID  -- keep all POs
ORDER BY po.PurchaseOrderID, si.StockItemName; -- grouped by PO
