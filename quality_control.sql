-- Data Quality Control Implementation Document -- 

-- H_01 
-- Count of rows
SELECT 
	COUNT(*)
FROM 
	student.h_offuture ho ;
 
-- H_02 
-- Count of columns
SELECT 
	COUNT(*) AS column_count
FROM 
	information_schema.columns
WHERE 
	table_schema = 'student'
    AND table_name = 'h_offuture' ;
   
-- H_03 
-- Count of duplicate rows
SELECT  
	COUNT(row_id) - COUNT(DISTINCT(row_id))
FROM 
	student.h_offuture ho ;

-- H_04
-- Query to calculate the sum of row sums 
SELECT 
	SUM(row_total) AS total_sum
FROM (
    SELECT (
        COALESCE(row_id, 0) + 
        COALESCE(postal_code, 0) + 
        COALESCE(sales, 0) + 
        COALESCE(quantity, 0) + 
        COALESCE(discount, 0) + 
        COALESCE(profit, 0) + 
        COALESCE(shipping_cost, 0)
    ) AS row_total
    FROM student.h_offuture
) AS subquery;

-- H_05
-- Query to calculate the sum of column sums 
SELECT 
      ROUND(SUM(row_id)
    + SUM(postal_code) 
    + SUM(sales)
    + SUM(quantity)
    + SUM(discount)
    + SUM(profit)
    + SUM(shipping_cost)) sum_of_columns
FROM 
    student.h_offuture ho ;
   
-- H_06 
-- Date format check
-- Query 1 selects column name and data type for every column.
-- This allows us to check that columns order_date and ship_date are formatted as DATE type.
SELECT 
	column_name, data_type
FROM 
	information_schema.columns
WHERE 
	table_schema = 'student' AND table_name = 'h_offuture' ;
-- Query 2 checks the values of date columns for a set of random IDs, so they can be crosschecked with source data.
SELECT 
	row_id,
	order_date,
	ship_date
FROM 
	student.h_offuture
WHERE 
	row_id IN (49, 756, 50384, 25003, 39201) ;

-- H_07
-- Random column eyeball check
SELECT 
	*
FROM 
	student.h_offuture ho
ORDER BY 
	RANDOM()
LIMIT 
	5 ;
   
-- H_08
-- Count of Nulls
SELECT
	SUM(CASE WHEN ho.row_id  is NULL THEN 1 ELSE 0 END) as row_id,
	SUM(CASE WHEN ho.order_id is NULL THEN 1 ELSE 0 END) as order_id ,
	SUM(CASE WHEN ho.order_date  is NULL THEN 1 ELSE 0 END) as order_date ,
	SUM(CASE WHEN ho.ship_date  is NULL THEN 1 ELSE 0 END) as ship_date,
	SUM(CASE WHEN ho.ship_mode  is NULL THEN 1 ELSE 0 END) as ship_mode,
	SUM(CASE WHEN ho.customer_id  is NULL THEN 1 ELSE 0 END) as customer_id ,
	SUM(CASE WHEN ho.customer_name  is NULL THEN 1 ELSE 0 END) as customer_name ,
	SUM(CASE WHEN ho.segment  is NULL THEN 1 ELSE 0 END) as segment ,
	SUM(CASE WHEN ho.city  is NULL THEN 1 ELSE 0 END) as city,
	SUM(CASE WHEN ho.state  is NULL THEN 1 ELSE 0 END) as state ,
	SUM(CASE WHEN ho.country  is NULL THEN 1 ELSE 0 END) as country ,
	SUM(CASE WHEN ho.postal_code  is NULL THEN 1 ELSE 0 END) as postal_code ,
	SUM(CASE WHEN ho.market  is NULL THEN 1 ELSE 0 END) as market ,
	SUM(CASE WHEN ho.region  is NULL THEN 1 ELSE 0 END) as region,
	SUM(CASE WHEN ho.product_id  is NULL THEN 1 ELSE 0 END) as product_id ,
	SUM(CASE WHEN ho.category  is NULL THEN 1 ELSE 0 END) as category ,
	SUM(CASE WHEN ho.sub_category  is NULL THEN 1 ELSE 0 END) as sub_category ,
	SUM(CASE WHEN ho.product_name  is NULL THEN 1 ELSE 0 END) as product_name ,
	SUM(CASE WHEN ho.sales  is NULL THEN 1 ELSE 0 END) as sales ,
	SUM(CASE WHEN ho.quantity  is NULL THEN 1 ELSE 0 END) as quantity ,
	SUM(CASE WHEN ho.discount  is NULL THEN 1 ELSE 0 END) as discount ,
	SUM(CASE WHEN ho.profit  is NULL THEN 1 ELSE 0 END) as profit,
	SUM(CASE WHEN ho.shipping_cost  is NULL THEN 1 ELSE 0 END) as shipping_cost ,
	SUM(CASE WHEN ho.order_priority  is NULL THEN 1 ELSE 0 END) as order_priority
