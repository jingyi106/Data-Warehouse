---insert data into TABLE Skill
INSERT INTO Skill
VALUES (1001, 'Python','Programming');
INSERT INTO Skill
VALUES (1002, 'Sql','Programming');
INSERT INTO Skill
VALUES (1011, 'Marketing','Business');
INSERT INTO Skill
VALUES (1012, 'Negotiation','Business');
INSERT INTO Skill
VALUES (1021, 'PowerPoint','Daily_work');
INSERT INTO Skill
VALUES (1022, 'Word','Daily_work');


---insert data into TABLE Department
INSERT INTO Department
VALUES (3001, 'Personnel Department', 'Pittsburgh', 4128881111, null);
INSERT INTO Department
VALUES (3002, 'Marketing Department', 'Pittsburgh', 4128881112, null);
INSERT INTO Department
VALUES (3003, 'Technology Department', 'New York', 4128881113, null);
INSERT INTO Department
VALUES (3004, 'Operational Department', 'New York', 4128881114, null);
INSERT INTO Department
VALUES (3005, 'Administration Department', 'New York', 4128881115, null);


---insert data into TABLE Employee
---CEO
INSERT INTO Employee
VALUES (4013, 'Kim', 'Sara', '3-July-1973','1-September-2001',null,3003);
--managers
INSERT INTO Employee
VALUES (4001, 'Mary', 'Ken', '12-November-1980','1-September-2002',4013,3001);
INSERT INTO Employee
VALUES (4007, 'Madore', 'Jassica', '4-May-1989','1-June-2018',4013,3003);
INSERT INTO Employee
VALUES (4010, 'Lin', 'Jewel', '23-October-1986','1-June-2008',4013,3002);
INSERT INTO Employee
VALUES (4018, 'Forbes', 'Lucy', '16-September-1976','1-March-2018',4013,3004);
INSERT INTO Employee
VALUES (4020, 'Kevin', 'Ling', '1-September-1988','1-March-2007',4013,3005);
---department 3001
INSERT INTO Employee
VALUES (4002, 'Wang', 'Lisa', '20-December-1975','1-May-2001',4001,3001);
INSERT INTO Employee
VALUES (4003, 'Li', 'Katty', '21-March-1995','1-May-2020',4001,3001);
---department 3002
INSERT INTO Employee
VALUES (4004, 'Ran','Melody', '6-January-2000','1-May-2021',4010,3002);
INSERT INTO Employee
VALUES (4005, 'Smith','Ruby', '5-March-1990','1-May-2008',4010,3002);
INSERT INTO Employee
VALUES (4006, 'Madore', 'Leah', '23-March-1991','1-May-2020',4010,3002);
---department 3003
INSERT INTO Employee
VALUES (4008, 'Novac', 'David', '17-March-1997','1-June-2018',4007,3003);
INSERT INTO Employee
VALUES (4009, 'Huang', 'Lily', '21-April-1987','1-June-2018',4007,3003);
INSERT INTO Employee
VALUES (4011, 'Hilton', 'Mercy', '12-November-1997','1-September-2021',4007,3003);
INSERT INTO Employee
VALUES (4012, 'Peng', 'Sara', '7-December-1998','1-September-2021',4007,3003);
INSERT INTO Employee
VALUES (4014, 'Murry', 'John', '21-January-1986','1-September-2010',4007,3003);
INSERT INTO Employee
VALUES (4015, 'Murry', 'Tony', '4-January-2001','1-September-2021',4007,3003);
---department 3004
INSERT INTO Employee
VALUES (4016, 'Li', 'Toby', '3-June-1976','1-September-2005',4018,3004);
INSERT INTO Employee
VALUES (4017, 'Ning', 'Zheng', '23-May-1994','1-March-2018',4018,3004);
INSERT INTO Employee
VALUES (4019, 'Hilary', 'Victoria', '3-August-1987','1-March-2006',4018,3004);
---department 3005
INSERT INTO Employee
VALUES (4021, 'Jason', 'Hong', '23-May-199','1-September-2021',4020,3005);
INSERT INTO Employee
VALUES (4022, 'Cassay', 'Milton', '4-January-2001','1-March-2021',4020,3005);

	

