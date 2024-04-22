{{ config(
        alias='account_weekly_pricing',
        materialized='view'
    ) 
}}

with location_employees as (
    select 
        account_id,
        location_id,
        week,
        count(distinct user_id) as employees
    from {{ref('billable_employees')}}
    group by 1,2,3
),

monthly_bill as (
    select 
        account_id,
        location_id, 
        week,
        employees,
        case 
            when employees <= 5 then 60
            when employees <= 39 and employees > 5 then 80
            when employees >= 40 then 216
        end as location_monthly_bill,
        case 
            when employees <=6 then 0
            when employees >= 7 and employees <= 39 then (employees-6)*4
            when employees >= 40 then (39-6)*4 + (employees-39)*2.4
        end as employees_monthly_bill
    from location_employees
)

select 
    account_id,
    week, 
    count(distinct location_id) as locations,
    sum(employees) as employees,
    round(sum((location_monthly_bill/30)*7),2) as location_weekly_bill,
    round(sum((employees_monthly_bill/30)*7),2) as employees_weekly_bill,
    round(sum((location_monthly_bill/30)*7) + sum((employees_monthly_bill/30)*7),2) as weekly_bill
from monthly_bill
where week >= '2023-01-01' 
-- The new pricing applies only for 2023 onwards.
-- 2023-01-01 is a Sunday, works well with current week definition
group by 1,2