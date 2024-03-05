
DROP TABLE IF EXISTS student.h_offuture; -- drop old table


CREATE TABLE IF NOT EXISTS student.h_offuture ( -- create new table
	row_id             INT,           --was Row ID
	order_id           VARCHAR(200),  --was Order ID
	order_date         VARCHAR(200),  --was Order Date
	ship_date          VARCHAR (200), --was Ship Date
	ship_mode          VARCHAR (200), --was Ship Mode
	customer_id        VARCHAR (200), --was Customer ID
	customer_name      VARCHAR (200), --was Customer Name
	segment            VARCHAR (200), --was Segment
	city               VARCHAR (200), --was City
	state 			   VARCHAR (200), --was State
	country 		   VARCHAR (200), --was Country
	postal_code 	   INT,   	      --was Postal Code
	market 	 	       VARCHAR (200), --was Market
	region 		       VARCHAR (200), --was Region
	product_id 		   VARCHAR (200), --was Product ID
	category 		   VARCHAR (200), --was Category
	sub_category 	   VARCHAR (200), --was Sub-Category
	product_name 	   VARCHAR (200), --was Product Name
	sales 	 		   FLOAT,		  --was Sales
	quantity 		   INT, 		  --was Quantity
	discount 		   FLOAT,		  --was Discount
	profit 		       FLOAT,		  --was Profit
	shipping_cost 	   FLOAT,        --was Shipping Cost
	order_priority     VARCHAR (200) --was Order Priority 
) ;

GRANT ALL -- grant access to team
ON 
	student.h_offuture 
TO 
	da_kaki,
	de_roja,
	da_elva,
	da_fago,
	da_besa;


-- Columns appear to be a well formatted date type
ALTER TABLE student.h_offuture  
	ALTER COLUMN order_date TYPE DATE
		USING to_date(order_date, 'DD/MM/YYYY'),
	ALTER COLUMN ship_date TYPE DATE
		USING to_date(ship_date, 'DD/MM/YYYY');

-- Create an enum type
CREATE TYPE student.enum_order_priority AS ENUM ('Critical', 'High', 'Medium', 'Low');

-- Set column to new enum type
ALTER TABLE student.h_offuture 
	ALTER COLUMN order_priority TYPE student.enum_order_priority
		USING order_priority::student.enum_order_priority;

	
SELECT 
	*
FROM 
	student.h_offuture ho ;
	
-- Table created, time to explore!
