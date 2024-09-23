{{ config(materialized='table') }}

with orders_payments as (
  select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    p.payment_id,
    p.payment_method,
    p.amount
  from stg_orders o
  left join stg_payments p on o.order_id = p.order_id
),
orders_customers as (
  select
    op.order_id,
    op.customer_id,
    op.order_date,
    op.status,
    op.payment_id,
    op.payment_method,
    op.amount,
    c.first_name,
    c.last_name
  from orders_payments op
  left join stg_customers c on op.customer_id = c.customer_id
)
select * from orders_customers
