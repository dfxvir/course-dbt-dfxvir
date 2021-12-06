### Questions 

## What is our overall conversion rate?
# Query
select sum(case when event_type='checkout' then 1 else 0 end)*1.0/count(distinct session_id) as conversion_rate from dbt_dfxvir.stg_events

# Results:

| conversion_rate |
|----------------|
|    36.10      |

## What is the conversion rate per product?
# Query
`select pv.product_id, pv.product_viewed, po.product_ordered, po.product_ordered*1.00/pv.product_viewed as product_conversion_rate  from
(Select product_id, count(distinct session_id) product_viewed from dbt_dfxvir.stg_events
where event_type = 'page_view' and product_id is not null
group by product_id) pv left join
(select product_id, count(order_id) as product_ordered from dbt_dfxvir.stg_order_items
group by product_id) po
on pv.product_id = po.product_id`


# Results:
| Product ID | Page Viewed | Orders | Conversation Rate |
| ------------------------------------ | --- | --- | ----------------------- |
| 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d |  29 |  27 |  0.93103448275862068966 |
| 35550082-a52d-4301-8f06-05b30f6f3616 |  31 |  22 |  0.70967741935483870968 |
| 37e0062f-bd15-4c3e-b272-558a86d90598 |  38 |  29 |  0.76315789473684210526 |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 |  32 |  21 |  0.65625000000000000000 |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 |  34 |  30 |  0.88235294117647058824 |
| 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 |  34 |  28 |  0.82352941176470588235 |
| 58b575f2-2192-4a53-9d21-df9a0c14fc25 |  24 |  24 |  1.00000000000000000000 |
| 5b50b820-1d0a-4231-9422-75e7f6b0cecf |  30 |  28 |  0.93333333333333333333 |
| 5ceddd13-cf00-481f-9285-8340ab95d06d |  34 |  33 |  0.97058823529411764706 |
| 615695d3-8ffd-4850-bcf7-944cf6d3685b |  35 |  32 |  0.91428571428571428571 |
| 64d39754-03e4-4fa0-b1ea-5f4293315f67 |  38 |  28 |  0.73684210526315789474 |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d |  45 |  36 |  0.80000000000000000000 |
| 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af |  27 |  21 |  0.77777777777777777778 |
| 74aeb414-e3dd-4e8a-beef-0fa45225214d |  37 |  35 |  0.94594594594594594595 |
| 80eda933-749d-4fc6-91d5-613d29eb126f |  32 |  31 |  0.96875000000000000000 |
| 843b6553-dc6a-4fc4-bceb-02cd39af0168 |  36 |  29 |  0.80555555555555555556 |
| a88a23ef-679c-4743-b151-dc7722040d8c |  24 |  22 |  0.91666666666666666667 |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 |  38 |  34 |  0.89473684210526315789 |
| b86ae24b-6f59-47e8-8adc-b17d88cbd367 |  30 |  27 |  0.90000000000000000000 |
| bb19d194-e1bd-4358-819e-cd1f1b401c0c |  41 |  33 |  0.80487804878048780488 |
| be49171b-9f72-4fc9-bf7a-9a52e259836b |  29 |  25 |  0.86206896551724137931 |
| c17e63f7-0d28-4a95-8248-b01ea354840e |  34 |  30 |  0.88235294117647058824 |
| c7050c3b-a898-424d-8d98-ab0aaad7bef4 |  37 |  34 |  0.91891891891891891892 |


## Question 3 Macros 

* added a grant_select macro that has been applied as a post-hook to all models (applied in the dbt_project.yml)
* added a extract_uuid macro for extracting product id from page url
* utilized dbt_utils package to help selct query result data. 

