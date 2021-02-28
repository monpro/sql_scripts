/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table.

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+

Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+--------------

Solution: use inner join, group by statement with aggregation function (avg, sum...) to group the result-set by column.
 */
select p.project_id, round(avg(e.experience_years), 2) as average_years
from Project p
inner join Employee e
where p.employee_id = e.employee_id
group by p.project_id;

/**
Write an SQL query that reports all the projects that have the most employees.

The query result format is in the following example:

Result table:
+-------------+
| project_id  |
+-------------+
| 1           |
+-------------+
Solution: use subquery first to select the highest count(employee_id)
then select all project_id having count(employee_id) = this highest count
 */


select project_id
from project
group by project_id
having count(employee_id) =
(
  select count(employee_id) from project
  group by project_id
  order by count(employee_id) desc
  limit 1
);

/**
Write an SQL query that reports the most experienced employees in each project.
In case of a tie, report all employees with the maximum number of experience years.
The query result format is in the following example:

Result table:
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+
Solution: use subquery first to select the project_id and the maximum number of experience years
then select all project_id and employee_id having the maximum years
 */

select p.project_id, e.employee_id
from project p inner join employee e
on p.employee_id = e.employee_id
where (p.project_id, e.experience_years) in
(
    select p.project_id, max(e.experience_years)
    from project p inner join employee e
    on p.employee_id = e.employee_id
    group by p.project_id
);