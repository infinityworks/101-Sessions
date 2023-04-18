{% docs stg_models %}
# Staged orders table
The `stg_orders` model is a populated from the raw `orders` table.

The following transformation are applied:
- `orderid` column reneamed to `order_id`
{% enddocs %}