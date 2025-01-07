-- display the first 5 Rows

SELECT * 
FROM sample_superstore.sample_superstore
limit 5;

-- count null values in data

SELECT COUNT(*) as null_values_count
FROM sample_superstore.sample_superstore
WHERE 
    "Row ID" IS NULL AND 
    "Order ID" IS NULL AND 
    "Order Date" IS NULL AND 
    "Ship Date" IS NULL AND 
    "Ship Mode" IS NULL AND 
    "Customer ID" IS NULL AND 
    "Customer Name" IS NULL AND 
    "Segment" IS NULL AND 
    "Country" IS NULL AND 
    "City" IS NULL AND 
    "State" IS NULL AND 
    "Postal Code" IS NULL AND 
    "Region" IS NULL AND 
    "Product ID" IS NULL AND 
    "Category" IS NULL AND 
    "Sub-Category" IS NULL AND 
    "Product Name" IS NULL AND 
    "Sales" IS NULL AND 
    "Quantity" IS NULL AND 
    "Discount" IS NULL AND 
    "Profit" IS NULL;

-- check duplicate values in data

SELECT 
    "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", 
    "Customer ID", "Customer Name","Segment","Country","City", 
    "State","Postal Code","Region","Product ID","Category", 
    "Sub-Category","Product Name","Sales","Quantity","Discount","Profit", 
    COUNT(*) AS duplicate_values_count
FROM sample_superstore.sample_superstore
GROUP BY 
    "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", 
    "Customer ID", "Customer Name","Segment","Country","City", 
    "State","Postal Code","Region","Product ID","Category", 
    "Sub-Category","Product Name","Sales","Quantity","Discount","Profit"
HAVING COUNT(*) > 1;

-- Total sales and total profits of each year

SELECT sum(Sales) as total_sales,
sum(Profit) as total_profit, 
    year(DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m-%d')) AS extract_year
FROM sample_superstore.sample_superstore
group by extract_year
order by extract_year asc;

-- Region wise highest sales and profits

select Region,
sum(sales) as total_sales,
sum(profit) as total_profit
from sample_superstore.sample_superstore
group by Region
order by total_profit Desc;

-- Region wise profit margins

select Region,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore.sample_superstore
group by Region
order by profit_margin desc;

-- Top 10 state wise total_sales,total_profits and profit_margin

select state,sum(sales) as total_sales,sum(Profit) as total_profits,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore.sample_superstore
group by state
order by total_profits desc
limit 10;

-- state wise least profits and margin

select state,sum(sales) as total_sales,sum(Profit) as total_profits,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore.sample_superstore
group by state
order by total_profits asc
limit 10;

-- City wise highest total sales,total profits and profit margin

select City,sum(sales) as total_sales,sum(Profit) as total_profits,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore.sample_superstore
group by city
order by total_profits desc
limit 10;

-- City wise least total sales and profits 

select City,sum(sales) as total_sales,sum(Profit) as total_profits,
round((sum(profit)/sum(sales))*100,2) as profit_margin
from sample_superstore.sample_superstore
group by City
order by total_profits Asc
limit 10;

-- Relationship between discount and sales

select Discount,round(avg(Sales),2)as avg_sales
from sample_superstore.sample_superstore
group by Discount
order by Discount;

-- Categories wise total discount

Select Category,round(sum(Discount),2) as total_discount
from sample_superstore.sample_superstore
group by Category
order by total_discount desc;

-- find what type of products are the most discounted

SELECT Category,`Sub-Category`,ROUND(SUM(Discount), 2) AS Total_Discount
FROM sample_superstore.sample_superstore
GROUP BY Category, `Sub-Category`
ORDER BY Total_Discount Desc;

-- Categories wise total profit and profit margin

SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, 
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM sample_superstore.sample_superstore
GROUP BY category
ORDER BY total_profit DESC;

-- The highest total sales and total profits per Category in each region

SELECT region, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY region, category
ORDER BY total_profit DESC;

-- The highest total sales and total profits per Category in each state

SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY state, category
ORDER BY total_profit DESC;

-- The least total sales and total profits per Category in each state

SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY state, category
ORDER BY total_profit Asc;

-- Subcategory wise generates the highest sales,profits and profit margin

SELECT `Sub-Category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM sample_superstore.sample_superstore
GROUP BY `Sub-Category`
ORDER BY total_profit DESC;

-- The highest total sales and total profits per subcategory in each region

SELECT region, `Sub-Category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY region, `sub-category`
ORDER BY total_profit DESC;

-- The least total sales and total profits per subcategory in each region

SELECT region, `Sub-Category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY region, `sub-category`
ORDER BY total_profit Asc;

-- The highest total sales and total profits per subcategory in each state

SELECT state, `sub-category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY state, `sub-category`
ORDER BY total_profit DESC;

-- The least total sales and total profits per subcategory in each state

SELECT state, `sub-category`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY state, `sub-category`
ORDER BY total_profit Asc;

-- The names of the most profitable products

SELECT `Product Name`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY `product name`
ORDER BY total_profit DESC;

-- The names of the most least profitable products

SELECT `product name`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY `product name`
ORDER BY total_profit ASC;

-- What segment makes the most of our profits and sales.

SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY segment
ORDER BY total_profit DESC;

-- customers we have

SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM sample_superstore.sample_superstore;

-- Region wise customers we have 

SELECT region, COUNT(DISTINCT `customer id`) AS total_customers
FROM sample_superstore.sample_superstore
GROUP BY region
ORDER BY total_customers DESC;

-- State wise most customer we have

SELECT state, COUNT(DISTINCT `customer id`) AS total_customers
FROM sample_superstore.sample_superstore
GROUP BY state
ORDER BY total_customers desc;

-- State wise least customer we have

SELECT state, COUNT(DISTINCT `customer id`) AS total_customers
FROM sample_superstore.sample_superstore
GROUP BY state
ORDER BY total_customers asc;

-- . What customers loyal the most with us

SELECT `customer id`, 
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM sample_superstore.sample_superstore
GROUP BY `customer id`
ORDER BY total_sales DESc
LIMIT 15;

-- Average shiping time

SELECT ROUND(AVG(`ship date` - `order date`),1) AS avg_shipping_time
FROM sample_superstore.sample_superstore;

-- Average shiping time with ship mode

SELECT `ship mode`,ROUND(AVG(`ship date` - `order date`),1) AS avg_shipping_time
FROM sample_superstore.sample_superstore
GROUP BY `Ship Mode`
ORDER BY avg_shipping_time;