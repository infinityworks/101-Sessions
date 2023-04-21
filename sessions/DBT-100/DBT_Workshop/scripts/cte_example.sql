--Creating three CTEs to segment buyers by how many times they’ve purchased.

with import_orders as (
    select * from {{ ref('orders') }}
),
aggregate_orders as (
    select
        customer_id,
        count(order_id) as count_orders
    from import_orders
    where status not in ('returned', 'return pending')
    group by 1
),
segment_users as (
    select
        *,
        case 
            when count_orders >= 3 then 'super_buyer'
            when count_orders <3 and count_orders >= 2 then 
                'regular_buyer'
            else 'single_buyer'
        end as buyer_type
    from aggregate_orders
)
select * from segment_users

/* 
In the first import_orders CTE, you are simply importing the orders table which holds the data I’m interested in creating the customer segment off of. 
Note that this first CTE starts with a WITH statement and no following CTEs begin with a WITH statement.

The second aggregate_orders CTE utilizes the import_orders CTE to get a count of orders per user with a filter applied.

The last segment_users CTE builds off of the aggregate_orders by selecting the customer_id, count_orders, and creating your buyer_type segment. Note that the final segment_users CTE does not have a comma after its closing parenthesis.

The final select * from segment_users statement simply selects all results from the segment_users CTE.
*/
