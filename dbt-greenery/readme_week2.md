(Part 1) Models
What is our user repeat rate?
 79.23%

 What are good indicators of a user who will likely purchase again?
- lead_time between the order creation and the delivery
- frustration_time between the delivery date and the estimated delivery
- number of orders made because of a promotion
- number of order made because of special events (xMas, Black Friday)
- number of visits before committing on a purchase
- average cart/order cost amount
 
 What about indicators of users who are likely NOT to purchase again?
- lead_time being greather than the average lead_time
- frustation_time being greather than the average frustration_time
- shipping service used
- number of visits to the website

(Part 2) Tests

What assumptions are you making about each model? (i.e. why are you adding each test?)

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
Yes:
- orders without order items
- orders with an order_total != order_cost + shipping cost