---update data in the department table
UPDATE department
SET Manager_ID=4001 WHERE Dept_Code=3001;
UPDATE department
SET Manager_ID=4010 WHERE Dept_Code=3002;
UPDATE department
SET Manager_ID=4007 WHERE Dept_Code=3003;
UPDATE department
SET Manager_ID=4018 WHERE Dept_Code=3004;
UPDATE department
SET Manager_ID=4020 WHERE Dept_Code=3005;

																		
---insert data into TABLE Training
INSERT INTO Training
VALUES(2001, 1001, 4001, 'Introduction to Python', '10-January-2003', 'Pass');
INSERT INTO Training																																								
VALUES(2002, 1001, 4001, 'Advanced Python', '10-February-2004', 'Good');	
INSERT INTO Training																				
VALUES(2003, 1001, 4001, 'Advanced Python', '10-March-2005', 'Excellent');
INSERT INTO Training																					
VALUES(2004, 1002, 4002, 'Database Fundamental', '20-January-2003', 'Pass');
INSERT INTO Training																					
VALUES(2005, 1002, 4003, 'MySQL Training', '20-February-2021', 'Good');
INSERT INTO Training																					
VALUES(2006, 1011, 4003, 'Marketing Analysis', '15-June-2021', 'Excellent');
INSERT INTO Training																				
VALUES(2007, 1012, 4004, 'Negotiation Strategy for Consulting', '15-October-2021', 'Pass');
INSERT INTO Training																					
VALUES(2008, 1021, 4004, 'PowerPoint Tips', '1-November-2021', 'Good');
INSERT INTO Training																					
VALUES(2009, 1022, 4005, 'Training for Microsoft Word', '10-September-2009', 'Excellent');
INSERT INTO Training																					
VALUES(2010, 1022, 4006, 'Training for Microsoft Word', '10-September-2021', 'Pass');
INSERT INTO Training																					
VALUES(2011, 1022, 4007, 'Training for Microsoft Word', '1-October-2019', 'Good');


INSERT INTO Training																																								
VALUES(2012, 1001, 4008, 'Introduction to Python', '10-January-2019', 'Excellent');	
INSERT INTO Training																				
VALUES(2013, 1001, 4009, 'Advanced Python', '10-February-2019', 'Pass');
INSERT INTO Training																					
VALUES(2014, 1002, 4010, 'Database Fundamental', '10-March-2009', 'Good');
INSERT INTO Training																					
VALUES(2015, 1002, 4010, 'Database Fundamental', '20-January-2010', 'Excellent');
INSERT INTO Training																					
VALUES(2016, 1002, 4010, 'Database Fundamental', '20-February-2011', 'Pass');
INSERT INTO Training																				
VALUES(2017, 1011, 4010, 'Marketing Analysis', '15-June-2009', 'Good');
INSERT INTO Training																					
VALUES(2018, 1012, 4011, 'Negotiation Strategy for Consulting', '15-November-2021', 'Excellent');
INSERT INTO Training																					
VALUES(2019, 1021, 4011, 'PowerPoint Tips', '1-October-2021', 'Pass');
INSERT INTO Training																					
VALUES(2020, 1022, 4012, 'Training for Microsoft Word', '10-September-2021', 'Good');
INSERT INTO Training																					
VALUES(2021, 1022, 4013, 'Training for Microsoft Word', '10-September-2002', 'Excellent');

INSERT INTO Training																					
VALUES(2022, 1022, 4014, 'Training for Microsoft Word', '1-October-2011', 'Pass');
INSERT INTO Training																																								
VALUES(2023, 1001, 4015, 'Introduction to Python', '10-September-2021', 'Good');	
INSERT INTO Training																				
VALUES(2024, 1001, 4016, 'Advanced Python', '10-February-2006', 'Excellent');
INSERT INTO Training																					
VALUES(2025, 1001, 4016, 'Advanced Python', '10-March-2007', 'Pass');
INSERT INTO Training																					
VALUES(2026, 1002, 4017, 'MySQL Training', '20-January-2019', 'Good');
INSERT INTO Training																					
VALUES(2027, 1002, 4017, 'MySQL Training', '20-February-2019', 'Excellent');
INSERT INTO Training																				
VALUES(2028, 1011, 4018, 'Marketing Analysis', '15-June-2019', 'Pass');
INSERT INTO Training																					
VALUES(2029, 1012, 4019, 'Negotiation Strategy for Consulting', '15-November-2007', 'Good');																																						
INSERT INTO Training																					
VALUES(2030, 1011, 4020, 'Negotiation Strategy for Consulting', '1-October-2011', 'Pass');																																				
																			

---insert data into TABLE Client

INSERT INTO Client
VALUES (5001, 'eBay','2715 Murray Avenue','Pittsburgh','Pennysylvania','15217','Automobile','www.ebay.edu','4128809346','Eiben' ,'Ben'); 
INSERT INTO Client
VALUES (5002,'Amazon','2787 Mills Ave','New York','New York','10004','Technology','www.amazon.com','9997800001','Hyatt','Mark');
INSERT INTO Client
VALUES (5003 ,'HomeDepot','400 N Highland Ave','Philadelphia','Pennysylvania','15218','Furniture','www.homedepot.edu','6234007800','Smith','Karen');
INSERT INTO Client
VALUES (5004 ,'Target','345 Craig Ave','Phoneix','Arizona','10087','Ecommerce','www.target.co','3245679000','Jones','Tony');
INSERT INTO Client
VALUES (5005,'Walmart','678 Forbes Ave','San Jose','California','12934','Ecommerce','walmart.org','4245506789','Clay','Kim');
INSERT INTO Client
VALUES (5006,'Ulta','898 N Marshalls','San Diego','California','14001','Retail','www.marshalls.org','3456007834','Nath','Matin');
INSERT INTO Client
VALUES (5007,'Glossier','898 N Forbes','Chicago','Illinois','13002','Beauty','www.glossier.com','3446007834','Kasari','Mira');
INSERT INTO Client
VALUES (5008,'Google','1600 Parkway','Montain View','California','94043','Technology',null,'8004190157','Lily','Wang');



