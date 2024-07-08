SELECT
e1.*,e2.*,
coalesce(e1.emp_id,e2.emp_id),
case when e1.emp_id is null then 'New' when e2.emp_id is null then 'Resigned' when e1.designation!=e2.designation then 'promoted' else
e1.designation end as comment
from emp_2020 e1 full outer join emp_2021 e2
 on e1.emp_id=e2.emp_id
 where 
 isnull(e1.designation,'abc')!=isnull(e2.designation,'xyz');


create table emp_2020
(
emp_id int,
designation varchar(20)
);

create table emp_2021
(
emp_id int,
designation varchar(20)
)

insert into emp_2020 values (1,'Trainee'), (2,'Developer'),(3,'Senior Developer'),(4,'Manager');
insert into emp_2021 values (1,'Developer'), (2,'Developer'),(3,'Manager'),(5,'Trainee');
