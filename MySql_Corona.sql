USE covid19;

-- 1. Find the number of corona patients who faced shortness of breath.

SELECT 
	Count(*) AS Patients 
FROM corona_dataset 
WHERE Corona = 'positive' 
AND Shortness_of_breath = 'TRUE';

-- 2. Find the number of negative corona patients who have fever and sore_throat. 

Select 
     Count(*) AS Patients 
FROM corona_dataset 
WHERE corona= 'negative' 
AND fever = 'TRUE' 
AND sore_throat = 'TRUE';

-- 3. Group the data by month and rank the number of positive cases.

SELECT
    EXTRACT(MONTH FROM Test_date) AS Month,
    SUM(Corona = 'positive') AS Total_Positive_Cases,
    RANK() OVER (ORDER BY SUM(Corona = 'positive') DESC) AS Ranks
FROM corona_dataset
WHERE Corona = 'positive'
GROUP BY Month
ORDER BY Month;

-- 4. Find the female negative corona patients who faced cough and headache.

SELECT Ind_ID
FROM corona_dataset
WHERE Sex='female'
    AND corona = 'negative'
    AND Cough_symptoms = 'TRUE' 
    AND headache = 'TRUE';
    
-- 5. How many elderly corona patients have faced breathing problems?

SELECT count(*) AS Total_breathing_problem_Cases 
FROM corona_dataset 
WHERE Corona='positive'
     AND Age_60_above='yes' 
     AND Shortness_of_breath='TRUE';
     
-- 6. Which three symptoms were more common among COVID positive patients?

WITH CommonSymptoms AS (
    SELECT 
        'Cough_symptoms' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'positive' AND Cough_symptoms = 'TRUE'
    UNION ALL
    SELECT
        'Fever' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'positive' AND Fever = 'TRUE'
    UNION ALL
    SELECT
        'Sore_throat' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'positive' AND Sore_throat = 'TRUE'
    UNION ALL
    SELECT
        'Shortness_of_breath' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE'
    UNION ALL
    SELECT
        'Headache' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'positive' AND Headache = 'TRUE'
)
SELECT
    Symptom,
    SUM(count) AS Total_Patients
FROM CommonSymptoms
GROUP BY Symptom
ORDER BY Total_Patients DESC
LIMIT 3;

-- 7. Which symptom was less common among COVID negative people?

WITH CommonSymptoms AS (
    SELECT 
        'Cough_symptoms' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'negative' AND Cough_symptoms = 'TRUE'
    UNION ALL
    SELECT
        'Fever' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'negative' AND Fever = 'TRUE'
    UNION ALL
    SELECT
        'Sore_throat' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'negative' AND Sore_throat = 'TRUE'
    UNION ALL
    SELECT
        'Shortness_of_breath' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'negative' AND Shortness_of_breath = 'TRUE'
    UNION ALL
    SELECT
        'Headache' AS Symptom,
        COUNT(*) AS count
    FROM corona_dataset
    WHERE Corona = 'negative' AND Headache = 'TRUE'
)
SELECT
    Symptom,
    SUM(count) AS Total_Patients
FROM CommonSymptoms
GROUP BY Symptom
ORDER BY Total_Patients ASC
LIMIT 1;

-- 8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

WITH CommonSymptoms AS (
    SELECT 
        'Cough_symptoms' AS symptom, 
        COUNT(*) AS count 
	FROM corona_dataset 
    WHERE Corona = 'positive' AND Cough_symptoms = 'TRUE'
	      AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 
        'Fever' AS symptom, 
        COUNT(*) AS count 
	FROM corona_dataset 
    WHERE Corona = 'positive' AND Fever = 'TRUE' 
          AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 
        'Sore_throat' AS symptom, 
        COUNT(*) AS count 
	FROM corona_dataset 
    WHERE Corona = 'positive' AND Sore_throat = 'TRUE' 
          AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 
        'Shortness_of_breath' AS symptom, 
        COUNT(*) AS count 
	FROM corona_dataset 
    WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE' 
         AND Sex='Male' AND Known_contact ='abroad'
    UNION ALL
    SELECT 
		'Headache' AS symptom, 
        COUNT(*) AS count 
	FROM corona_dataset 
    WHERE Corona = 'positive' AND Headache = 'TRUE' 
          And Sex='Male' AND Known_contact ='abroad'
)
SELECT
    Symptom,
    SUM(count) AS Total_Patients
FROM CommonSymptoms
GROUP BY Symptom
ORDER BY Total_Patients DESC 
LIMIT 1;