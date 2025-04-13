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

	   