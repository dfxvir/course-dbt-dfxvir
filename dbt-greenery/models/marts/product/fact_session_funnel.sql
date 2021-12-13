{{
    config(
        materialized = 'table'
    )
}}

select 
count(distinct session_id),
count(case when (count_of_page_view >0 or count_of_add_to_cart >0 or count_of_checkout >0) then 1 end) as lev1,
count(case when (count_of_add_to_cart >0 or count_of_checkout >0) then 1 end) as lev2,
count(case when (count_of_checkout >0) then 1 end) as lev3
from {{ ref('fact_session_events') }}