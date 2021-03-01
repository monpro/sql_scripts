/**
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| country       | varchar |
+---------------+---------+
customer_id is the primary key for this table.
This table contains information of the customers in the company.

---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| description   | varchar |
| price         | int     |
+---------------+---------+
product_id is the primary key for this table.
This table contains information of the products in the company.
price is the product cost.

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| customer_id   | int     |
| product_id    | int     |
| order_date    | date    |
| quantity      | int     |
+---------------+---------+
order_id is the primary key for this table.
This table contains information on customer orders.
customer_id is the id of the customer who bought "quantity" products with id "product_id".
Order_date is the date in format ('YYYY-MM-DD') when the order was shipped.

Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.
Solution: use multiple table join and IF statement to calculate the sum.

Result table:
+--------------+------------+
| customer_id  | name       |
+--------------+------------+
| 1            | Winston    |
+--------------+------------+

 */

SELECT c.customer_id, c.name
FROM Customers c
inner JOIN Orders o on c.customer_id = o.customer_id
inner join product p on p.product_id = o.product_id
GROUP BY c.customer_id
HAVING SUM(IF(LEFT(o.order_date, 7) = '2020-06', o.quantity, 0) * p.price) >= 100
AND SUM(IF(LEFT(o.order_date, 7) = '2020-07', o.quantity, 0) * p.price) >= 100