-------insert data into TABLE Project

INSERT INTO Project
VALUES (6001, 'Project A', '1-March-2020', 634000, 3002, 5001, 1002);
INSERT INTO Project
VALUES (6002,'Project B','1-May-2021', 540000, 3001, 5001, 1001);
INSERT INTO Project
VALUES (6003, 'Project C', '1-March-2021', 728000, 3003, 5003, 1011);
INSERT INTO Project
VALUES (6004, 'Project D', '1-September-2020', 822000, 3004, 5004, 1012);
INSERT INTO Project
VALUES (6005,'Project E', '1-December-2021', null, 3001, 5005, 1021);
INSERT INTO Project
VALUES (6006,'Project F','6-May-2020',1198000,3002,5004,1012);
INSERT INTO Project
VALUES (6007,'Project G','1-September-2020',null,3004,5001,1022);
INSERT INTO Project
VALUES (6008,'Project H','1-February-2021',2101000,3004,5002,1001);
INSERT INTO Project
VALUES (6009,'Project I','1-January-2021',2362700,3004,5002,1002);
INSERT INTO Project
VALUES (6010,'Project J','1-September-2021',null,3003,5002,1001);




---insert data into TABLE Assignment

INSERT INTO Assignment
VALUES (7001,6001,4002,'1-March-2020','24-March-2020',128);

INSERT INTO Assignment
VALUES (7002,6001,4003,'1-March-2020','27-March-2020', 146);

INSERT INTO Assignment
VALUES (7003,6001,4002,'1-January-2021','30-January-2021', 200);

INSERT INTO Assignment
VALUES (7004,6001,4003,'1-January-2021','30-January-2021', 200);

INSERT INTO Assignment
VALUES (7005,6002,4005,'1-May-2021','24-May-2021',150);

INSERT INTO Assignment
VALUES (7006,6002,4006,'1-May-2021','24-May-2021',150);

INSERT INTO Assignment
VALUES (7007,6003,4016,'1-March-2021','28-March-2021',200);

INSERT INTO Assignment
VALUES (7008,6004,4017,'1-September-2020','27-September-2020',120);

INSERT INTO Assignment
VALUES (7009,6005,4019,'1-December-2021',Null,Null);

INSERT INTO Assignment
VALUES (7010,6006,4001,'6-May-2020','28-May-2020',180);

INSERT INTO Assignment
VALUES (7011,6006,4007,'7-May-2020','28-May-2020',150);

INSERT INTO Assignment
VALUES (7012,6006,4010,'8-May-2020','28-May-2020',90);

INSERT INTO Assignment
VALUES (7013,6007,4018,'1-September-2020','21-September-2020',130);

INSERT INTO Assignment
VALUES (7014,6007,4002,'1-December-2021',Null,Null);

INSERT INTO Assignment
VALUES (7015,6008,4015,'1-February-2021','28-February-2021',200);

INSERT INTO Assignment
VALUES (7016,6009,4015,'1-January-2021','15-January-2021',200);

INSERT INTO Assignment
VALUES (7017,6004,4017,'1-October-2020','20-October-2020',150);

INSERT INTO Assignment
VALUES (7018,6004,4017,'1-November-2020','27-November-2020',180);

INSERT INTO Assignment
VALUES (7019,6004,4017,'2-December-2020','27-December-2020',110);

INSERT INTO Assignment
VALUES(7020,6004,4013,'1-August-2020','27-August-2020',130);

INSERT INTO Assignment
VALUES (7021,6004,4013,'3-July-2020','27-July-2020',140);

INSERT INTO Assignment
VALUES (7022,6005,4013,'1-December-2021',Null,Null);

INSERT INTO Assignment
VALUES (7023,6005,4016,'1-December-2021',Null,Null);

INSERT INTO Assignment
VALUES (7024,6007,4017,'1-September-2020','21-September-2020',120);

INSERT INTO Assignment
VALUES (7025,6007,4019,'1-September-2020','21-September-2020',100);

INSERT INTO Assignment
VALUES (7026,6010,4019,'1-September-2021',Null,Null);



