
-- Coding Challenge:CareerHub, The Job Board 
-- 1. 
create database career
use career
--2. 
-- Table: Companies
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY IDENTITY(1,1), 
    CompanyName VARCHAR(255) NOT NULL,        
    Location VARCHAR(255)                     
)

-- Table: Jobs
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY IDENTITY(1,1),      
    CompanyID INT,                              
    JobTitle VARCHAR(255) NOT NULL,             
    JobDescription TEXT,                        
    JobLocation VARCHAR(255),                   
    Salary DECIMAL(18, 2),                      
    JobType VARCHAR(50),                        
    PostedDate DATETIME DEFAULT GETDATE(),      
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID) ON DELETE CASCADE 
)

-- Table: Applicants
CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY IDENTITY(1,1),  
    FirstName VARCHAR(100) NOT NULL,            
    LastName VARCHAR(100) NOT NULL,             
    Email VARCHAR(255) NOT NULL,                
    Phone VARCHAR(20),                          
    Resume TEXT                                 
)

-- Table: Applications
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1), 
    JobID INT,                                   
    ApplicantID INT,                              
    ApplicationDate DATETIME DEFAULT GETDATE(),   
    CoverLetter TEXT,                             
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID) ON DELETE CASCADE,      
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID) ON DELETE CASCADE 
)
--3 & 4
-- Inserting records into the Companies table

-- Enable IDENTITY_INSERT for the Companies table
SET IDENTITY_INSERT Companies ON

INSERT INTO Companies (CompanyID, CompanyName, Location)
VALUES
(1, 'Tech Inc.', 'New York'),
(2, 'Green Ltd.', 'London'),
(3, 'FutureWorks Tech', 'Berlin'),
(4, 'Oceanic Software', 'Sydney'),
(5, 'Peak Performance Consulting', 'Toronto'),
(6, 'Skyline Networks', 'San Francisco'),
(7, 'Quantum Leap Technologies', 'Tokyo'),
(8, 'Redwood Systems', 'Mumbai')


SET IDENTITY_INSERT Companies OFF

SELECT * FROM Companies

SET IDENTITY_INSERT Jobs ON  

INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES
(1, 1, 'Software Engineer', 'maintain software applications', 'New York', 85000, 'Full-time', '2024-09-01'),
(2, 2, 'Data Scientist', 'build predictive models', 'London', 95000, 'Full-time', '2024-09-05'),
(3, 3, 'UI/UX Designer', 'Design user interfaces', 'Berlin', 60000, 'Part-time', '2024-09-10 '),
(4, 4, 'Project Manager', 'Manage projects', 'Sydney', 100000, 'Full-time', '2024-09-12'),
(5, 5, 'Network Engineer', 'Maintain network infrastructure', 'Toronto', 75000, 'Contract', '2024-09-14'),
(6, 6, 'Cloud Architect', 'Design cloud infrastructure', 'San Francisco', 120000, 'Full-time', '2024-09-18'),
(7, 7, 'Machine Learning Engineer', 'Develop machine learning algorithms', 'Tokyo', 115000, 'Full-time', '2024-09-20'),
(8, 8, 'DevOps Engineer', 'Improve development processes', 'Mumbai', 85000, 'Full-time', '2024-09-22')

SET IDENTITY_INSERT Jobs OFF
SELECT * FROM Jobs

SET IDENTITY_INSERT Applicants On

INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume)
VALUES
(1, 'Rajesh', 'Sharma', 'rajesh.sharma@example.com', '+91-9876543210', 'Experienced software engineer with a focus on backend development and cloud infrastructure.'),
(2, 'Priya', 'Verma', 'priya.verma@example.com', '+91-9123456789', 'Data scientist with expertise in machine learning and data analytics.'),
(3, 'Amit', 'Singh', 'amit.singh@example.com', '+91-9001234567', 'Network engineer with 5 years of experience in network administration and security.'),
(4, 'Neha', 'Kumar', 'neha.kumar@example.com', '+91-9123456790', 'UI/UX designer with a strong portfolio of mobile and web designs.'),
(5, 'Vikram', 'Patel', 'vikram.patel@example.com', '+91-9876512345', 'Project manager experienced in handling large-scale software projects.'),
(6, 'Sangeeta', 'Nair', 'sangeeta.nair@example.com', '+91-9009876543', 'Cloud architect with experience in designing and implementing cloud-based solutions.'),
(7, 'Rohit', 'Mehta', 'rohit.mehta@example.com', '+91-7896543210', 'Full-stack developer with expertise in MERN stack development.'),
(8, 'Anjali', 'Reddy', 'anjali.reddy@example.com', '+91-7009876543', 'Machine learning engineer with experience in building predictive models and neural networks.')

SELECT * FROM Applicants
SET IDENTITY_INSERT Applicants OFF
SET IDENTITY_INSERT Applications On

INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter)
VALUES
(1, 1, 1, '2024-09-01', 'cover1.doc'),
(2, 2, 2, '2024-09-02', 'cover2.doc'),
(3, 3, 3, '2024-09-03', 'cover3.doc'),
(4, 4, 4, '2024-09-04', 'cover4.doc'),
(5, 5, 5, '2024-09-05', 'cover5.doc'),
(6, 6, 6, '2024-09-06', 'cover6.doc'),
(7, 7, 7, '2024-09-07', 'cover7.doc'),
(8, 8, 8, '2024-09-08', 'cover8.doc')

SET IDENTITY_INSERT Applications Off
SELECT * FROM Applications

-- 5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications. 
SELECT j.JobTitle, 
COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobTitle
ORDER BY j.JobTitle