22:22:55 | Concurrency: 4 threads (target='dev')
22:22:55 | 
22:22:55 | 1 of 54 START test accepted_values_stg_orders_order_status__pending__shipped__preparing__delivered__returned [RUN]
22:22:55 | 2 of 54 START test dbt_expectations_expect_column_to_exist_stg_events_event_id [RUN]
22:22:55 | 3 of 54 START test dbt_expectations_expect_column_values_to_be_between_stg_order_items_quantity__99__1 [RUN]
22:22:55 | 4 of 54 START test dbt_expectations_expect_column_values_to_match_regex_stg_events_event_id___at_ [RUN]
22:22:55 | 1 of 54 PASS accepted_values_stg_orders_order_status__pending__shipped__preparing__delivered__returned [PASS in 0.28s]
22:22:55 | 5 of 54 START test not0_values_stg_orders_order_cost................. [RUN]
22:22:55 | 3 of 54 PASS dbt_expectations_expect_column_values_to_be_between_stg_order_items_quantity__99__1 [PASS in 0.32s]
22:22:55 | 6 of 54 START test not0_values_stg_orders_order_total................ [RUN]
22:22:55 | 4 of 54 PASS dbt_expectations_expect_column_values_to_match_regex_stg_events_event_id___at_ [PASS in 0.34s]
22:22:55 | 7 of 54 START test not0_values_stg_orders_shipping_cost.............. [RUN]
22:22:55 | 2 of 54 PASS dbt_expectations_expect_column_to_exist_stg_events_event_id [PASS in 0.39s]
22:22:55 | 5 of 54 PASS not0_values_stg_orders_order_cost....................... [PASS in 0.10s]
22:22:55 | 8 of 54 START test not0_values_stg_products_price.................... [RUN]
22:22:55 | 9 of 54 START test not_null_base_addresses_address................... [RUN]
22:22:55 | 6 of 54 PASS not0_values_stg_orders_order_total...................... [PASS in 0.12s]
22:22:55 | 7 of 54 PASS not0_values_stg_orders_shipping_cost.................... [PASS in 0.10s]
22:22:55 | 10 of 54 START test not_null_base_addresses_address_id............... [RUN]
22:22:55 | 11 of 54 START test not_null_base_addresses_zipcode.................. [RUN]
22:22:55 | 9 of 54 PASS not_null_base_addresses_address......................... [PASS in 0.11s]
22:22:55 | 12 of 54 START test not_null_base_users_address_id................... [RUN]
22:22:55 | 8 of 54 PASS not0_values_stg_products_price.......................... [PASS in 0.11s]
22:22:55 | 13 of 54 START test not_null_base_users_first_name................... [RUN]
22:22:55 | 11 of 54 PASS not_null_base_addresses_zipcode........................ [PASS in 0.10s]
22:22:55 | 12 of 54 PASS not_null_base_users_address_id......................... [PASS in 0.07s]
22:22:55 | 10 of 54 PASS not_null_base_addresses_address_id..................... [PASS in 0.11s]
22:22:55 | 14 of 54 START test not_null_base_users_last_name.................... [RUN]
22:22:55 | 15 of 54 START test not_null_base_users_user_id...................... [RUN]
22:22:55 | 16 of 54 START test not_null_stg_events_event_id..................... [RUN]
22:22:56 | 13 of 54 PASS not_null_base_users_first_name......................... [PASS in 0.13s]
22:22:56 | 17 of 54 START test not_null_stg_events_user_id...................... [RUN]
22:22:56 | 16 of 54 PASS not_null_stg_events_event_id........................... [PASS in 0.10s]
22:22:56 | 14 of 54 PASS not_null_base_users_last_name.......................... [PASS in 0.12s]
22:22:56 | 18 of 54 START test not_null_stg_order_items_order_id................ [RUN]
22:22:56 | 15 of 54 PASS not_null_base_users_user_id............................ [PASS in 0.12s]
22:22:56 | 19 of 54 START test not_null_stg_order_items_product_id.............. [RUN]
22:22:56 | 20 of 54 START test not_null_stg_orders_address_id................... [RUN]
22:22:56 | 17 of 54 PASS not_null_stg_events_user_id............................ [PASS in 0.12s]
22:22:56 | 21 of 54 START test not_null_stg_orders_order_id..................... [RUN]
22:22:56 | 19 of 54 PASS not_null_stg_order_items_product_id.................... [PASS in 0.13s]
22:22:56 | 22 of 54 START test not_null_stg_orders_user_id...................... [RUN]
22:22:56 | 20 of 54 PASS not_null_stg_orders_address_id......................... [PASS in 0.09s]
22:22:56 | 18 of 54 PASS not_null_stg_order_items_order_id...................... [PASS in 0.16s]
22:22:56 | 23 of 54 START test not_null_stg_products_name....................... [RUN]
22:22:56 | 24 of 54 START test not_null_stg_products_product_id................. [RUN]
22:22:56 | 21 of 54 PASS not_null_stg_orders_order_id........................... [PASS in 0.12s]
22:22:56 | 25 of 54 START test not_null_stg_promos_promo_id..................... [RUN]
22:22:56 | 22 of 54 PASS not_null_stg_orders_user_id............................ [PASS in 0.11s]
22:22:56 | 26 of 54 START test not_null_stg_superheroes_name.................... [RUN]
22:22:56 | 23 of 54 PASS not_null_stg_products_name............................. [PASS in 0.12s]
22:22:56 | 24 of 54 PASS not_null_stg_products_product_id....................... [PASS in 0.12s]
22:22:56 | 27 of 54 START test order_total_consistency.......................... [RUN]
22:22:56 | 28 of 54 START test positive_values_stg_order_items_quantity......... [RUN]
22:22:56 | 25 of 54 PASS not_null_stg_promos_promo_id........................... [PASS in 0.11s]
22:22:56 | 29 of 54 START test positive_values_stg_orders_order_cost............ [RUN]
22:22:56 | 26 of 54 PASS not_null_stg_superheroes_name.......................... [PASS in 0.11s]
22:22:56 | 30 of 54 START test positive_values_stg_orders_order_total........... [RUN]
22:22:56 | 27 of 54 FAIL 43 order_total_consistency............................. [FAIL 43 in 0.16s]
22:22:56 | 28 of 54 PASS positive_values_stg_order_items_quantity............... [PASS in 0.15s]
22:22:56 | 31 of 54 START test positive_values_stg_orders_shipping_cost......... [RUN]
22:22:56 | 32 of 54 START test positive_values_stg_products_price............... [RUN]
22:22:56 | 30 of 54 FAIL 1 positive_values_stg_orders_order_total............... [FAIL 1 in 0.10s]
22:22:56 | 29 of 54 PASS positive_values_stg_orders_order_cost.................. [PASS in 0.12s]
22:22:56 | 33 of 54 START test positive_values_stg_superheroes_height........... [RUN]
22:22:56 | 34 of 54 START test positive_values_stg_superheroes_weight_kg........ [RUN]
22:22:56 | 31 of 54 PASS positive_values_stg_orders_shipping_cost............... [PASS in 0.20s]
22:22:56 | 35 of 54 START test positive_values_stg_superheroes_weight_lbs....... [RUN]
22:22:56 | 32 of 54 PASS positive_values_stg_products_price..................... [PASS in 0.19s]
22:22:56 | 36 of 54 START test products_exact_duplicates........................ [RUN]
22:22:56 | 34 of 54 PASS positive_values_stg_superheroes_weight_kg.............. [PASS in 0.20s]
22:22:56 | 33 of 54 PASS positive_values_stg_superheroes_height................. [PASS in 0.20s]
22:22:56 | 37 of 54 START test relationships_base_users_address_id__address_id__ref_base_addresses_ [RUN]
22:22:56 | 38 of 54 START test relationships_stg_events_user_id__user_id__ref_base_users_ [RUN]
22:22:56 | 35 of 54 PASS positive_values_stg_superheroes_weight_lbs............. [PASS in 0.11s]
22:22:56 | 39 of 54 START test relationships_stg_order_items_order_id__order_id__ref_stg_orders_ [RUN]
22:22:56 | 36 of 54 PASS products_exact_duplicates.............................. [PASS in 0.11s]
22:22:56 | 40 of 54 START test relationships_stg_order_items_product_id__product_id__ref_stg_products_ [RUN]
22:22:56 | 37 of 54 PASS relationships_base_users_address_id__address_id__ref_base_addresses_ [PASS in 0.12s]
22:22:56 | 41 of 54 START test relationships_stg_orders_address_id__address_id__ref_base_addresses_ [RUN]
22:22:56 | 38 of 54 PASS relationships_stg_events_user_id__user_id__ref_base_users_ [PASS in 0.15s]
22:22:56 | 42 of 54 START test relationships_stg_orders_order_id__order_id__ref_stg_order_items_ [RUN]
22:22:56 | 39 of 54 PASS relationships_stg_order_items_order_id__order_id__ref_stg_orders_ [PASS in 0.10s]
22:22:56 | 43 of 54 START test relationships_stg_orders_promo_id__promo_id__ref_stg_promos_ [RUN]
22:22:56 | 40 of 54 PASS relationships_stg_order_items_product_id__product_id__ref_stg_products_ [PASS in 0.11s]
22:22:56 | 44 of 54 START test unique_base_addresses_address_id................. [RUN]
22:22:57 | 41 of 54 PASS relationships_stg_orders_address_id__address_id__ref_base_addresses_ [PASS in 0.11s]
22:22:57 | 45 of 54 START test unique_base_users_email.......................... [RUN]
22:22:57 | 42 of 54 FAIL 39 relationships_stg_orders_order_id__order_id__ref_stg_order_items_ [FAIL 39 in 0.11s]
22:22:57 | 46 of 54 START test unique_base_users_user_id........................ [RUN]
22:22:57 | 43 of 54 PASS relationships_stg_orders_promo_id__promo_id__ref_stg_promos_ [PASS in 0.13s]
22:22:57 | 44 of 54 PASS unique_base_addresses_address_id....................... [PASS in 0.14s]
22:22:57 | 47 of 54 START test unique_stg_events_event_id....................... [RUN]
22:22:57 | 48 of 54 START test unique_stg_orders_order_id....................... [RUN]
22:22:57 | 46 of 54 PASS unique_base_users_user_id.............................. [PASS in 0.10s]
22:22:57 | 49 of 54 START test unique_stg_products_product_id................... [RUN]
22:22:57 | 45 of 54 PASS unique_base_users_email................................ [PASS in 0.13s]
22:22:57 | 50 of 54 START test unique_stg_promos_promo_id....................... [RUN]
22:22:57 | 47 of 54 PASS unique_stg_events_event_id............................. [PASS in 0.10s]
22:22:57 | 48 of 54 PASS unique_stg_orders_order_id............................. [PASS in 0.10s]
22:22:57 | 51 of 54 START test users_exact_duplicates........................... [RUN]
22:22:57 | 49 of 54 PASS unique_stg_products_product_id......................... [PASS in 0.07s]
22:22:57 | 50 of 54 PASS unique_stg_promos_promo_id............................. [PASS in 0.06s]
22:22:57 | 51 of 54 PASS users_exact_duplicates................................. [PASS in 0.03s]
22:22:57 | 52 of 54 START test not_null_stg_users_user_id....................... [RUN]
22:22:57 | 53 of 54 START test relationships_stg_orders_user_id__user_id__ref_stg_users_ [RUN]
22:22:57 | 54 of 54 START test unique_stg_users_user_id......................... [RUN]
22:22:57 | 52 of 54 PASS not_null_stg_users_user_id............................. [PASS in 0.08s]
22:22:57 | 53 of 54 PASS relationships_stg_orders_user_id__user_id__ref_stg_users_ [PASS in 0.09s]
22:22:57 | 54 of 54 PASS unique_stg_users_user_id............................... [PASS in 0.09s]
22:22:57 | 
22:22:57 | Finished running 54 tests in 2.33s.