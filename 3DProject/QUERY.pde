/* RELIGION 

select YEAR(cout), TRUNCATE(FLOOR(`deweyClass`), -1) AS Dewey, count(*)
from spl_2016.inraw
where YEAR(cout) > '2005' and deweyClass > '0' and title like '%God%'
or title like '%god%' or title like '%religion%' or title like '%religious%'
group by
year (cout),  TRUNCATE(FLOOR(`deweyClass`), -1)
order by
year (cout), TRUNCATE(FLOOR(`deweyClass`), -1)

SCIENCE 

select YEAR(cout), TRUNCATE(FLOOR(`deweyClass`), -1) AS Dewey, count(*)
from spl_2016.inraw
where YEAR(cout) > '2005' and deweyClass > '0'
and title like '%science%' or title like '%scientific%' 
group by
year (cout),  TRUNCATE(FLOOR(`deweyClass`), -1)
order by
year (cout), TRUNCATE(FLOOR(`deweyClass`), -1)


*/
