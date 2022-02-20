start c:\DBM\project\createtable.txt
start c:\DBM\project\insertdata2.txt

set pagesize 80
set linesize 200

---question 13
COLUMN Employee format a30
COLUMN Department format a25
SELECT E.Emp_num || ': ' || E.Fname || ' ' || E.Lname AS Employee, D.name AS Department, NVL(P.name, 'No Project Assigned') AS Last_Project
FROM employee E LEFT OUTER JOIN department D ON (E.dept_code=D.dept_code)
                LEFT OUTER JOIN assignment A ON (E.emp_num=A.emp_num)
                LEFT OUTER JOIN project P ON (A.proj_number=P.proj_number)
WHERE E.emp_num IN (
SELECT emp_num
FROM employee JOIN department USING (dept_code)
MINUS
SELECT emp_num
FROM employee JOIN department USING (dept_code)
              JOIN assignment USING (emp_num)
WHERE Date_Assigned > '01-July-2021'
)
AND (A.date_assigned IS NULL OR (E.emp_num, A.date_assigned) IN (SELECT emp_num, MAX(date_assigned) FROM assignment GROUP BY emp_num))
ORDER BY D.name, E.Lname;






---question 14
(SELECT T1.skillname, trainingnumber AS Training_Count,projectnumber AS Project_Count
 FROM
   (
     (SELECT S.name AS skillname, count(*) AS trainingnumber
      FROM  skill S JOIN training T ON (S.code=T.code)
      GROUP by S.name
      ORDER BY S.name) T1
     JOIN 
    (SELECT SK.name AS Skillname, count(*) projectnumber
     FROM skill SK JOIN project P ON (SK.code=P.code)
     GROUP by SK.name
     ORDER by SK.name) T2 ON (T1.skillname=T2.skillname)))
UNION ALL
(SELECT  'total number', trainingnumber,projectnumber
 FROM
  (
    (SELECT count(*) AS trainingnumber
     FROM skill S JOIN training T ON (S.code=T.code)) T1
     CROSS JOIN 
    (SELECT count(*) projectnumber
     FROM skill SK JOIN project P ON (SK.code=P.code))
  )
);

---question 1
COLUMN Train_Count format a11
COLUMN Employee format a20
BREAK ON Employee
SELECT E.emp_num || ': ' || E.Fname || ' ' || E.Lname AS Employee,
       NVL(S.name,'No Skill') AS Skills_Acquired, REPLACE(TO_CHAR(count(Train_Num)),0,'-') AS Train_Count,
       NVL(TO_CHAR(MIN(T.Date_Acquired)),'---------') AS Earliest_Date, 
       NVL(TO_CHAR(ROUND(Months_Between(SYSDATE,MAX(T.Date_Acquired)))),'---') AS Months_Passed 
from employee E LEFT OUTER JOIN training T ON (E.Emp_Num=T.Emp_Num)
                LEFT OUTER JOIN skill    S ON (T.Code=S.Code)
group by E.emp_num, E.lname, E.fname,S.name
Order by 1,3 DESC;


---question 2
column Employee format a30
SELECT LEVEL,
       LPAD(' ', 4*(LEVEL-1)) || emp_num || ': ' || Fname || ' ' || Lname AS Employee,
       Name AS Department
FROM employee JOIN department USING (dept_code)
START WITH emp_num=4013
CONNECT BY PRIOR emp_num=Super_ID;

---question 3
BREAK ON NAME
COLUMN Project_Month FORMAT A15
SELECT name, TO_CHAR(start_date) AS Start_Date,
          TO_CHAR(extract(month from date_assigned)) || '/' ||to_CHAR(extract(year from date_assigned)) as Project_Month,
             COUNT(EMP_NUM) AS "No. Employees",
            NVL(TO_CHAR(SUM(HOURS_USED)),'Not Available(On Going)') AS "No. of Hours"
     FROM project JOIN assignment USING(proj_number)
     WHERE total_cost IS NULL
     GROUP BY  name, start_date, extract(month from date_assigned),extract(year from date_assigned)
     UNION ALL
     SELECT 'Total of ' || NAME AS Project, '----','----', COUNT(DISTINCT(emp_num)),NVL(TO_CHAR(SUM(HOURS_USED)),'Not Available(On Going)')
     FROM project JOIN assignment USING(proj_number)
     WHERE total_cost IS NULL
     GROUP BY proj_number, name;

