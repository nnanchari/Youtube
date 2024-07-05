--1st question 
--approach1
select * from users where user_id not in (
 select user_id from logins 
where date(login_timestamp) > datetime('now','-5 month')
 );
approach2
select user_id,max(login_timestamp) from logins 
group by 1 
having max(login_timestamp) < datetime('now','-5 month');

--2nd question related to quarter, session count, user count 

--3rd question 
--approach 1
select distinct user_id from logins 
where strftime('%m', LOGIN_TIMESTAMP) ='01' and strftime('%Y', LOGIN_TIMESTAMP) ='2024'
and user_id not in 
(
select user_id from logins 
where strftime('%m', LOGIN_TIMESTAMP) ='11' and strftime('%Y', LOGIN_TIMESTAMP) ='2023')

--approach 2 didn't work 
 select log1.*,log2.* from logins log1  left join logins log2
 on log1.USER_ID=log2.USER_ID  
  where strftime('%m', log1.LOGIN_TIMESTAMP) ='01' and strftime('%Y', log1.LOGIN_TIMESTAMP) ='2024'
 and strftime('%m', log2.LOGIN_TIMESTAMP) !='11' and strftime('%Y', log2.LOGIN_TIMESTAMP) !='2023'
 order by log1.user_id

--4th question, same as 2nd question but percentage change in sessoin session count 

-- 5th question 
select user_id,date(login_timestamp),max(session_score) as high_score 
from logins 
group by 1,2
order by 2,3

--6th question  in ms sql server
with login_Dates as (
select user_id, login_timestamp,row_number() over(partition by user_id order by login_timestamp) rn
from logins 
)
select user_id,cast(dateadd(day,-rn,login_timestamp) as date) as incpetiondate,count(*)
from login_dates
group by user_id,cast(dateadd(day,-rn,login_timestamp) as date)
having count(*)>1

--7th question in ms sql server

with cte as (
select min(login_timestamp) as first_day,max(login_timestamp) as last_day
 from logins 
  union all 
select dateadd(day,1,first_day), last_day from cte where first_day < last_day
)
 select count(*) from cte 
 where first_day  not in 
 (select distinct cast(login_timestamp as date)  from logins)
option(maxrecursion 500)







