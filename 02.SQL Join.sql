/*Try pulling all the data from the accounts table, and all the data from the orders table.*/
SELECT accounts.*, orders.*
FROM accounts
JOIN orders ON accounts.id = accounts.id;

/*Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.*/
SELECT orders.standard_qty, orders.gloss_qty, 
       orders.poster_qty,  accounts.website, 
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id


/*Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/
SELECT name, primary_poc, occurred_at, channel
FROM accounts
JOIN web_events ON accounts.id = web_events.account_id
WHERE accounts.name LIKE '%Walmart%';

/*Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name AS region_name, sales_reps.name AS sales_rep_name, accounts.name AS account_name
FROM region
JOIN sales_reps ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
ORDER BY 3;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.*/
SELECT orders.id,region.name AS region_name, accounts.name AS account_name,(total_amt_usd/total+0.01) AS unit_price
FROM orders
JOIN accounts ON orders.account_id = accounts.id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON region.id = sales_reps.region_id;

/*--------------------------------------------*/

/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name AS region_name, sales_reps.name AS sales_rep_name, accounts.name AS account_name
FROM region
JOIN sales_reps ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
WHERE region.name LIKE 'Midwest'
ORDER BY 3;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name AS region_name, sales_reps.name AS sales_rep_name, accounts.name AS account_name
FROM region
JOIN sales_reps ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
WHERE region.name LIKE 'Midwest'
	AND LOWER(sales_reps.name) LIKE 's%'
ORDER BY 3;

/*Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT region.name AS region_name, sales_reps.name AS sales_rep_name, accounts.name AS account_name
FROM region
JOIN sales_reps ON region.id = sales_reps.region_id
JOIN accounts ON accounts.sales_rep_id = sales_reps.id
WHERE region.name LIKE 'Midwest'
	AND LOWER(sales_reps.name) LIKE '% k%'
ORDER BY 3;


/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*/
SELECT orders.id,region.name AS region_name, accounts.name AS account_name,total_amt_usd/(total+0.01) AS unit_price
FROM orders
JOIN accounts ON orders.account_id = accounts.id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON region.id = sales_reps.region_id
WHERE standard_qty > 100;


/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
*/
SELECT orders.id,region.name AS region_name, accounts.name AS account_name,total_amt_usd/(total+0.01) AS unit_price
FROM orders
JOIN accounts ON orders.account_id = accounts.id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON region.id = sales_reps.region_id
WHERE standard_qty > 100
	AND poster_qty > 50
ORDER BY unit_price;

/*Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/
SELECT orders.id,region.name AS region_name, accounts.name AS account_name,total_amt_usd/(total+0.01) AS unit_price
FROM orders
JOIN accounts ON orders.account_id = accounts.id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON region.id = sales_reps.region_id
WHERE standard_qty > 100
	AND poster_qty > 50
ORDER BY unit_price DESC;

/*What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.*/
SELECT DISTINCT accounts.name, web_events.channel
FROM accounts
JOIN web_events ON accounts.id = web_events.account_id
WHERE accounts.id = 1001;

/*Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.*/
SELECT occurred_at, accounts.name AS account_name, total AS order_total, total_amt_usd
FROM orders
JOIN accounts ON accounts.id = orders.account_id
WHERE occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY occurred_at DESC;