/**
Table: Users
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key for this table.
Each row of this table contains the name and the id of a user.

Table: Register
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key for this table.
Each row of this table contains the id of a user and the contest they registered into.

Write an SQL query to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

solution: use with to create a table store user_id_count for future use.
Then cal the percentage by select the user_id_count
 */

with user_id_count_table as (select count(distinct user_id) as user_id_count from users)

select contest_id, round(100 * count(distinct user_id) / (select user_id_count from user_id_count_table), 2) as percentage
from register
group by contest_id
order by percentage desc, contest_id asc;