---question 4
ALTER TABLE employee
ADD(Bonus_AMT VARCHAR(10));

UPDATE employee e1
SET  Bonus_AMT= (SELECT TO_CHAR(NVL(Bonus,0),'$9999') 
FROM(
    SELECT * FROM 
    employee LEFT OUTER JOIN (
	     SELECT EMp_num, count(proj_number)*200 AS Bonus 
             FROM assignment 
	     WHERE proj_number IN(
		   SELECT DISTINCT Proj_number 
                   FROM project JOIN assignment USING (proj_number)
                   WHERE EXTRACT(MONTH FROM start_date) IN (1,2,3)
                   AND EXTRACT(YEAR FROM start_date) = 2021) 
             AND 
             Hours_used > 150
    GROUP BY emp_num) USING (emp_num)) e2
WHERE e1.emp_num=e2.emp_num);

SELECT * FROM employee;


---question 5
BREAK ON EMPLOYEE ON Hire_Date ON Project_Count
column Days_Between_Hiring_Training format a30
column Employee format a20
column Project_Count format a15
column Train_date format a10
SELECT emp_num || ': ' ||Employee AS Employee,
       Hire_Date,
       NVL(num_proj,0) AS Project_Count,
       Training_Name,Train_date,
       Days_Between_Hiring_Training
FROM(
      (SELECT E.emp_num, E.Fname || ' ' || E.Lname AS Employee,
              E.hire_date AS Hire_Date, T.name AS Training_Name, T.date_acquired AS Train_date,
              TO_CHAR((T.Date_Acquired-E.hire_date),'9999') AS Days_Between_Hiring_Training
       FROM   employee E JOIN training T ON (E.emp_num=T.emp_num)
       WHERE EXTRACT(MONTH FROM E.hire_date) IN (4,5,6)
       AND EXTRACT(YEAR FROM E.hire_date) =2021
       ORDER BY E.emp_num)
       LEFT OUTER JOIN(
                       SELECT emp_num, TO_CHAR(NVL(count(proj_number),0),'99') AS num_proj
                       FROM assignment
                       GROUP by emp_num)
       USING (emp_num));



---question 6
COLUMN Start_date format a10
COLUMN Discontinued_Project format a20
SELECT Proj_Number || ': ' || name AS Discontinued_Project, Start_date,
       CASE NVL(Total_Cost,0)
            WHEN 0 THEN 'on-going'
            ELSE    'completed'
       END  Status
FROM project JOIN(
		  SELECT Proj_number,Assign_Num,Date_Assigned,Date_Ended,
			(LAG(Date_Ended,1) OVER (PARTITION BY Proj_Number ORDER BY Date_Assigned)) AS Previous_end
                  FROM assignment
                  )
             USING(proj_number)
WHERE Date_Assigned-Previous_end>30;

---question 7
SELECT FLOOR(((EXTRACT(month FROM START_DATE) - 1)/ 3) + 1) quarter, COUNT(DISTINCT(PROJ_NUMBER)) AS "#. of Projects", COUNT(DISTINCT(EMP_NUM)) AS "#. of Employees", 
       NVL(TO_CHAR(FLOOR(SUM(HOURS_USED)/COUNT(PROJ_NUMBER))),'Not Availabel(On going)') AS "Average #. of Hours"
FROM PROJECT JOIN ASSIGNMENT USING(PROJ_NUMBER)
WHERE EXTRACT(year FROM START_DATE) = '2021'
GROUP BY FLOOR(((EXTRACT(month FROM START_DATE) - 1)/ 3) + 1);