FROM student.h_offuture ho ;

-- H_09
-- Checking spaces before or after strings
SELECT 
	LENGTH(order_id) - LENGTH(TRIM(order_id)) AS spaces_order_id,
	LENGTH(ship_mode) - LENGTH(TRIM(ship_mode)) AS spaces_ship_mode,
	LENGTH(customer_id) - LENGTH(TRIM(customer_id)) AS spaces_customer_id,
	LENGTH(customer_name) - LENGTH(TRIM(customer_name)) AS spaces_customer_name,
	LENGTH(segment) - LENGTH(TRIM(segment)) AS spaces_segment,
	LENGTH(city) - LENGTH(TRIM(city)) AS spaces_city,
	LENGTH(state) - LENGTH(TRIM(state)) AS spaces_state,
	LENGTH(country) - LENGTH(TRIM(country)) AS spaces_country,
	LENGTH(market) - LENGTH(TRIM(market)) AS spaces_market,
	LENGTH(region) - LENGTH(TRIM(region)) AS spaces_region,
	LENGTH(product_id) - LENGTH(TRIM(product_id)) AS spaces_product_id,
	LENGTH(category) - LENGTH(TRIM(category)) AS spaces_category,
	LENGTH(sub_category) - LENGTH(TRIM(sub_category)) AS spaces_sub_category,
	LENGTH(product_name) - LENGTH(TRIM(product_name)) AS spaces_product_name
FROM 
     student.h_offuture 
WHERE 
	LENGTH(segment)-LENGTH(TRIM(segment))>0 AND 
	LENGTH(city)-LENGTH(TRIM(city))>0 AND 
	LENGTH(state)-LENGTH(TRIM(state))>0 AND 
	LENGTH(country)-LENGTH(TRIM(country))>0 AND 
	LENGTH(market)-LENGTH(TRIM(market))>0 AND 
	LENGTH(region)-LENGTH(TRIM(region))>0 AND 
	LENGTH(product_id)-LENGTH(TRIM(product_id))>0 AND 
	LENGTH(category)-LENGTH(TRIM(category))>0 AND 
	LENGTH(sub_category)-LENGTH(TRIM(sub_category))>0 AND 
	LENGTH(product_name)-LENGTH(TRIM(product_name))>0 ;

--Code used to generate full SELECT set as seen above.
/* 
SELECT
	'LENGTH(' || column_name || ') - LENGTH(TRIM(' || column_name || ')) AS spaces_'|| column_name ||','
FROM 
	information_schema.COLUMNS
WHERE 
	TABLE_schema = 'student' AND 
	table_name = 'h_offuture' AND 
	data_type IN ('character varying') ; 
 
-- Code used to generate full WHERE set as seen above.  
SELECT
	'LENGTH(' || column_name || ') - LENGTH(TRIM(' || column_name || ')) >0 AND'
FROM 
	information_schema.COLUMNS
WHERE 
	TABLE_schema = 'student' AND 
	table_name = 'h_offuture' AND 
	data_type IN ('character varying') ;
*/