-- 6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range. Allow parameters for the minimum and maximum salary values. Display the job title, company name, location, and salary for each matching job. 
SELECT j.JobTitle, c.CompanyName, c.Location, j.Salary
FROM Jobs j
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN 30000 AND 80000 
ORDER BY j.JobTitle

-- 7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a parameter for the ApplicantID, and return a result set with the job titles, company names, and application dates for all the jobs the applicant has applied to. 
SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
JOIN Jobs j ON a.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = 1 -- Replace with the desired ApplicantID
ORDER BY a.ApplicationDate DESC -- Sort by application date, newest first

-- 8. Create an SQL query that calculates and displays the average salary offered by all companies for job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero. 
SELECT AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0



-- 9. Write an SQL query to identify the company that has posted the most job listings. Display the company name along with the count of job listings they have posted. Handle ties if multiple companies have the same maximum count. 
SET IDENTITY_INSERT Jobs On
INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES 
(9, 1, 'Software Engineer', ' maintain software applications.','New York', 85000, 'Full-time', '2024-09-02')
SET IDENTITY_INSERT Jobs OFF
WITH CompanyJobCounts AS (SELECT c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName)
SELECT CompanyName, JobCount
FROM CompanyJobCounts
WHERE JobCount = (SELECT MAX(JobCount) FROM CompanyJobCounts)

-- 10.  Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience. 

ALTER TABLE Applicants
ADD Experience INT

UPDATE Applicants
SET Experience =  CASE ApplicantID
WHEN 1 THEN 5 
WHEN 2 THEN 2  
WHEN 3 THEN 4  
WHEN 4 THEN 1  
WHEN 5 THEN 3  
WHEN 6 THEN 6  
WHEN 7 THEN 3  
WHEN 8 THEN 7  
ELSE 0         
END;

select * from Applicants 


SELECT a.FirstName, a.LastName, a.Email, a.Phone
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'New York' AND a.Experience >= 3 

-- 11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.

SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000

-- 12.  Find the jobs that have not received any applications. 

SELECT j.JobID, j.JobTitle, j.CompanyID, j.JobLocation, j.Salary, j.JobType, j.PostedDate
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.ApplicationID IS NULL

-- 13. Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for. 
SELECT a.ApplicantID,a.FirstName,a.LastName,c.CompanyName,j.JobTitle,j.JobLocation,j.Salary
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID

-- 14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications. 
SELECT c.CompanyID,c.CompanyName,COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyID, c.CompanyName

-- 15. List all applicants along with the companies and positions they have applied for, including those who have not applied. 
SELECT a.ApplicantID,a.FirstName,a.LastName,(SELECT c.CompanyName 
FROM Applications ap 
JOIN Jobs j ON ap.JobID = j.JobID 
JOIN Companies c ON j.CompanyID = c.CompanyID 
WHERE ap.ApplicantID = a.ApplicantID) AS CompanyName,(SELECT j.JobTitle FROM Applications ap JOIN Jobs j ON ap.JobID = j.JobID 
WHERE ap.ApplicantID = a.ApplicantID) AS JobTitle
FROM Applicants a

-- 16. Find companies that have posted jobs with a salary higher than the average salary of all jobs. 
SELECT DISTINCT c.CompanyID,c.CompanyName FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs WHERE Salary > 0)

-- 17.  Display a list of applicants with their names and a concatenated string of their city and state.
ALTER TABLE Applicants
ADD City VARCHAR(100),  
State VARCHAR(100)

UPDATE Applicants
SET City = CASE ApplicantID
WHEN 1 THEN 'Mumbai'
WHEN 2 THEN 'Delhi'
WHEN 3 THEN 'Bengaluru'
WHEN 4 THEN 'Chennai'
WHEN 5 THEN 'Hyderabad'
WHEN 6 THEN 'Ahmedabad'
WHEN 7 THEN 'Kolkata'
WHEN 8 THEN 'Pune'
END,
State = CASE ApplicantID
WHEN 1 THEN 'Maharashtra'
WHEN 2 THEN 'Delhi'
WHEN 3 THEN 'Karnataka'
WHEN 4 THEN 'Tamil Nadu'
WHEN 5 THEN 'Telangana'
WHEN 6 THEN 'Gujarat'
WHEN 7 THEN 'West Bengal'
WHEN 8 THEN 'Maharashtra'
END;

SELECT * FROM Applicants

SELECT a.ApplicantID,a.FirstName,a.LastName, CONCAT(a.City, ', ', a.State) AS Location
FROM Applicants a

-- 18.  Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'. 
SELECT JobID,JobTitle,CompanyID,JobDescription,JobLocation,Salary,JobType,PostedDate
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%'

-- 19. Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants. 
SET IDENTITY_INSERT Applicants On
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume, City, State, Experience)
VALUES (9, 'Aisha', 'Khan', 'aisha.khan@example.com', '9876543210', 'Link to Resume or text of resume', 'Jaipur', 'Rajasthan', '2')
select * from Applicants
SELECT  a.ApplicantID, a.FirstName, a.LastName, j.JobTitle, j.CompanyID
FROM  Applicants a
LEFT JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
LEFT JOIN Jobs j ON ap.JobID = j.JobID
ORDER BY a.ApplicantID, j.JobTitle

-- 20. List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience. For example: city=Chennai 
select * from Applicants
UPDATE Companies
SET Location = 'Chennai'
WHERE CompanyID= '7'

SELECT a.ApplicantID,a.FirstName,a.LastName,c.CompanyID,c.CompanyName
FROM Applicants a
JOIN Applications ap ON a.ApplicantID = ap.ApplicantID
JOIN Jobs j ON ap.JobID = j.JobID
JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE c.Location = 'Chennai' AND a.Experience > '2'




