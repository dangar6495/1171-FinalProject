COPY program
FROM '/home/daniel/csvs/program.csv'
DELIMITER ','
CSV HEADER;

COPY feeder
FROM '/home/daniel/csvs/feeder.csv'
DELIMITER ','
CSV HEADER;

COPY Student_information
FROM '/home/daniel/csvs/student.csv'
DELIMITER ','
CSV HEADER;

COPY courses
FROM '/home/daniel/csvs/course.csv'
DELIMITER ','
CSV HEADER;

COPY student_courses
FROM '/home/daniel/csvs/student_course.csv'
DELIMITER ','
CSV HEADER;

COPY student_program
FROM '/home/daniel/csvs/student_program.csv'
DELIMITER ','
CSV HEADER;