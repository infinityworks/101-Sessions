with raw_orders as (
    select
        *
    from
        {{ source('jaffle_shop', 'orders') }}
),
transformed_orders as (
    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from
        raw_orders
)
select * from transformed_orders
