--A. KPI’S -KPI’lar
--1.Total Revenue-Toplam Gelir
select sum(total_price) Total_Revenue from pizza_sales

--2.Average Order  Value- Ortalama Sipariş Değeri
select sum(total_price)/count(distinct order_id) Avg_Order_Value from pizza_sales

--3.Total Pizza Sold-Toplam Satılan Pizza
select sum(quantity) total_pizza_sold from pizza_sales

--4.Total Orders-Toplam Sipariş
select count(distinct order_id) Total_Orders from pizza_sales

--5.Average Pizza Per Order-Sipariş Başına Ortalama Pizza Adedi
select  cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
as Avg_Pizza_Per_Order
from pizza_sales
 
--B.Daily Trend For Total Orders- Toplam Siparişler İçin Günlük Trend
select datename(dw,order_date) dayofweek_,count(distinct order_id) total_order from pizza_sales
group by datepart(dw,order_date), datename(dw,order_date)
order by datepart(dw,order_date) asc

--C.Hourly Trend For Total Orders-Saatlik Siparişler İçin Günlük Trend
select datepart(hour,order_time) as order_hours,count(distinct order_time) as total_orders from pizza_sales
group by datepart(hour,order_time)
order by datepart(hour,order_time)

--D. % Of Sales by Pizza Category-Pizza Kategorisine Göre Satışların Yüzdesi
SELECT 
    pizza_category,cast(sum(total_price) as decimal(10,2)) as total_sales, 
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category

--E. Percentage of Sales by Pizza Size- Pizza Boyutuna Göre Satış Yüzdesi
SELECT 
    pizza_size,cast(sum(total_price) as decimal(10,2)) as total_sales, 
    CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS decimal(10,2)) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY percentage_of_sales desc

--F. Total Pizzas Sold by Pizza Category- Pizza Kategorisine Göre Satılan Toplam Pizza Sayısı
select pizza_category,sum(quantity) total_pizzas_sold from pizza_sales
group by pizza_category
 
--G. Top 5 Best Sellers by Total Pizza Sold- En Çok Satan Beş Pizza

select top 5 pizza_name,sum(quantity) total_pizzas_sold from pizza_sales
group by pizza_name
order by total_pizzas_sold DESC

--H. Bottom 5 Worst Sellers by Total Pizzas Sold-En Az Satan Beş Pizza

select top 5 pizza_name,sum(quantity) total_pizzas_sold from pizza_sales
group by pizza_name
order by total_pizzas_sold asc