---question 8
column Employee_Name format a20
column ID format a4
column LDA format a9
column Python format 99
column SQL format 99
column Marketing format 99
column Negotiation format 99
column Powerpoint format 99
column word format 99
column NumberOfSkills format a15
SELECT DECODE(E.Emp_num, NULL, '---', E.Emp_Num) "ID", 
       DECODE(E.fname || ' ' || E.lname, NULL, 'Number of Trainings: ',E.fname || ' ' || E.lname) "Employee_Name",
       NVL(SUM(DECODE(S.code, 1001, 1,0)),0) "Python",
       NVL(TO_CHAR(MAX(DECODE(S.code, 1001, T.Date_Acquired,Null))),'------') "LDA",
       NVL(SUM(DECODE(S.code, 1002, 1,0)),0) "SQL",
       NVL(TO_CHAR(MAX(DECODE(S.code, 1002, T.Date_Acquired,Null))),'------') "LDA",
       NVL(SUM(DECODE(S.code, 1011, 1,0)),0) "Marketing",
       NVL(TO_CHAR(MAX(DECODE(S.code, 1011, T.Date_Acquired,Null))),'------') "LDA",
       NVL(SUM(DECODE(S.code, 1012, 1,0)),0) "Negotiation",
       NVL(TO_CHAR(MAX(DECODE(S.code, 1012, T.Date_Acquired,Null))),'------') "LDA",
       NVL(SUM(DECODE(S.code, 1021, 1,0)),0) "Powerpoint",
       NVL(TO_CHAR(MAX(DECODE(S.code, 1021, T.Date_Acquired,Null))),'------') "LDA",
       NVL(SUM(DECODE(S.code, 1022, 1,0)),0) "word",
       NVL(TO_CHAR(MAX(DECODE(S.code, 1022, T.Date_Acquired,Null))),'------') "LDA",
       TO_CHAR(COUNT(DISTINCT S.code)) "NumberOfSkills"
FROM   employee E LEFT OUTER JOIN training T ON (E.Emp_Num=T.Emp_Num)
                  LEFT OUTER JOIN skill S ON (T.Code=S.Code)
GROUP BY GROUPING SETS((E.Emp_num, E.lname, E.fname))
UNION ALL
SELECT '----', 'Number of Trainings: ', 
       SUM(DECODE(code, 1001, 1,0)),'------', 
       SUM(DECODE(code, 1002, 1,0)),'------', 
       SUM(DECODE(code, 1011, 1,0)),'------', 
       SUM(DECODE(code, 1012, 1,0)),'------', 
       SUM(DECODE(code, 1021, 1,0)),'------', 
       SUM(DECODE(code, 1022, 1,0)),'------',
       '---------'
FROM training
GROUP BY GROUPING SETS (());

---question 9
COLUMN department format a25
BREAK ON Department
SELECT D.name AS Department,S.name AS Skill,count(*) AS Number_Trainings,
       RANK() OVER (PARTITION BY D.dept_code ORDER BY count(*) DESC) AS rank
FROM 
Skill S JOIN training T on (S.code=T.code)
        JOIN employee E on (T.Emp_Num=E.Emp_Num)
        JOIN department D on (E.dept_code=D.dept_code)
GROUP BY D.dept_code,D.name,S.name
ORDER BY D.dept_code;


----question 10
SELECT PROJ_NUMBER AS Project_Number, SUM((DATE_ENDED-DATE_ASSIGNED)) "Total_Working_Days"
FROM ASSIGNMENT
WHERE PROJ_NUMBER IN (SELECT PROJ_NUMBER FROM (SELECT PROJ_NUMBER, SUM((DATE_ENDED-DATE_ASSIGNED))
                      FROM(SELECT PROJ_NUMBER, ASSIGN_NUM, DATE_ASSIGNED, DATE_ENDED
                            FROM(
                                 SELECT PROJ_NUMBER, ASSIGN_NUM, DATE_ASSIGNED, DATE_ENDED,
                                 ROW_NUMBER() OVER (ORDER BY (Date_Ended - Date_Assigned)) RANKING
                                 FROM ASSIGNMENT
                                 WHERE PROJ_NUMBER IN ( SELECT Proj_Number AS "Project Number"
                                                       FROM assignment
                                                       GROUP BY Proj_Number
                                                       HAVING COUNT(*) >= 5
                                                      )
                                  )
                                                      WHERE RANKING <4)
                                                      GROUP BY Proj_Number
                                                      HAVING SUM((DATE_ENDED-DATE_ASSIGNED))>=60))
