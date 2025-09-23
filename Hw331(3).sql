use WorldWideImporters;


/* need a script that returns the customer name and the item they bought */
select
  c.CustomerName,                        -- customer name
  c.CustomerID as CustomerID,            -- customer id
  si.StockItemName as ItemBought         -- item name they bought
from Sales.Customers as c                -- use customers table in sales, call it c
left join Sales.Orders as o              -- bring that customer's orders
  on o.CustomerID = c.CustomerID         -- link order to customer
left join Sales.OrderLines as ol         -- bring order lines
  on ol.OrderID = o.OrderID              -- link line to its order
left join Warehouse.StockItems as si     -- bring item info
  on si.StockItemID = ol.StockItemID     -- link item to line
order by c.CustomerID, si.StockItemName; -- sort by customer then item


/* need script that tells me where the orders are going to */
select
  o.OrderDate,                           -- order date
  o.OrderID as OrderID,                  -- order id
  c.CustomerName,                        -- customer name
  c.DeliveryAddressLine1                 -- first line of delivery address
from Sales.Orders as o                   -- use sales orders, call it o
join Sales.Customers as c                -- bring the customer
  on c.CustomerID = o.CustomerID         -- link order to customer
order by o.OrderDate, o.OrderID;         -- sort by date then id


/* need script that tells me the item and the person that sold it to me */
select
  si.StockItemID,                        -- item id
  si.StockItemName,                      -- item name
  o.OrderID,                             -- order id
  o.SalespersonPersonID,                 -- salesperson id
  p.FullName as SalespersonName          -- salesperson name
from Sales.Orders as o                   -- use orders
join Sales.OrderLines as ol              -- bring order lines
  on ol.OrderID = o.OrderID              -- link line to order
join Warehouse.StockItems as si          -- bring item info
  on si.StockItemID = ol.StockItemID     -- link item to line
join Application.People as p             -- use people for staff names
  on p.PersonID = o.SalespersonPersonID  -- link order to salesperson
order by si.StockItemID, o.OrderID;      -- sort by item then order


/* need script that tells me how much each customer spent */
select
  c.CustomerID,                          -- customer id
  c.CustomerName,                        -- customer name
  sum(ol.Quantity * ol.UnitPrice) as Subtotal  -- total money from their orders
from Sales.Customers as c                -- use customers
join Sales.Orders as o                   -- bring orders
  on o.CustomerID = c.CustomerID         -- link order to customer
join Sales.OrderLines as ol              -- bring lines
  on ol.OrderID = o.OrderID              -- link line to order
group by c.CustomerID, c.CustomerName    -- one row per customer
order by Subtotal desc;                  -- biggest spenders first


/* need a script that tells me the purchase order and if the line is finalized (purchasing) */
select
  o.PurchaseOrderID,                     -- purchase order id
  ol.PurchaseOrderLineID,                -- line id on the purchase order
  ol.IsOrderLineFinalized                -- yes/no if this line is finalized
from Purchasing.PurchaseOrders as o      -- use purchase orders (buying from suppliers)
left join Purchasing.PurchaseOrderLines as ol  -- bring po lines
  on ol.PurchaseOrderID = o.PurchaseOrderID    -- link line to its po
order by o.PurchaseOrderID;              -- sort by po id


/* need a script that tells me my items and their quantity */
select
  si.StockItemID,                        -- item id
  si.StockItemName,                      -- item name
  h.QuantityOnHand                       -- how many in stock
from Warehouse.StockItems as si          -- use items
join Warehouse.StockItemHoldings as h    -- bring holdings info
  on h.StockItemID = si.StockItemID      -- link holding to item
order by si.StockItemName;               -- sort by item name


/* delivery methods and countries*/
select
  c.CountryName,                         -- country name
  dm.DeliveryMethodName                  -- delivery method name
from Application.Countries as c          -- use countries
cross join Application.DeliveryMethods as dm -- every country x every method
order by c.CountryName, dm.DeliveryMethodName; -- sort by names


/* payment methods and countries  */
select
  c.CountryName,                         -- country name
  pm.PaymentMethodName                   -- payment method name
from Application.PaymentMethods as pm    -- use payment methods
cross join Application.Countries as c    -- every method x every country
order by c.CountryName, pm.PaymentMethodID; -- sort by country then method id


/* cities with orders going there (show all cities even if 0 orders) */
select
  ci.CityName,                           -- city name
  count(o.OrderID) as OrdersToCity       -- how many orders to this city
from Sales.Orders as o                   -- orders
join Sales.Customers as c                -- customers for those orders
  on c.CustomerID = o.CustomerID         -- link order to customer
right join Application.Cities as ci      -- keep all cities
  on ci.CityID = c.DeliveryCityID        -- link customer to city
group by ci.CityName                     -- one row per city
order by ci.CityName;                    -- sort by city name


/* how many orders of an item (count orders that include each item) */
select
  si.StockItemID,                        -- item id
  si.StockItemName,                      -- item name
  count(ol.OrderID) as OrdersCount       -- number of orders that have this item (lines counted)
from Warehouse.StockItems as si          -- items
left join Sales.OrderLines as ol         -- lines where item was sold
  on si.StockItemID = ol.StockItemID     -- link line to item
group by si.StockItemID, si.StockItemName -- one row per item
order by si.StockItemName;               -- sort by item name



