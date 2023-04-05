with raw_customer as (
     select * from dbt_workshop_raw.jaffle_shop.customers
),
transformed_customer as (
    select
        id as customer_id,
        first_name,
        last_name
    from raw_customer
)
select * from transformed_customer
