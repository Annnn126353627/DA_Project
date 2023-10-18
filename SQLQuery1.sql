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



