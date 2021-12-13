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
