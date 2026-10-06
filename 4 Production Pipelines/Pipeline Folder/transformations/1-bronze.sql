Create Or Refresh Streaming Table orders_raw
Comment "The raw books orders, ingested from orders-raw"
As Select * From Stream read_files("${dataset_path}/orders-json-raw",
	format => 'json',
	inferColumnTypes => true);

Create Or Refresh Materialized View customers
Comment "The customer lookup table, ingested from customers-json"
As Select * From read_files("${dataset_path}/customers-json", 
	format => 'json',
	inferColumnTypes => true);