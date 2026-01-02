create database ResumeScreeningDB;

use ResumeScreeningDB;

CREATE TABLE resumes (
    resume_id INT PRIMARY KEY,
    name VARCHAR(100),
    skills TEXT,
    experience_years INT,
    education VARCHAR(50),
    certifications VARCHAR(100),
    job_role VARCHAR(50),
    recruiter_decision VARCHAR(20),
    salary_expectation INT,
    projects_count INT,
    ai_score INT
);

INSERT INTO resumes VALUES
(1, 'Ashley Ali', 'TensorFlow, NLP, Pytorch', 10, 'B.Sc', NULL,
 'AI Researcher', 'Hire', 104895, 8, 100),
(2, 'Wesley Roman', 'Deep Learning, Machine Learning, Python, SQL', 10, 'MBA',
 'Google ML', 'Data Scientist', 'Hire', 113002, 1, 100),
(3, 'Corey Sanchez', 'Ethical Hacking, Cybersecurity, Linux', 1, 'MBA',
 'Deep Learning Specialization', 'Cybersecurity Analyst', 'Hire', 71766, 7, 70);

select * from resumes;

select name, job_role, ai_score from resumes;

select * from resumes where recruiter_decision = 'hire';

select * from resumes where ai_score >= 90;

select * from resumes
order by salary_expectation desc;

select avg(ai_score) as avg_ai_score from resumes;

select count(*) as total_candidates from resumes;

select job_role, count(*)
from resumes 
group by job_role;

SET SQL_SAFE_UPDATES = 0;

UPDATE resumes
SET recruiter_decision = 'Reject'
WHERE ai_score < 75;

DELETE FROM resumes
WHERE experience_years = 0;

ALTER TABLE resumes
ADD interview_score INT;

ALTER TABLE resumes
MODIFY certifications VARCHAR(200);

ALTER TABLE resumes
ADD CONSTRAINT chk_ai_score CHECK (ai_score BETWEEN 0 AND 100);

START TRANSACTION;

UPDATE resumes
SET salary_expectation = salary_expectation + 5000
WHERE ai_score > 90;

SAVEPOINT before_rollback;

UPDATE resumes
SET salary_expectation = salary_expectation - 20000
WHERE experience_years < 2;

ROLLBACK TO before_rollback;

COMMIT;

CREATE VIEW shortlisted_candidates AS
SELECT name, job_role, ai_score
FROM resumes
WHERE ai_score >= 90;

SELECT * FROM shortlisted_candidates;

CREATE INDEX idx_job_role
ON resumes(job_role);

DROP VIEW shortlisted_candidates;

DROP TABLE resumes;

drop database resumescreeningdb;