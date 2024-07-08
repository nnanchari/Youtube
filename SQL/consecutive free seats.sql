with cons_free as (
select 
*,
lag(free,1,0) over(order by seat_id) as prev_seat,
lead(free,1,0) over(order by seat_id) as next_seat
from cinema 
)
select * from cons_free where free=1 and (prev_seat=1 or next_seat=1);

with free AS
(select 
c1.seat_id as seat1,c2.seat_id as seat2
from cinema c1 join cinema c2 on c1.seat_id=c2.seat_id-1
and c1.free=c2.free
 )
 select seat1 from free 
 union 
 select seat2 from free;

with cte as (
select *,
seat_id-row_number() over(order by seat_id) as Grp
from cinema where free=1
)
,cte2 as (
select *,
count(*) over(partition by grp) as cnt
from cte
  )  
select * from cte2 where cnt>1;


CREATE TABLE cinema (
    seat_id INT PRIMARY KEY,
    free int
);
delete from cinema;
INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);
