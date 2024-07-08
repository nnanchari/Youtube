with group_list as (
select id,count(*) cnt from list group by id having count(*)>1
  )
 ,rank_list as (
 select id, row_number() over(order by id) rn from group_list  
 )
 
 select l.id,COALESCE(concat('dup',rl.rn),'null') from 
 list l left join rank_list rl on l.id=rl.id 


create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');
