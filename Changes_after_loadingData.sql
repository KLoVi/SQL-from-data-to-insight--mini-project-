USE sales_supermarket;

ALTER TABLE supermarket_sales
DROP COLUMN supermarket_salescol;

select * from supermarket_sales;

ALTER TABLE supermarket_sales
MODIFY COLUMN invoice_id VARCHAR(45);
