 CREATE TABLE patient_data (
	patient_id INT NOT NULL PRIMARY KEY,
    age INT,
    gender VARCHAR(6),
    ethnicity VARCHAR(20),
    marital_status VARCHAR(20),
    education_level VARCHAR(30),
    ocd_diagnosis_date DATE,
    duration_of_symptoms_months INT,
    previous_diagnoses VARCHAR(20),
    family_history_of_ocd VARCHAR(3),
    obsession_type VARCHAR(30),
    compulsion_type VARCHAR(30),
    y_BOCS_score_obsessions INT,
    y_BOCS_score_compulsions INT, 
    depression_diagnosis VARCHAR(3),
    anxiety_diagnosis VARCHAR(3),
    medications VARCHAR(30)
 );
 
 
  select * from patient_data;


 -- Number of people who took the test
 select COUNT(*) AS number_of_patients from patient_data;
 
 -- 1. Number of Female and Male that have OCD
 
 SELECT gender, COUNT(*) AS patient_count
 FROM patient_data
 GROUP BY gender
 ORDER BY gender DESC;
  
 -- 2. Average Obsession Score, Rounded to 2dp
 SELECT gender, ROUND(AVG(y_BOCS_score_obsessions), 2) as average_obsession_score
 FROM patient_data
 GROUP BY gender
 ORDER BY gender;
 
 -- 3. Percentage of Male to  Female who has OCD
 
 CREATE TABLE pct_data AS (
  SELECT 
	gender, 
    COUNT(*) AS patient_count,  
    ROUND(AVG(y_BOCS_score_obsessions), 2) as average_obsession_score
 FROM patient_data
 GROUP BY gender
 ORDER BY gender DESC
 );
 
 SELECT 
	SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END) AS count_female,
	SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END) AS count_male,
    
    ROUND(SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END)/
    (SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END) + SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END)) * 100,2) 
AS percentage_of_female,

ROUND(SUM(CASE WHEN gender = 'Male' THEN patient_count ELSE 0 END)/
    (SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END) + SUM(CASE WHEN gender = 'Female' THEN patient_count ELSE 0 END)) * 100,2) 
AS percentage_of_male

FROM pct_data;

-- 4. Count of Obsessison score by Ethnicities that have OCD
SELECT ethnicity, COUNT(y_BOCS_score_obsessions) AS count_of_obsession_score
FROM patient_data
GROUP BY ethnicity
ORDER BY count_of_obsession_score DESC;

-- 5. Average Obsessison score by Ethnicities that have OCD
SELECT ethnicity, ROUND(AVG(y_BOCS_score_obsessions), 2) AS avg_of_obsession_score
FROM patient_data
GROUP BY ethnicity
ORDER BY avg_of_obsession_score DESC;

-- 6. What is the most common Obsession Type 
SELECT obsession_type, COUNT(patient_id) AS patient_count
FROM patient_data
GROUP BY obsession_type
ORDER BY patient_count DESC;

-- 7. What is the most common Obsession Type & it's respective Average Obsession Score
SELECT obsession_type, COUNT(patient_id) AS patient_count, ROUND(AVG(y_BOCS_score_obsessions), 2) AS avg_obsession_score
FROM patient_data
GROUP BY obsession_type
ORDER BY avg_obsession_score DESC;

-- 8. What is the most common Compulsion Type 
SELECT compulsion_type, COUNT(patient_id) AS patient_count
FROM patient_data 
GROUP BY compulsion_type
ORDER BY patient_count DESC;

-- 9. What is the most common Compulsion Type & it's respective Average Obsession Score
SELECT compulsion_type, COUNT(patient_id) AS patient_count, ROUND(AVG(y_BOCS_score_obsessions), 2) AS avg_obsession_score
FROM patient_data
GROUP BY compulsion_type
ORDER BY avg_obsession_score DESC;
