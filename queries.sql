/*check for abnormalities in the sales_qty column*/
SELECT t.sales_qty
FROM transactions t
WHERE sales_qty <= 0;

/*check the currency column*/
SELECT DISTINCT t.currency
FROM transactions t;

/*find the most used currencies*/
SELECT DISTINCT count(t.currency)
FROM transactions t
WHERE t.currency IN ('INR\r','USD\r');

/*query the database accordingly*/
SELECT 
    t.sales_qty, t.sales_amount, t.order_date, t.product_code, c.custmer_name, c.customer_type, m.markets_name,
    CASE
		WHEN t.currency = 'USD\r' THEN t.sales_amount * 75	/*convert USD to INR*/
        ELSE t.sales_amount
	END AS normalized_sales_amount
FROM
    transactions t
        INNER JOIN
    markets m ON m.markets_code = t.market_code
		INNER JOIN
	customers c ON c.customer_code = t.customer_code
WHERE
    t.currency IN ('INR\r' , 'USD\r')
        AND t.sales_amount > 0;

/* saving the exported table so i can query it to confirm the accuracy of my dashboard */
CREATE VIEW exported_table AS
SELECT 
    t.sales_qty, t.sales_amount, t.order_date, t.product_code, c.custmer_name, c.customer_type, m.markets_name,
    CASE
		WHEN t.currency = 'USD\r' THEN t.sales_amount * 75	/*convert USD to INR*/
        ELSE t.sales_amount
	END AS normalized_sales_amount
FROM
    transactions t
        INNER JOIN
    markets m ON m.markets_code = t.market_code
		INNER JOIN
	customers c ON c.customer_code = t.customer_code
WHERE
    t.currency IN ('INR\r' , 'USD\r')
        AND t.sales_amount > 0;


