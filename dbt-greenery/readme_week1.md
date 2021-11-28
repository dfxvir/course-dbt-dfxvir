How many users do we have?

Select count(*) from public.users;
>130

On average, how many orders do we receive per hour?
select avg(count) from (Select extract(hour from a.created_at) as hour, count(a.order_id) as count from public.orders a group by hour order by 1) b
>16

On average, how long does an order take from being placed to being delivered?
select avg(delivered_at - created_at) from orders
>{
  "days": 3,
  "hours": 22,
  "minutes": 13,
  "seconds": 10,
  "milliseconds": 504.451
}

How many users have only made one purchase? Two purchases? Three+ purchases?

select purchase_grp, count(user_id) from (
select user_id, CASE WHEN purchase<3 THEN purchase::varchar else '+3' end purchase_grp from(
select user_id, count(order_id) as purchase from orders group by user_id) a)b group by purchase_grp
>2	22	
+3	81	
1	25

On average, how many unique sessions do we have per hour?
select avg(unique_session) from (
select extract(hour from a.created_at),  count (distinct a.session_id) unique_session from events a group by extract(hour from a.created_at))b
>120.56