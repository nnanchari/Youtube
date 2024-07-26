
/*Approach 1*/
with prod as (
select *,date(activity_time) as ofc_day,rank() over(partition by employee_id,activity_type order by activity_time) r from swipe )
,ts as (
select employee_id, r,ofc_day,max(activity_time),min(activity_time),max(activity_time)-min(activity_time) as time_Spent
from prod 
group by 1,2,3
order by 1,2,3
  )

select employee_id,ofc_day,sum(time_spent)
from ts
group by 1,2
order by 1


/*Approach 2*/
with time_spent as (
  select *,date(activity_time) as ofc_day,activity_time as login,
  lead(activity_time) over(partition by employee_id,date(activity_time) order by activity_time) as logout
  from swipe  
 )

select employee_id,ofc_day,max(logout)-min(login) as ts,
sum(logout-login) as prod_ts from time_spent 
 where activity_type='login'
 group by 1,2
