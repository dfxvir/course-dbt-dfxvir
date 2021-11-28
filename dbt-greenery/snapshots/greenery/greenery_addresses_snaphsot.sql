{% snapshot greenery_addresses_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='address_id',

      strategy='check',
      check_cols=['address', 'zip_code', 'state', 'country'],
      invalidate_hard_deletes=True,
    )
  }}

  SELECT * 
  FROM {{ source('greenery', 'addresses') }}

{% endsnapshot %}