/*

+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War       |   great 3D   |   8.9     |
|   2     | Science   |   fiction    |   8.5     |
|   3     | irish     |   boring     |   6.2     |
|   4     | Ice song  |   Fantacy    |   8.6     |
|   5     | House card|   Interesting|   9.1     |
+---------+-----------+--------------+-----------+

Write a SQL query to output movies with an odd numbered ID and a description that is not 'boring'. Order the result by rating.

Solution:
  the description might be string contains 'boring', that's why we use not like '%boring%' rather than c.description != 'boring'
 */
select * from cinema c
where c.description
not like '%boring%'
and (c.id % 2 != 0)
order by rating desc;