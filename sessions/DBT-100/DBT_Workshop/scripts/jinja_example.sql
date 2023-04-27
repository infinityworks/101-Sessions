-- Finding out how much orders were paid for using each of the payment_method
/* 
This is a simple example of how to use Jinja templating to create a dynamic SQL query.
We can use jinja variable to first define the payment methods we want to segment by.
Then we can use a for loop to create a case statement for each payment method.
Not the use of the loop.last variable to determine if we need to add a comma after the case statement.
*/

{% set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}

select
    order_id,
    {% for payment_method in payment_methods %}
    sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
    {% if not loop.last %},{% endif %}
    {% endfor %}
    from {{ ref('raw_payments') }}
group by 1

-- The query will be compiled to:

select
    order_id,
    sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
    sum(case when payment_method = 'credit_card' then amount end) as credit_card_amount,
    sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount,
    sum(amount) as total_amount
from raw_jaffle_shop.payments
group by 1
