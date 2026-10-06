Create or Refresh Streaming Table orders_cleaned (
	Constraint positive_quantity Expect (quantity > 0) On Violation Drop Row, 
	Constraint valid_customer Expect (f_name Is not null and l_name is not null) on Violation Fail Update,
	Constraint recent_order Expect (order_timestamp >= "2022-07-15")
)	
Comment "The cleaned books orders with valid order_id"
As
	Select order_id, quantity, o.customer_id, c.profile:first_name as f_name, c.profile:last_name as l_name, 
	cast(from_unixtime(order_timestamp, 'yyyy-MM-dd HH:mm:ss') As timestamp) order_timestamp, o.books, 
	c.profile:address:country as country
From Stream orders_raw o
Left Join customers c
On o.customer_id = c.customer_id;