Create Or Refresh Materialized View cn_daily_customer_books
Comment "Daily number of books per customer in China"
As
	Select customer_id, f_name, l_name, date_trunc("DD", order_timestamp) order_date, sum(quantity) books_counts
	From orders_cleaned
	Where country = "China"
	Group By customer_id, f_name, l_name, date_trunc("DD", order_timestamp)