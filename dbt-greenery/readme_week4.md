### Questions 

## 1. Modeling challenge

### Product Funnel Rate: 
| Total Sessions|Sessions with Product page View|Session with Add-to-Cart|Session with CheckOut |
|-------------------|--------------------------------|---------------------------|--------------------------|
|       100%        |           48%                  |              43%          |             36%          |

### Query: 
    select * from dbt_dfxvir.fact_session_funnel
###
    select
    count(distinct session_id),
    count(case when (count_of_page_view >0 or count_of_add_to_cart >0 or count_of_checkout >0) then 1 end) as lev1,
    count(case when (count_of_add_to_cart >0 or count_of_checkout >0) then 1 end) as lev2,
    count(case when (count_of_checkout >0) then 1 end) as lev3
    from {{ ref('fact_session_events') }}
### How are our users moving through the product funnel?
Almost 1/3 of the sessions go to a checkout which is a good rate so far.

### Which steps in the funnel have largest drop off points?
    * Sessions with any Level 1 event (type page_view / add_to_cart / checkout)
    * Sessions with any Level 2 event (type add_to_cart / checkout)
    * Sessions with any Level 3 event (type checkout)

## Additional Models Created

### Session Events
    {{
        config(
         materialized = 'table'
        )
    }}

    {%- set event_types = dbt_utils.get_column_values(
        table=ref('stg_events'),
        column='event_type'
    ) -%}

    SELECT
    session_id,
    {%- for event_type in event_types %}
    count(case when event_type = '{{event_type}}' then event_id end) as count_of_{{event_type}}
    {%- if not loop.last %},{% endif -%}
    {%- endfor %}
    from {{ ref('stg_events') }}
    group by session_id
###

### Session Funnel
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

## Exposure

![Funnels are beautiful!](/dbt-greenery/images/funnel.png "Nice Funnel")

###
    gitpod /workspace/course-dbt-dfxvir/dbt-greenery $ dbt run -s +exposure:nice_funnel
    Running with dbt=0.21.0
    Found 25 models, 54 tests, 3 snapshots, 0 analyses, 575 macros, 0 operations, 1 seed file, 27 sources, 1 exposure

    23:08:49 | Concurrency: 4 threads (target='dev')
    23:08:49 | 
    23:08:49 | 1 of 3 START table model dbt_dfxvir.stg_events....................... [RUN]
    23:08:49 | 1 of 3 OK created table model dbt_dfxvir.stg_events.................. [SELECT 3355 in 0.25s]
    23:08:49 | 2 of 3 START table model dbt_dfxvir.fact_session_events.............. [RUN]
    23:08:49 | 2 of 3 OK created table model dbt_dfxvir.fact_session_events......... [SELECT 1108 in 0.06s]
    23:08:49 | 3 of 3 START table model dbt_dfxvir.fact_session_funnel.............. [RUN]
    23:08:49 | 3 of 3 OK created table model dbt_dfxvir.fact_session_funnel......... [SELECT 1 in 0.04s]
    23:08:49 | 
    23:08:49 | Finished running 3 table models in 0.67s.

    Completed successfully

    Done. PASS=3 WARN=0 ERROR=0 SKIP=0 TOTAL=3

## 2A. dbt next steps for you

As a product manager for a software vendor (SAS Institute), we are considering to deliver integration with dbt to our customers so they can blend dbt models with SAS, Python and R programs.

## 2B. Setting up for production / scheduled dbt run of your project

Will definitely go with a process orchestration tool like Airflow, Dagster or Nifi, which can allow combine various runtimes and technologies.