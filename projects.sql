-- query contains customer data and stores they purchase from -- 
select *
from customers
limit 5;

-- query for employee info and their title --
select *
from employees
limit 5;

-- query returns office and addresses --
select *
from offices
limit 5;

-- query returns oder placement --
select *
from orders
limit 5;

-- query returns order details --
select *
from orderdetails
limit 5;

-- query returns payment details --
select *
from payments
limit 5;
-- details about the product --
select *
from products
limit 5;

-- query about product type --
select *
from productlines
limit 5;

-- query to display table names as a string with a description of dimensions --
SELECT 'Customers' AS table_name,
       (SELECT COUNT(*) FROM pragma_table_info('Customers')) AS number_of_attributes,
       (SELECT COUNT(*) FROM Customers) AS number_of_rows

UNION ALL

SELECT 'Products',
       (SELECT COUNT(*) FROM pragma_table_info('Products')),
       (SELECT COUNT(*) FROM Products)

UNION ALL

SELECT 'ProductLines',
       (SELECT COUNT(*) FROM pragma_table_info('ProductLines')),
       (SELECT COUNT(*) FROM ProductLines)

UNION ALL

SELECT 'Orders',
       (SELECT COUNT(*) FROM pragma_table_info('Orders')),
       (SELECT COUNT(*) FROM Orders)

UNION ALL

SELECT 'OrderDetails',
       (SELECT COUNT(*) FROM pragma_table_info('OrderDetails')),
       (SELECT COUNT(*) FROM OrderDetails)

UNION ALL

SELECT 'Payments',
       (SELECT COUNT(*) FROM pragma_table_info('Payments')),
       (SELECT COUNT(*) FROM Payments)

UNION ALL

SELECT 'Employees',
       (SELECT COUNT(*) FROM pragma_table_info('Employees')),
       (SELECT COUNT(*) FROM Employees)

UNION ALL

SELECT 'Offices',
       (SELECT COUNT(*) FROM pragma_table_info('Offices')),
       (SELECT COUNT(*) FROM Offices);

-- Adressing the first question --
-- Which Products SHould we order more or less off ? -- 

SELECT 
    p.productCode, 
    ROUND(
        (SELECT COUNT(*) 
         FROM orderdetails od 
         WHERE od.productCode = p.productCode) / 
        (SELECT SUM(od.quantityOrdered) 
         FROM orderdetails od 
         WHERE od.productCode = p.productCode), 2) AS low_stock
FROM 
    products p
GROUP BY 
    p.productCode
ORDER BY 
    low_stock DESC
LIMIT 10;

-- product performance for each product join tables--
SELECT 
    p.productCode, 
    SUM(od.quantityOrdered * p.buyPrice) AS product_performance
FROM 
    products p
JOIN 
    orderdetails od
    ON p.productCode = od.productCode
GROUP BY 
    p.productCode
ORDER BY 
    product_performance DESC
LIMIT 10;

-- combining tables using cte --
WITH low_stock_products AS (
    SELECT 
        p.productCode, 
        p.productName,
        ROUND(od.num_orders / od.total_quantity, 2) AS low_stock
    FROM 
        products p
    JOIN (
        SELECT 
            productCode, 
            COUNT(*) AS num_orders, 
            SUM(quantityOrdered) AS total_quantity
        FROM 
            orderdetails
        GROUP BY 
            productCode
    ) od ON p.productCode = od.productCode
),
top_performing_products AS (
    SELECT 
        p.productCode, 
        SUM(od.quantityOrdered * p.buyPrice) AS product_performance
    FROM 
        products p
    JOIN 
        orderdetails od ON p.productCode = od.productCode
    GROUP BY 
        p.productCode
    ORDER BY 
        product_performance DESC
    LIMIT 10
)
SELECT 
    lsp.productCode, 
    lsp.productName,
    lsp.low_stock
FROM 
    low_stock_products lsp
WHERE 
    lsp.productCode IN (SELECT productCode FROM top_performing_products)
ORDER BY 
    lsp.low_stock DESC;

-- Q2 Matching marketing and communication strategies to customer behavior --

SELECT c.customerNumber, 
       c.customerName,
       SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS totalProfit
  FROM customers c
  JOIN orders o ON c.customerNumber = o.customerNumber
  JOIN orderdetails od ON o.orderNumber = od.orderNumber
  JOIN products p ON od.productCode = p.productCode
GROUP BY c.customerNumber, c.customerName;

	   
