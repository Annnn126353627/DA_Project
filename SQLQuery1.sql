--Chọn tất cả từ bảng Orders
SELECT * FROM Orders;
--Chọn tất cả từ bảng Managers
SELECT * FROM Managers;
--Chọn một số cột và đổi tên
SELECT order_id as ma_don_hang, order_priority, order_date as ngay_dat_hang, value as gia_tri
FROM Orders;
--Chọn một số cột và đổi tên theo tên tiếng việt
SELECT order_id as "mã đơn hàng", order_date as "ngày đặt hàng", value as "giá trị"
FROM Orders;
--Hiển thị bảng kết quả sử dụng toán tử 
SELECT order_id, order_date, order_quantity, value, profit,
		order_quantity * unit_price * (1 - discount) as Revenue
FROM Orders;

SELECT order_id, order_date, order_quantity, value, profit,
		order_quantity * unit_price * (1 - discount) as Revenue, 
		product_base_margin * unit_price + shipping_cost as Total_cost
FROM Orders;

--Loại bỏ trùng lặp

SELECT DISTINCT manager
FROM Profiles;

---So sánh với không có DISTINTC
SELECT manager 
FROM Profiles;
---> Kết quả cho thấy là khi không có DISTINCT thì sẽ cho ra truy vấn với 
--nhiều dữ liệu trùng nhau

SELECT DISTINCT province FROM Profiles;

SELECT DISTINCT order_priority FROM Orders;

SELECT DISTINCT customer_name, order_priority
FROM Orders;

--SELECT TOP
SELECT TOP 10 * FROM Orders;

SELECT TOP 20 PERCENT order_id, order_date, order_priority, order_quantity, value
FROM Orders

SELECT TOP 100 PERCENT order_id, order_date, customer_name, order_priority
FROM Orders;

--Với câu lệnh WHERE
SELECT *
FROM Orders
WHERE order_priority = 'Medium';

SELECT *
FROM Orders
WHERE order_priority != 'High';

SELECT *
FROM Orders
WHERE order_priority IN('Medium', 'High', 'Low');

SELECT *
FROM Orders
WHERE order_priority NOT IN('Medium', 'High', 'Low');

SELECT TOP 100 *
FROM Orders
WHERE shipping_mode LIKE '%Air%';

SELECT *
FROM Orders
WHERE product_category NOT LIKE 'Co%';

SELECT *
FROM Orders
WHERE region = 'West';

SELECT * 
FROM Orders
WHERE order_priority != 'Critical';

SELECT *
FROM Orders
WHERE order_priority IN('Medium', 'Low', 'Not Specified', 'High');

SELECT * FROM Orders WHERE province LIKE '%New%';

SELECT * FROM Orders 
WHERE shipping_mode NOT LIKE '%Air%' and value < 500;

SELECT * FROM Orders
WHERE product_category LIKE 'Co%'

SELECT * FROM Orders
WHERE customer_segment LIKE '%e' AND order_quantity > 10;

--hàm MAX, MIN, AVG, COUNT, SUM

SELECT MIN(profit) as MIN_PROFIT FROM Orders;

SELECT MAX(order_quantity) as MAX_ORDER_QUANTITY FROM Orders;

SELECT COUNT(order_priority) as 'Order_priority' FROM Orders;

SELECT AVG(profit) as AVG FROM Orders;

SELECT SUM(profit) as SUM FROM Orders;

SELECT COUNT(DISTINCT manager_id) AS DISTINTC FROM Managers;

--GROUP BY

SELECT province as 'Tỉnh', SUM(profit) as 'Tổng lợi nhuận'
FROM Orders
GROUP BY province;

SELECT province as 'Tinh', customer_name as 'Khách hàng', SUM(profit) as 'Lợi nhuận'
FROM Orders
GROUP BY province, customer_name;

SELECT province as 'Tinh', customer_name as 'Khách hàng', SUM(profit) as 'Lợi nhuận'
FROM Orders
GROUP BY province, customer_name
HAVING SUM(profit) > 1000; --HAVING được sử dụng vì WHERE không thể sử dụng được với các hàm tổng hợp

--So sánh WHERE và HAVING:
---WHERE: sử dụng để lọc điều kiện trên các cột có sẵn
---HAVING: sử dụng để lọc điều kiện của hàm tổng hợp

SELECT * 
FROM Orders
WHERE order_priority = 'Low';

SELECT product_name, SUM(order_quantity) as total_quantity
FROM Orders
GROUP BY product_name
HAVING SUM(order_quantity) > 10;

SELECT *
FROM Orders
ORDER BY profit DESC;

SELECT customer_name, SUM(value) as total_value
FROM Orders
GROUP BY customer_name
ORDER BY SUM(value) DESC;

--JOIN
SELECT * FROM Orders;
SELECT * FROM Returns;

SELECT o.order_id, order_date, product_name, returned_date
FROM Orders o
JOIN Returns r
ON o.order_id = r.order_id;

SELECT o.order_id, order_date, product_name, returned_date
FROM Orders o
LEFT JOIN Returns r
ON o.order_id = r.order_id;

SELECT 
Orders.order_id,
order_date,
SUM(order_quantity) as total_order_quantity,
SUM(value) as total_value,
SUM(profit) as total_profit,
returned_date
FROM Orders
JOIN Returns
ON Orders.order_id = Returns.order_id
GROUP BY Orders.order_id,
order_date,returned_date;

select p.manager,
sum(order_quantity) AS total_order_quantity,
sum(value) AS total_value,
sum(profit) AS total_profit
from Orders AS o
left join Profiles AS p
on o.province=p.province
group by p.manager

--UNION

Select order_priority, sum(profit) AS total_profit
From Orders
Where order_priority = 'Not Specified'
Group by order_priority
Union all
Select order_priority, sum(profit) AS total_profit
From Orders
Where order_priority = 'Low'
Group by order_priority
Union all
Select order_priority, sum(profit) AS total_profit
From Orders
Where order_priority = 'High'
Group by order_priority
Union all
Select order_priority, sum(profit) AS total_profit
From Orders
Where order_priority = 'Medium'
Group by order_priority
Union all
Select order_priority, sum(profit) AS total_profit
From Orders
Where order_priority = 'Critical'
Group by order_priority;

--CASE WHEN

SELECT 
	CASE 
		WHEN discount = 0 THEN 'No Discout'
		ELSE 'Discout' 
		END
FROM Orders;

SELECT
	(CASE 
		WHEN value > 1000 THEN 'HIGHT'
		WHEN value BETWEEN 200 AND 1000 THEN 'MEDIUM'
		WHEN value < 200 THEN 'LOW'
		END) as range_value
FROM Orders;

--truy vấn con

SELECT 
product_name,
SUM(value) as total_value,
(
SELECT AVG(value) FROM Orders
) as avg_value
FROM Orders
GROUP BY product_name;

SELECT * FROM 
(
SELECT product_name, sum(value) as total_value
from Orders
Group by product_name
) A
Where total_value > (SELECT avg(value) from orders)

--CTE: là một bảng chứa dữ liệu tạm thời từ câu lệnh được định nghĩa trong phạm vi của nó
with A as 
(
	SELECT customer_name,
			COUNT(order_id) as count_orders
	FROM Orders
	GROUP BY customer_name
)
SELECT * FROM A WHERE count_orders > 10;