GROUP BY Proj_Number;


---question 11
COLUMN manage_dep format a20
SELECT T1.Emp_num, T1.Employee AS LastName, T1.hire_date, NVL(T1.Name,'-----') AS manage_dep, 
       NVL(TO_CHAR(T2.supervising),'----') AS Supervising_Count 
FROM(
      (SELECT Emp_num, Lname AS Employee, hire_date, Name
       FROM
       (SELECT *FROM (SELECT* FROM employee ORDER BY Hire_date)
         WHERE ROWNUM<5) 
       LEFT OUTER JOIN department  ON (Emp_Num = Manager_ID)
     ) T1
    LEFT OUTER JOIN
    (
      SELECT super_id,count(*)AS supervising
      FROM Employee
      GROUP BY super_id
      Having super_id IN  (SELECT emp_num FROM(SELECT *FROM(SELECT* FROM employee ORDER BY Hire_date)
      WHERE ROWNUM<5))
     ) T2 ON (T1.Emp_num=T2.super_id)
);

---question 12
SELECT 
      CASE NVL(substr(Web_Address, LENGTH(Web_Address)-2, 3),'XXX')
           WHEN 'edu' THEN 'Education Institution'
           WHEN 'gov' THEN 'Government Agency'
           WHEN 'org' THEN 'Non-Profit Organization'
           WHEN 'com' THEN 'For-Profit Company'
	   WHEN 'XXX' THEN 'Not Available'
           ELSE            'Other'
      END "Client_Type",
      Count(DISTINCT Client_ID) AS Number_Of_Cients, Count(DISTINCT Proj_number) AS Number_Of_Proj
FROM client LEFT OUTER JOIN project USING (Client_ID)
GROUP BY
( CASE NVL(substr(Web_Address, LENGTH(Web_Address)-2, 3),'XXX')
           WHEN 'edu' THEN 'Education Institution'
           WHEN 'gov' THEN 'Government Agency'
           WHEN 'org' THEN 'Non-Profit Organization'
           WHEN 'com' THEN 'For-Profit Company'
           WHEN 'XXX' THEN 'Not Available'
           ELSE            'Other'
      END ) ;

          

---question 15
set pagesize 200
Column TABLE_NAME format a10
Column COLUMN_NAME format a20
Column CONSTRAINT_NAME format a30
Column CONSTRAINT_TYPE format a2
Column SEARCH_CONDITION format a39
Column TABLE_REFERENCED format a20
Column COLUMN_REFERENCED format a20
SELECT a.table_name, a.column_name, a.constraint_name, a.constraint_type, b.search_condition, c.table_name AS “TABLE_REFERENCED”, c.column_name AS “COLUMN_REFERENCED” FROM
(SELECT t.table_name, t.column_name, column_id, u.constraint_name, substr(u.constraint_name, length(u.constraint_name)-1, length(u.constraint_name)) AS “CONSTRAINT_TYPE”
FROM user_tab_columns t JOIN user_constraints c
            ON t.table_name=c.table_name
                    LEFT OUTER JOIN user_cons_columns u
           ON t.column_name=u.column_name      
GROUP BY t.table_name, t.column_name, column_id, u.constraint_name
ORDER BY t.table_name) a
LEFT OUTER JOIN
(SELECT constraint_name, search_condition
FROM user_constraints
WHERE constraint_type='C') b
ON a.constraint_name=b.constraint_name
LEFT OUTER JOIN
(SELECT c.constraint_name, c.r_constraint_name, u.table_name, u.column_name
 FROM user_cons_columns u, user_constraints c
WHERE c. constraint_type= 'R'
              AND u.constraint_name=c.r_constraint_name ) c
ON a.constraint_name=c.constraint_name
ORDER BY a.table_name, a.column_id;









