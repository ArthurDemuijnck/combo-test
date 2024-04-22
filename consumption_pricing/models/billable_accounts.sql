
{{ config(
        alias='billable_accounts',
        materialized='view'
    ) 
}}


select 
  l.account_id,
  e.week,
  count(distinct l.location_id) as locations,
  count(distinct e.user_id) as employees
from {{ref('billable_employees')}} e
inner join {{ref('billable_locations')}} l 
  on l.location_id = e.location_id
  and l.account_id = e.account_id
group by 1,2

--improvement idea:
  -- The week here is defined the North American way (automatic with BigQuery) meaning it shows the starting Sunday.
  -- Combo being mainly in Europe we could: 
    -- 1. Design the week to be a starting Monday
    -- 2. Translate the timestamp into Paris time before aggregating weekly