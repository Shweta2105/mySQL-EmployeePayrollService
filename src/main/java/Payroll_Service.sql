/*MySQL Database
    Employee Payroll service
 */

//UC 1
mysql> create DATABASE payroll_service;
Query OK, 1 row affected (0.83 sec)

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| classicmodels      |
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.73 sec)

mysql> use payroll_service;
Database changed
//UC 2

mysql> use payroll_service;
Database changed
mysql> create table employee_payroll(
    -> id int NOT NULL auto_increment,
    -> name varchar(50) NOT NULL,
    -> salary int NOT NULL,
    -> start date,
    -> primary key (id));
Query OK, 0 rows affected (8.36 sec)

mysql> desc employee_payroll;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| id     | int         | NO   | PRI | NULL    | auto_increment |
| name   | varchar(50) | NO   |     | NULL    |                |
| salary | int         | NO   |     | NULL    |                |
| start  | date        | YES  |     | NULL    |                |
+--------+-------------+------+-----+---------+----------------+
4 rows in set (0.84 sec)

//UC 3

mysql> insert INTO employee_payroll
    -> (name,salary,start) values
    -> ("John",300000,'2021-07-01');
Query OK, 1 row affected (0.84 sec)

mysql> insert INTO employee_payroll
    -> (name,salary,start) values
    -> ("Mark",350000,'2021-05-01'),("Saam",250000,'2021-06-01');
Query OK, 2 rows affected (0.43 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+------+--------+------------+
| id | name | salary | start      |
+----+------+--------+------------+
|  1 | John | 300000 | 2021-07-01 |
|  2 | Mark | 350000 | 2021-05-01 |
|  3 | Saam | 250000 | 2021-06-01 |
+----+------+--------+------------+
3 rows in set (0.18 sec)

mysql> insert INTO employee_payroll
    -> (name,salary,start) values
    -> ("richard",350000,'2021-05-01'),("David",250000,'2021-06-01');
Query OK, 2 rows affected (0.25 sec)
Records: 2  Duplicates: 0  Warnings: 0

//UC 4

mysql> select * from employee_payroll;
+----+---------+--------+------------+
| id | name    | salary | start      |
+----+---------+--------+------------+
|  1 | John    | 300000 | 2021-07-01 |
|  2 | Mark    | 350000 | 2021-05-01 |
|  3 | Saam    | 250000 | 2021-06-01 |
|  4 | richard | 350000 | 2021-05-01 |
|  5 | David   | 250000 | 2021-06-01 |
+----+---------+--------+------------+
5 rows in set (0.03 sec)

//UC 5
mysql> insert INTO employee_payroll
    -> (name,salary,start) values
    -> ("Bill",450000,'2021-03-01');
Query OK, 1 row affected (10.19 sec)

mysql> select salary from employee_payroll
    -> where name="Bill";
+--------+
| salary |
+--------+
| 450000 |
+--------+
1 row in set (1.01 sec)

mysql>  SELECT salary FROM employee_payroll WHERE start BETWEEN CAST('2021-05-09' AS DATE) AND DATE(NOW());
+--------+
| salary |
+--------+
| 300000 |
| 250000 |
| 250000 |
+--------+
3 rows in set (0.00 sec)

//UC 6

mysql> alter table employee_payroll
    -> ADD gender char(1);
Query OK, 0 rows affected (12.41 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employee_payroll;
+----+---------+--------+------------+--------+
| id | name    | salary | start      | gender |
+----+---------+--------+------------+--------+
|  1 | John    | 300000 | 2021-07-01 | NULL   |
|  2 | Mark    | 350000 | 2021-05-01 | NULL   |
|  3 | Saam    | 250000 | 2021-06-01 | NULL   |
|  4 | richard | 350000 | 2021-05-01 | NULL   |
|  5 | David   | 250000 | 2021-06-01 | NULL   |
|  6 | Bill    | 450000 | 2021-03-01 | NULL   |
+----+---------+--------+------------+--------+
6 rows in set (0.00 sec)

mysql> UPDATE employee_payroll
    -> set gender = "M" where name ="Bill" or name ="John";
Query OK, 2 rows affected (0.23 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> select * from employee_payroll;
+----+---------+--------+------------+--------+
| id | name    | salary | start      | gender |
+----+---------+--------+------------+--------+
|  1 | John    | 300000 | 2021-07-01 | M      |
|  2 | Mark    | 350000 | 2021-05-01 | NULL   |
|  3 | Saam    | 250000 | 2021-06-01 | NULL   |
|  4 | richard | 350000 | 2021-05-01 | NULL   |
|  5 | David   | 250000 | 2021-06-01 | NULL   |
|  6 | Bill    | 450000 | 2021-03-01 | M      |
+----+---------+--------+------------+--------+
6 rows in set (0.10 sec)

//UC 7


mysql> select sum(salary) from employee_payroll
    -> where gender = "F";
+-------------+
| sum(salary) |
+-------------+
|      600000 |
+-------------+
1 row in set (0.12 sec)

mysql> select sum(salary) from employee_payroll
    -> ^C
mysql> select max(salary) from employee_payroll
    -> where gender = "F" group by gender;
+-------------+
| max(salary) |
+-------------+
|      350000 |
+-------------+
1 row in set (0.03 sec)

mysql> select min(salary) from employee_payroll
    -> where gender = "F" group by gender;
+-------------+
| min(salary) |
+-------------+
|      250000 |
+-------------+
1 row in set (0.00 sec)

mysql> select AVG(salary) from employee_payroll
    -> where gender = "F" group by gender;
+-------------+
| AVG(salary) |
+-------------+
| 300000.0000 |
+-------------+
1 row in set (0.04 sec)

mysql>  SELECT gender, count(gender) FROM employee_payroll GROUP BY gender;
+--------+---------------+
| gender | count(gender) |
+--------+---------------+
| M      |             6 |
| F      |             2 |
+--------+---------------+
2 rows in set (0.17 sec)
