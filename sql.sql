CREATE TABLE Program(
    program_id INT NOT NULL,
    program_code VARCHAR(50),
    program_name TEXT,
	degree_id INT,
    degree_type TEXT,
    PRIMARY KEY(program_id)
);

CREATE TABLE Feeder(
    feeder_id INT NOT NULL,
    feeder_name VARCHAR(100),
    PRIMARY KEY(feeder_id)
);

CREATE TABLE Student_information(
    student_id INT NOT NULL,
	dob CHAR(10),
    gender CHAR(1) NOT NULL check(gender in ('F','M')),
    ethnicity TEXT,
    city TEXT,
    district TEXT,
    feeder_id INT,
    PRIMARY KEY(student_id),
    FOREIGN KEY(feeder_id) REFERENCES Feeder(feeder_id)
);

CREATE TABLE Courses(
    course_id INT NOT NULL,
    course_code CHAR(50),
    course_title TEXT,
    course_credits INT,
    PRIMARY KEY(course_id)
);

CREATE TABLE Student_courses(
    student_course_id  INT NOT NULL,
	student_id INT NOT NULL,
	course_id INT NOT NULL,
    semester VARCHAR(50),
    semester_credits_attempted DECIMAL,
    semester_credits_earned DECIMAL,
    semester_points DECIMAL,
    semester_gpa DECIMAL,
    course_grade CHAR (2),
    course_gpa DECIMAL,
    cgpa DECIMAL,
    course_points DECIMAL,
    comments TEXT,
    PRIMARY KEY(student_course_id),
    FOREIGN KEY(student_id) REFERENCES Student_information(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

CREATE TABLE student_program(
    student_program_id INT,
    student_id INT NOT NULL,
    program_id INT NOT NULL,
    program_status VARCHAR (15) NOT NULL,
    program_start CHAR (10),
    grad_date CHAR (10),
    program_end CHAR (10),
	PRIMARY KEY
    FOREIGN KEY (student_id) REFERENCES Student_information(student_id),
    FOREIGN KEY (program_id)REFERENCES program (program_id)
);
