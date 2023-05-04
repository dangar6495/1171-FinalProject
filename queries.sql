--for the final project database BINT
--ThIS calculate the graduation rate for BINT
SELECT COUNT(CASE WHEN program_status = 'Graduated' THEN 1 END) AS graduated_count,
       COUNT(*) AS total_count,
       ROUND(CAST(COUNT(CASE WHEN program_status = 'Graduated' THEN 1 END) AS DECIMAL) / COUNT(*) * 100, 2) AS graduation_rate
FROM student_program
WHERE program_id = (SELECT program_id FROM Program WHERE program_code = 'BINT');

--THIS shows the avage course points of each feeder instituion
SELECT f.feeder_name, 
       COUNT(DISTINCT si.student_id) AS total_students, 
       AVG(sc.course_points) AS avg_course_points
FROM student_information AS si
INNER JOIN student_courses AS sc ON si.student_id = sc.student_id
INNER JOIN feeder AS f ON si.feeder_id = f.feeder_id
GROUP BY f.feeder_name
ORDER BY avg_course_points DESC;

--show the number of fails(less than 2.0 gpa C)for each courses
SELECT c.course_title, COUNT(*) AS num_failures
FROM Student_courses sc
JOIN Courses c ON sc.course_id = c.course_id
WHERE sc.course_gpa < 2.0
GROUP BY c.course_title
ORDER BY num_failures DESC;

--Then calculate the average amount of time it takes BINT students to graduate
SELECT AVG(DATE_PART('day', grad_date::timestamp - program_start::timestamp)) AS avg_days_to_graduate, 
       AVG(DATE_PART('day', grad_date::timestamp - program_start::timestamp)) / 365 AS avg_years_to_graduate
FROM student_program sp
JOIN Program p ON sp.program_id = p.program_id
WHERE p.program_code = 'BINT';

-- the pass and failure rates of the IT(CMPS) courses in total 
SELECT 
  COUNT(CASE WHEN sc.course_grade IN ('A','B','C') THEN 1 END) AS pass_count, 
  COUNT(*) AS total_count,
  ROUND(AVG(CASE WHEN sc.course_grade IN ('A','B','C') THEN 1 ELSE 0 END) * 100, 2) AS pass_rate
FROM student_program sp
JOIN Student_courses sc ON sp.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id
JOIN Program p ON sp.program_id = p.program_id
WHERE p.program_code = 'BINT' AND c.course_code LIKE 'CMPS%';

-- the pass and failure rates of the math(MATH) courses in total 
SELECT 
  COUNT(CASE WHEN sc.course_grade IN ('A','B','C') THEN 1 END) AS pass_count, 
  COUNT(*) AS total_count,
  ROUND(AVG(CASE WHEN sc.course_grade IN ('A','B','C') THEN 1 ELSE 0 END) * 100, 2) AS pass_rate
FROM student_program sp
JOIN Student_courses sc ON sp.student_id = sc.student_id
JOIN Courses c ON sc.course_id = c.course_id
JOIN Program p ON sp.program_id = p.program_id
WHERE p.program_code = 'BINT' AND c.course_code LIKE 'MATH%';

--Failure and pass rate of each IT course for BINT students who has graduated
SELECT c.course_title, 
       COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) AS pass_count, 
       COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) AS fail_count, 
       COUNT(*) AS total_count,
       ROUND(COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS pass_rate, 
       ROUND(COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS fail_rate
FROM Courses c
LEFT JOIN (
    SELECT course_id, student_id, course_gpa
    FROM Student_courses 
    WHERE student_id IN (
        SELECT sp.student_id 
        FROM student_program sp 
        JOIN Program p ON sp.program_id = p.program_id 
        WHERE p.program_code = 'BINT' AND sp.program_status = 'Graduated'
    )
) sc ON c.course_id = sc.course_id
WHERE c.course_code LIKE 'CMPS%'
GROUP BY c.course_title
HAVING COUNT(*) > 0
ORDER BY pass_rate DESC, fail_rate ASC; 

--Failure and pass rate of each IT course for BINT all students
SELECT c.course_title, 
       COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) AS pass_count, 
       COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) AS fail_count, 
       COUNT(*) AS total_count,
       ROUND(COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS pass_rate, 
       ROUND(COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS fail_rate
FROM Courses c
LEFT JOIN (
    SELECT course_id, student_id, course_gpa
    FROM Student_courses 
    WHERE student_id IN (
        SELECT sp.student_id 
        FROM student_program sp 
        JOIN Program p ON sp.program_id = p.program_id 
        WHERE p.program_code = 'BINT'
    )
) sc ON c.course_id = sc.course_id
WHERE c.course_code LIKE 'CMPS%'
GROUP BY c.course_title
HAVING COUNT(*) > 0
ORDER BY pass_rate DESC, fail_rate ASC;

--Failure and pass rate of each IT course for BINT students who has graduated
SELECT c.course_title, 
       COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) AS pass_count, 
       COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) AS fail_count, 
       COUNT(*) AS total_count,
       ROUND(COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS pass_rate, 
       ROUND(COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS fail_rate
FROM Courses c
LEFT JOIN (
    SELECT course_id, student_id, course_gpa
    FROM Student_courses 
    WHERE student_id IN (
        SELECT sp.student_id 
        FROM student_program sp 
        JOIN Program p ON sp.program_id = p.program_id 
        WHERE p.program_code = 'BINT' AND sp.program_status = 'Graduated'
    )
) sc ON c.course_id = sc.course_id
WHERE c.course_code LIKE 'MATH%'
GROUP BY c.course_title
HAVING COUNT(*) > 0
ORDER BY pass_rate DESC, fail_rate ASC; 

--Failure and pass rate of each IT course for BINT all students
SELECT c.course_title, 
       COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) AS pass_count, 
       COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) AS fail_count, 
       COUNT(*) AS total_count,
       ROUND(COUNT(CASE WHEN sc.course_gpa >= 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS pass_rate, 
       ROUND(COUNT(CASE WHEN sc.course_gpa < 2.0 THEN 1 END) * 100.0 / COUNT(*), 2) AS fail_rate
FROM Courses c
LEFT JOIN (
    SELECT course_id, student_id, course_gpa
    FROM Student_courses 
    WHERE student_id IN (
        SELECT sp.student_id 
        FROM student_program sp 
        JOIN Program p ON sp.program_id = p.program_id 
        WHERE p.program_code = 'BINT'
    )
) sc ON c.course_id = sc.course_id
WHERE c.course_code LIKE 'MATH%'
GROUP BY c.course_title
HAVING COUNT(*) > 0
ORDER BY pass_rate DESC, fail_rate ASC;

