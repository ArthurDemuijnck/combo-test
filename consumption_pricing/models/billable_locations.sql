
{{ config(
        alias='billable_locations',
        materialized='view'
    ) 
}}

-- Billable locations: We bill any location that is not archived. The size of the location is determined by the number of billable employees.

select distinct
  l.account_id as account_id, 
  l.id as location_id,
  l.archived as archived,
  l.updated_at
from {{ref('locations')}} as l
where l.archived is false


-- improvement idea: 
  -- check if archived after 2023 then consider the location billable between 2023-01-01 and updated_at timestamp
  -- case when (l.archived is true and timestamp(l.updated_at) >= '2023-01-01')