-- H_10
-- Numerical columns SUM/MIN/MAX/AVG. 
SELECT
	SUM(row_id) AS sum_of_row_id , MIN(row_id) AS min_row_id , MAX(row_id) AS max_row_id, AVG(row_id) AS avg_row_id ,
	SUM(postal_code) AS sum_of_postal_code , MIN(postal_code) AS min_postal_code , MAX(postal_code) AS max_postal_code, AVG(postal_code) AS avg_postal_code ,
	SUM(sales) AS sum_of_sales , MIN(sales) AS min_sales , MAX(sales) AS max_sales, AVG(sales) AS avg_sales ,
	SUM(quantity) AS sum_of_quantity , MIN(quantity) AS min_quantity , MAX(quantity) AS max_quantity, AVG(quantity) AS avg_quantity ,
	SUM(discount) AS sum_of_discount , MIN(discount) AS min_discount , MAX(discount) AS max_discount, AVG(discount) AS avg_discount ,
	SUM(profit) AS sum_of_profit , MIN(profit) AS min_profit , MAX(profit) AS max_profit, AVG(profit) AS avg_profit ,
	SUM(shipping_cost) AS sum_of_shipping_cost , MIN(shipping_cost) AS min_shipping_cost , MAX(shipping_cost) AS max_shipping_cost, AVG(shipping_cost) AS avg_shipping_cost
FROM 
	student.h_offuture ;

-- Code used to generate full SELECT set as seen above.
/*
SELECT
	'SUM(' || column_name || ') AS sum_of_' || column_name || ' , MIN(' || column_name || ') AS min_' || column_name ||' , MAX(' || column_name || ') AS max_'|| column_name ||
 	', AVG(' || column_name || ') AS avg_' || column_name || ' ,'
FROM 
	information_schema.COLUMNS
WHERE 
	TABLE_schema = 'student' AND 
	table_name = 'h_offuture' AND 
 	data_type IN ('integer', 'numeric', 'double precision') ;
 */

-- H_11
-- VARCHAR columns MIN/MAX length.
SELECT 
    MIN(LENGTH(order_id)) AS min_order_id, MAX(LENGTH(order_id)) AS max_order_id, 
	MIN(LENGTH(ship_mode)) AS min_ship_mode, MAX(LENGTH(ship_mode)) AS max_ship_mode, 
	MIN(LENGTH(customer_id)) AS min_customer_id, MAX(LENGTH(customer_id)) AS max_customer_id, 
	MIN(LENGTH(customer_name)) AS min_customer_name, MAX(LENGTH(customer_name)) AS max_customer_name, 
	MIN(LENGTH(segment)) AS min_segment, MAX(LENGTH(segment)) AS max_segment, 
	MIN(LENGTH(city)) AS min_city, MAX(LENGTH(city)) AS max_city, 
	MIN(LENGTH(state)) AS min_state, MAX(LENGTH(state)) AS max_state, 
	MIN(LENGTH(country)) AS min_country, MAX(LENGTH(country)) AS max_country, 
	MIN(LENGTH(market)) AS min_market, MAX(LENGTH(market)) AS max_market, 
	MIN(LENGTH(region)) AS min_region, MAX(LENGTH(region)) AS max_region, 
	MIN(LENGTH(product_id)) AS min_product_id, MAX(LENGTH(product_id)) AS max_product_id, 
	MIN(LENGTH(category)) AS min_category, MAX(LENGTH(category)) AS max_category, 
	MIN(LENGTH(sub_category)) AS min_sub_category, MAX(LENGTH(sub_category)) AS max_sub_category, 
	MIN(LENGTH(product_name)) AS min_product_name, MAX(LENGTH(product_name)) AS max_product_name 
FROM 
    student.h_offuture ;
   
-- Code used to generate full SELECT set as seen above.
/*
SELECT
	'MIN(LENGTH(' || column_name || ')) AS min_'|| column_name ||', MAX(LENGTH(' || column_name || ')) AS max_'|| column_name ||', '
FROM 
	information_schema.COLUMNS
WHERE 
	TABLE_schema = 'student' AND 
	table_name = 'h_offuture' AND 
	data_type IN ('character varying') ;
*/
   
-- H_12 
-- DATE columns MIN/MAX
SELECT 
    MIN(order_date) AS min_order_date, MAX(order_date) AS max_order_date, 
	MIN(ship_date) AS min_ship_date, MAX(ship_date) AS max_ship_date
FROM 
	student.h_offuture ;
   