SELECT * FROM coffee;
ALTER TABLE coffee
drop column  card ;

ALTER TABLE coffee
MODIFY COLUMN `date` DATE,
MODIFY COLUMN `datetime` DATETIME;

ALTER TABLE coffee
MODIFY COLUMN `datetime` TIME;

with cte as (select extract(year from `date`) as year ,extract(month from `date`) as month , extract(day from `date`) as day 

, DAYNAME(`date`) AS day_name,`datetime`, cash_type,coffee_name,money from coffee )

select year,month,day,day_name,`datetime`,
 cash_type,coffee_name,money,
sum(money) over (order by  year,month,day,day_name,`datetime`) as cumulative_revenue

 from cte ;


CREATE VIEW Momo_CoffeeShop_Report AS

WITH cte AS (
  SELECT 
    `date`,
    EXTRACT(YEAR FROM `date`) AS year,
    EXTRACT(MONTH FROM `date`) AS month,
    EXTRACT(DAY FROM `date`) AS day,
    DAYNAME(`date`) AS day_name,
    `datetime`,
    cash_type,
    coffee_name,
    money
  FROM coffee
)

SELECT 
  year,
  month,
  day,
  day_name,
  `datetime`,
  cash_type,
  coffee_name,
  money,
  ROUND(SUM(money) OVER (
    PARTITION BY `date`
    ORDER BY `datetime`
  ),2) AS daily_cumulative_revenue,ROUND(SUM(money) OVER (PARTITION BY `date`),2) AS total_revenue_for_day

FROM cte ;






