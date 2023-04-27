-- sum(number_of_orders) should not be negative
select
    customer_id,
    sum(number_of_orders) as number_of_orders
from {{ ref('dim_customer' )}}
group by 1
having sum(number_of_orders) < 0
