USE supermarket_sales;

# TO CREATE VIEWS:

# TIME RANGE PER GENDER PER VISIT TO THE SUPERMARKET :
# AT EVENING MEN AND WOMEN BUY MORE, FOLLOWED BY EARLY AFTERNOON FOR MEN AND MORNING FOR WOMEN

CREATE VIEW qty_time_per_gender AS 
SELECT
    CASE
        WHEN time >= '10:00' AND time < '12:00' THEN 'morning'
        WHEN time >= '12:00' AND time < '14:00' THEN 'midday'
        WHEN time >= '14:00' AND time < '16:00' THEN 'early_afternoon'
        WHEN time >= '16:00' AND time < '18:00' THEN 'late_afternoon'
        ELSE 'evening'
    END AS range_time,
    COUNT(CASE WHEN gender = 'male' THEN 1 END) AS "male",
    COUNT(CASE WHEN gender = 'female' THEN 1 END) AS "female" 
FROM supermarket_sales
GROUP BY range_time
ORDER BY COUNT(CASE WHEN gender = 'male' THEN 1 END) DESC; 


# TIME RANGE PER GENDER PER AMOUNT BOUGHT: 
# MORE SALES (AMOUNT) FROM MEN AND WOMEN IN THE THE EVENING

CREATE VIEW amount_time_per_gender AS 
SELECT
    CASE
        WHEN time >= '10:00' AND time < '12:00' THEN '01_morning'
        WHEN time >= '12:00' AND time < '14:00' THEN '02_midday'
        WHEN time >= '14:00' AND time < '16:00' THEN '03_early_afternoon'
        WHEN time >= '16:00' AND time < '18:00' THEN '04_late_afternoon'
        ELSE '05_evening'
    END AS range_time,
    FORMAT(SUM(CASE WHEN gender = 'male' THEN total ELSE 0 END),0) AS "male", #CHATGPT SUGGESTION
    FORMAT(SUM(CASE WHEN gender = 'female' THEN total ELSE 0 END),0) AS "female" #CHATGPT SUGGESTION
FROM supermarket_sales
GROUP BY range_time
ORDER BY range_time; 


# AMOUNT: GENDER PER PRODUCT LINE
# MALE BUY MORE "HEALTH AND BEAUTY", FEMALE BUY MORE "FOOD AND BEVERAGES"

CREATE VIEW amount_products_per_gender AS 
SELECT product_line, 
	FORMAT(SUM(CASE WHEN gender = 'male' THEN total ELSE 0 END),0) AS "male", 
	FORMAT(SUM(CASE WHEN gender = 'female' THEN total ELSE 0 END),0) AS "female"
FROM supermarket_sales
GROUP BY product_line;


# FOR A HEATMAP COMBINING: TIME RANGE VERSUS PRODUCT LINE (AMOUNT)
CREATE VIEW amount_products_per_time AS 
SELECT
    CASE
        WHEN time >= '10:00' AND time < '12:00' THEN '01_morning'
        WHEN time >= '12:00' AND time < '14:00' THEN '02_midday'
        WHEN time >= '14:00' AND time < '16:00' THEN '03_early_afternoon'
        WHEN time >= '16:00' AND time < '18:00' THEN '04_late_afternoon'
        ELSE '05_evening'
    END AS range_time,
    FORMAT(SUM(CASE WHEN product_line = "Food and beverages" THEN total ELSE 0 END),0) AS "food_beverages",
	FORMAT(SUM(CASE WHEN product_line = "Health and beauty" THEN total ELSE 0 END),0) AS "health_beauty",
    FORMAT(SUM(CASE WHEN product_line = "Sports and travel" THEN total ELSE 0 END),0) AS "sports_travel",
    FORMAT(SUM(CASE WHEN product_line = "Fashion accessories" THEN total ELSE 0 END),0) AS "fashion_accessories",
    FORMAT(SUM(CASE WHEN product_line = "Home and lifestyle" THEN total ELSE 0 END),0) AS "home_lifestyle",
    FORMAT(SUM(CASE WHEN product_line = "Electronic accessories" THEN total ELSE 0 END),0) AS "electronic_accesories"
FROM supermarket_sales
GROUP BY range_time
ORDER BY range_time;



