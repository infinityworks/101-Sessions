with raw_customer as (
    select * from {{ source('jaffle_shop', 'customers') }}
),
transformed_customer as (
    select
        id as customer_id,
        first_name,
        last_name
    from
        raw_customer
)
select * from transformed_customer