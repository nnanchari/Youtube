
select 
*,sum(units) over(order by units rows between  2 PRECEDING and current row) as Rolling_3_day_demand
from dw 

create table dw
(

	run_date 		date,
	units 		int
);

insert into dw values ('4/20/2020',  10); 
insert into dw values ('4/21/2020',  20); 
insert into dw values ('4/22/2020',  30); 
insert into dw values ('4/23/2020',  40); 
insert into dw values ('4/24/2020', 50); 
insert into dw values ('4/25/2020',  60); 
