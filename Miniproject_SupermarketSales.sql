USE sales_supermarket;

# retrieve per product line the total: amount and quantity. Besides a general price/unit
# the values are very similar for the 6 product lines
# Food and beverages has the highest value in total amount 56,145 and average 59 price/unit
SELECT product_line, SUM(quantity) AS "total QTY", FORMAT(SUM(total),0) AS "total $" , round(SUM(total)/SUM(quantity),0) AS "avg price/unit"
FROM supermarket_sales
GROUP BY product_line
ORDER BY SUM(total) DESC;

# Food and beverages has the highest value in total amount 56,145 and average 59 price/unit; with QUERY:
SELECT product_line, SUM(quantity) AS "total QTY", FORMAT(SUM(total),0) AS "total $" , round(SUM(total)/SUM(quantity),0) AS "avg price/unit"
FROM supermarket_sales
GROUP BY product_line
HAVING SUM(total) = (SELECT MAX(total_sum) 
						FROM (SELECT SUM(total) AS total_sum
								FROM supermarket_sales
								GROUP BY product_line) AS subquery);

# Health and Beauty has the lower value in total amount 49,194 and average 58 price/unit
SELECT product_line, SUM(quantity) AS "total QTY", FORMAT(SUM(total),0) AS "total $" , round(SUM(total)/SUM(quantity),0) AS "avg price/unit"
FROM supermarket_sales
GROUP BY product_line
HAVING SUM(total) = (SELECT MIN(total_sum) 
						FROM (SELECT SUM(total) AS total_sum
								FROM supermarket_sales
								GROUP BY product_line) AS subquery);


# Check the spectrum of dates, it is from 10:00 to 20:59
SELECT time  
FROM supermarket_sales
ORDER BY time;

# Divide in ranges the time in 5 parts, 2 hours between each one.
SELECT time, 
CASE
	WHEN time >= "10:00" AND time < "12:00" THEN "morning"
	WHEN time >= "12:00" AND time < "14:00" THEN "middday"
	WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
	WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
	ELSE "evening"
END AS range_time
FROM supermarket_sales
ORDER BY time;

# after the range division, we sum the amount (in quantity and money) for each defined time range.
# most of the sales are during the  EVENING (from 18:00 to 21:00) with 88,699
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
GROUP BY range_time
ORDER BY SUM(total) DESC;

# check the names of the 6 product's lines to apply as a filter and see the behavior of sales per product line
# according to a specif time range during the day

SELECT DISTINCT product_line  
FROM supermarket_sales;
# "Food and beverages" , "Health and beauty", "Sports and travel", 
# "Fashion accesories", "Home and lifestyle" , "Electronic accessories"

# "Food and beverages": most sales during THE EVENING (19,160)
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
WHERE product_line = "Food and beverages"
GROUP BY range_time
ORDER BY SUM(total)DESC;

#"Health and beauty": most sales during THE EVENING (13,074)
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
WHERE product_line = "Health and beauty"
GROUP BY range_time
ORDER BY SUM(total) DESC;


# "Sports and travel": most sales during THE EVENING (13,913)
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
WHERE product_line = "Sports and travel"
GROUP BY range_time
ORDER BY SUM(total) DESC;

#"Fashion accesories": most sales during MIDDAY (13,060)
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
WHERE product_line = "Fashion accessories"
GROUP BY range_time
ORDER BY SUM(total) DESC;

# "Home and lifestyle": most sales during MORNING (12,388)
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
WHERE product_line = "Home and lifestyle"
GROUP BY range_time
ORDER BY SUM(total) DESC;


#"Electronic accesories": most sales during EVENING (17,821)
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    SUM(quantity) AS total_quantity,
    FORMAT(SUM(total),0) AS total_sales
FROM supermarket_sales
WHERE product_line = "Electronic accessories"
GROUP BY range_time
ORDER BY SUM(total) DESC;


# Check GENDER by range time: 

# Gender: "Male" and "Female"
SELECT DISTINCT gender
FROM supermarket_sales;

# men are buying mainly in the EVENING 19-21 followed by EARLY AFTERNOON 14-16
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    COUNT(gender) AS "male"
FROM supermarket_sales
WHERE gender = "male" 
GROUP BY range_time
ORDER BY COUNT(gender) DESC;


# women are buying mainly in the EVENING 19-21 followed by MORNING 10-12
SELECT
	CASE
		WHEN time >= "10:00" AND time < "12:00" THEN "morning"
		WHEN time >= "12:00" AND time < "14:00" THEN "middday"
		WHEN time >= "14:00" AND time < "16:00" THEN "early_afternoon"
		WHEN time >= "16:00" AND time < "18:00" THEN "late_afternoon"
		ELSE "evening"
	END AS range_time,
    COUNT(gender) AS "female"
FROM supermarket_sales
WHERE gender = "female" 
GROUP BY range_time
ORDER BY COUNT(gender) DESC;

# WITH CHATGPT, TO HAVE BOTH COUNT ON THE SAME TABLE: 

### FOR THE PRESENTATION:

# GRAPHIC PRESENTATION!!! QTY: TIME RANGE PER GENDER
# EVENING IS THE WHERE MEN AND WOMEN BUY MORE, FOLLOWED BY EARLY AFTERNOON FOR MEN AND MORNING FOR WOMEN
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


# GRAPHIC PRESENTATION!!! AMOUNT: TIME RANGE PER GENDER
# MORE SALES (AMOUNT) FROM MEN AND WOMEN IN THE THE EVENING
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


# GENDER BY CATEGORY -AMOUNT- GRAPHIC
# GRAPHIC PRESENTATION!!! AMOUNT: GENDER PER PRODUCT LINE
# MALE BUY MORE "HEALTH AND BEAUTY", FEMALE BUY MORE "FOOD AND BEVERAGES"
SELECT product_line, 
	FORMAT(SUM(CASE WHEN gender = 'male' THEN total ELSE 0 END),0) AS "male", 
	FORMAT(SUM(CASE WHEN gender = 'female' THEN total ELSE 0 END),0) AS "female"
FROM supermarket_sales
GROUP BY product_line;


# GRAPHIC PRESENTATION !
# FOR A HEATMAP COMBINING TIME RAGE VERSUS PRODUCT LINE (AMOUNT)
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

