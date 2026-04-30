-- 1. A query with a function (Week 6)
-- Calculate the minimum and the maximum of the total_amount column and the total amount (sum all the orders) that were paid with credit card
SELECT MIN(Total_amount) AS Min_paid, 
	MAX(Total_amount) AS Max_paid, 
    SUM(Total_amount) AS Total_in_orders
FROM orders;

-- 2. A query with an inner join (week 7)
-- Display the ingredients of the Classic Pepperoni
SELECT i.Ingredient_name AS Topping_or_Ingredient
FROM Base_Pizzas bp
JOIN Recipes r ON r.Pizza_id = bp.Pizza_id
JOIN Ingredients i ON i.Ingredient_id = r.Ingredient_id
WHERE bp.Pizza_name LIKE 'Classic Pepperoni'
ORDER BY i.Ingredient_name;

-- 3. A query with conditional logic (week 8)
-- Identify if an order is either big or small by comparing the total amount. Display the customer name with the statement
-- if the order was big, medium, or small, the total_amount, and the name of the employee that did the order
SELECT CONCAT(c.First_name, " ", c.Last_name) AS Customer_name,
		CASE
			WHEN o.Total_amount > 30 THEN "Big order"
			WHEN o.Total_amount > 15 THEN "Medium order"
            ELSE "Small order" END AS Order_size,
		o.Total_amount,
        e.First_name AS Employee_name
FROM Orders AS o
INNER JOIN Customers AS c USING(Customer_id)
INNER JOIN Employees AS e USING(Employee_id);

-- 4. A query with an outer join (week 9)
-- list all inigredients and the recipies that are not used in select every ingredient and attempts to match it to a recipes entry.
-- check all the nulls in the recipes column
SELECT i.Ingredient_name, r.Recipe_id
FROM Ingredients i 
LEFT JOIN Recipes r ON i.Ingredient_id = r.Ingredient_id
WHERE r.Recipe_id IS NULL 
ORDER BY i.Ingredient_name ASC;

-- 5. A query with an aggregate function and GROUP BY (week 10)
-- List all pizzas sold with the total sold for each pizza. use sum a in the price_at_sale, group by with pizza_id 
-- and display the name of the pizza
SELECT od.Pizza_id,
    bp.Pizza_name,
    SUM(od.Quantity) AS Total_pizzas,
    SUM(od.Quantity * od.Price_at_sale) AS Total_sold
FROM Order_details AS od
LEFT JOIN Base_Pizzas AS bp USING (Pizza_id)
GROUP BY od.Pizza_id, bp.Pizza_name;

-- 6. A query using a subquery (week 11)
-- Write a query to determine the top 5 pizzas by total revenue generated.
WITH Total_revenue AS (
	SELECT Pizza_id, SUM(Quantity * Price_at_sale) AS Total_revenue
    FROM Order_details
    GROUP BY Pizza_id
)
SELECT bp.Pizza_name, tr.Total_revenue
FROM Total_revenue tr 
JOIN Base_Pizzas bp USING(Pizza_id)
ORDER BY Total_revenue DESC;

-- 7. A query with a window function (week 12)
-- Calculate the cumulative total of the ingredient quantity for each pizza
SELECT 
	bp.Pizza_name,
    i.Ingredient_name,
    r.Ingredient_quantity,
    SUM(r.Ingredient_quantity) OVER(PARTITION BY r.Pizza_id ORDER BY r.Ingredient_id) AS Total_ingredients
FROM Recipes r
JOIN Base_Pizzas bp USING(Pizza_id)
JOIN Ingredients i USING(Ingredient_id)
ORDER BY bp.Pizza_name, r.Ingredient_id;

