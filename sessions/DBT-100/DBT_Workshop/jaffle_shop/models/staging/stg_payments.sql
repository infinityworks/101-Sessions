with raw_payments as (
    select
        *
    from
        {{ source('jaffle_shop', 'payments') }}
),
transformed_payments as (
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod,
        status,
        amount,
        created
    from
          raw_payments
)
select * from transformed_payments
