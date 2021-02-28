/*

Write an SQL query to find the names of all the activities with neither maximum, nor minimum number of participants.

Friends table:
+------+--------------+---------------+
| id   | name         | activity      |
+------+--------------+---------------+
| 1    | Jonathan D.  | Eating        |
| 2    | Jade W.      | Singing       |
| 3    | Victor J.    | Singing       |
| 4    | Elvis Q.     | Eating        |
| 5    | Daniel A.    | Eating        |
| 6    | Bob B.       | Horse Riding  |
+------+--------------+---------------+

Activities table:
+------+--------------+
| id   | name         |
+------+--------------+
| 1    | Eating       |
| 2    | Singing      |
| 3    | Horse Riding |
+------+--------------+

Result table:
+--------------+
| activity     |
+--------------+
| Singing      |
+--------------+

Solution: use with clause to create activity_count subquery block
then reference the count_number as following to select the result
 */

with activity_count as (
  select a.id, a.name as activity, count(f.id) as count_number
  from Activities a
         inner join Friends f
                    on a.name = f.activity
  group by a.id
)

select activity
from activity_count
where count_number < (select max(count_number) from activity_count)
  and count_number > (select min(count_number) from activity_count)