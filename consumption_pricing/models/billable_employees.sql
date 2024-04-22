
{{ config(
        alias='billable_employees',
        materialized='view'
    ) 
}}

-- Billable employees: We consider that an employee is to be billed on his contract location if he was scheduled (with a shift or a rest) at least once in the week (independent of the location where his rest/shift happened).


with 
user_contracts_locations as (
  select 
    c.account_id,
    c.id as user_contract_id, 
    c.location_id, 
    m.user_id
  from {{ref('user_contracts')}} as c
  inner join {{ref('memberships')}} as m
    on m.id = c.membership_id
),
rests as (
  select distinct
      account_id,
      user_contract_id,
      date_trunc(timestamp(starts_at), week) as week, -- Sunday starting the week (american default week handling) in UTC
      id as scheduled_id,
      'rest' as scheduled_type
  from {{ref('rests')}} 
),
shifts as (
  select distinct
      account_id, 
      user_contract_id,
      date_trunc(timestamp(starts_at), week) as week, -- Sunday starting the week (american default week handling) in UTC
      id as scheduled_id,
      'shift' as scheduled_type
  from {{ref('shifts')}} 
),
scheduled_union as (
  select * from shifts
  union all 
  select * from rests
),
final as (
  select 
    u.account_id, 
    u.location_id,
    u.user_id,
    s.week,
    count(distinct case when s.scheduled_type = 'rest' then s.scheduled_id else null end) as rests,
    count(distinct case when s.scheduled_type = 'shift' then s.scheduled_id else null end) as shifts,
    count(distinct s.scheduled_id) as scheduled_count
  from user_contracts_locations u 
  inner join scheduled_union s
    on s.user_contract_id = u.user_contract_id
    and s.account_id = u.account_id
  group by 1,2,3,4
)
select * from final
where scheduled_count >= 1 --normally not necessary
