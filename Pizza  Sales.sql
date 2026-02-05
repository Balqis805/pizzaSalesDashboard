select * from pizza_sales
select sum(total_price) as Total_Revenue from pizza_sales
select sum(total_price)/count(distinct order_id) from pizza_sales
select sum(quantity) as Total_Pizza_sold from pizza_sales
select count(distinct order_id) as Total_Orders from pizza_sales

select cast(cast(sum(quantity) as decimal(10,2)) as decimal(10,2)) as Avg_Pizza_Per_Order from pizza_sales

-----Daily Trend------
select datename(dw,order_date) as order_day,count(distinct order_id) as Total_Orders from pizza_sales 
group by datename(dw,order_date)
order by "Total_orders" asc

----Hourly Trend____
select datepart(hour,order_time) as Order_Hours,
count(distinct order_id) as Total_Orders from pizza_sales
group by datepart(hour,order_time)
order by datepart(hour,order_time)


---Percentage of sales by Pizza Category
select pizza_category,sum(total_price) as Total_Sales,sum(total_price)*100/
(select sum(total_price) from pizza_sales where month(order_date)=1)  as PCT from pizza_sales
where month(order_date)=1
group by pizza_category


---Percentage of sales by Pizza Size---
select pizza_size,cast(sum(total_price) as decimal(10,2))as Total_Sales, cast(sum(total_price)*100/
(select sum(total_price) from pizza_sales) as decimal(10,2))
as PCT from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by PCT desc

---Total Pizzas sold by Pizza Category---
select pizza_category,sum(quantity) as Total_Pizzas from pizza_sales
group by pizza_category


---Top 5 best sellers by Total Pizzas Sold---
select top 5 pizza_name,sum(quantity) as Total_Pizza_Sold from Pizza_Sales
group by pizza_name
order by sum(quantity) desc

---Bottom 5 worst sellers by Total Pizzas Sold---
select Top 5 pizza_name,sum(quantity) as Total_Pizza_Sold from Pizza_Sales
where month(order_date)=1
group by pizza_name
order by sum(quantity) asc
