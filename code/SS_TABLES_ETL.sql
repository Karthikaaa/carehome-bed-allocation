-- 1. DATA INTEGRATION AND MAINTENANCE

-- Creating tables from the Original data sets required for the Data mart implementation

-- North Yorkshire Location

-- This DBMS is for three care homes in North of England

-- Tables required:
-- NYR_BED
-- NYR_WARD
-- NYR_ADMISSION

-- DROPPING TABLES IN CASE THEY ALREADY EXIST


DROP TABLE NYR_ADMISSION CASCADE CONSTRAINTS;

DROP TABLE NYR_BED CASCADE CONSTRAINTS;

DROP TABLE NYR_WARD CASCADE CONSTRAINTS;

DROP TABLE NYR_CARE_CENTRE CASCADE CONSTRAINTS;

DROP TABLE NYR_PATIENT CASCADE CONSTRAINTS;

-- CREATING TABLES FOR NYR PATIENT MANAGEMENT SYSTEM


CREATE TABLE NYR_CARE_CENTRE (
    care_centre_id NUMBER(2),
    care_centre_name VARCHAR2(20) NOT NULL UNIQUE,
    address VARCHAR2(60) NOT NULL,
    town VARCHAR2(35) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    phone VARCHAR2(15) NOT NULL UNIQUE,
    postcode VARCHAR2(10) NOT NULL,
    CONSTRAINTS pk_centre_id3 PRIMARY KEY (care_centre_id)
);

-- Care centre id FK here
CREATE TABLE NYR_WARD (
    ward_id NUMBER(2),
    ward_name VARCHAR2(20) CHECK (UPPER(ward_name) in ('GENERAL WARD','ICU','PEDIATRIC')),
    ward_capacity NUMBER(2) NOT NULL,
    care_centre_id NUMBER(2) NOT NULL,
	ward_type VARCHAR2(6) CHECK (UPPER(ward_type) in ('MALE','FEMALE','MIXED')),
	ward_status VARCHAR2(8) CHECK (UPPER(ward_status) in ('ACTIVE','INACTIVE')),
    CONSTRAINTS pk_ward_id3 PRIMARY KEY(ward_id)
    );


-- Ward id is FK here
CREATE TABLE NYR_BED (
    bed_id NUMBER(2), 
    bed_type VARCHAR2(25), 
    bed_status VARCHAR2(14) CHECK (UPPER(bed_status) IN ('OCCUPIED', 'NOT OCCUPIED', ' ')),
    ward_id NUMBER(2) NOT NULL,
	cost_per_day NUMBER(3),
    CONSTRAINTS pk_bed_id2 PRIMARY KEY (bed_id)
    );

 -- two FKs here, bed and patient
CREATE TABLE NYR_ADMISSION (
    admission_no NUMBER(5),
    admission_date DATE NOT NULL, 
    patient_id NUMBER(5) NOT NULL, 
    bed_id NUMBER(2) NOT NULL,
	admission_type VARCHAR2(9) CHECK (UPPER(admission_type) IN ('EMERGENCY', 'ELECTIVE', 'DAY CASE')),
	admission_status VARCHAR(10) CHECK(UPPER(admission_status) IN ('ACTIVE','DISCHARGED','CANCELLED')),
    CONSTRAINT pk_admission_no2 PRIMARY KEY (admission_no)
    );


CREATE TABLE NYR_PATIENT(
    patient_id NUMBER(5), 
    pat_firstname VARCHAR2(20) NOT NULL, 
    pat_lastname VARCHAR2(20) NOT NULL,
    pat_address VARCHAR2(100),
	pat_town VARCHAR2(30),
	pat_postcode VARCHAR2(10),
    pat_phone_no VARCHAR2(16) NOT NULL, 
    pat_email VARCHAR2(30),
    pat_dob DATE, 
    pat_gender VARCHAR2(10), 
    bloodgroup VARCHAR2(12) CHECK (bloodgroup in ( 'O positive','O negative','A positive','A negative','B positive','B negative','AB positive','AB negative')),
    genotype VARCHAR2(3) CHECK (UPPER(genotype) in ( 'AA','AS','AC','SS')),
	bp VARCHAR2(7),
	temperature NUMBER(4,2),
	pat_type VARCHAR2(11) CHECK (UPPER(pat_type) in ( 'IN-PATIENT','OUT-PATIENT','RES-PATIENT', ' ')),
	height NUMBER(3),
	weight NUMBER(3),
    CONSTRAINTS pk_patient_id2 PRIMARY KEY(patient_id)
    );

-- -- ALTERING TABLES TO ADD FOREIGN KEYS 

ALTER TABLE NYR_WARD ADD CONSTRAINTS fk_WARD_to_CARE_CENTRE2 FOREIGN KEY(care_centre_id) REFERENCES NYR_CARE_CENTRE(care_centre_id);

ALTER TABLE NYR_BED ADD CONSTRAINTS fk_BED_to_WARD2 FOREIGN KEY(ward_id) REFERENCES NYR_WARD(ward_id);

ALTER TABLE NYR_ADMISSION ADD CONSTRAINTS fk_PATIENT_to_ADMISSION2 FOREIGN KEY(patient_id) REFERENCES NYR_PATIENT(patient_id);

ALTER TABLE NYR_ADMISSION ADD CONSTRAINTS fk_BED_to_ADMISSION2 FOREIGN KEY(bed_id) REFERENCES NYR_BED(bed_id);


-- -- INSERTING VALUES INTO TABLES

--INSERTING VALUES IN CARE CENTRE
INSERT INTO NYR_Care_Centre VALUES (1,'BEWAN CareHome','8 Leafield Drive, Pudsey','Bradford','BEWAN321@GMAIL.COM','(088)224-34125','BD4 0BN');
INSERT INTO NYR_Care_Centre VALUES (2,'ALTORN CareHome','59 Prince Of Wales Road', 'Sheffield','ALTORN212@GMAIL.COM','(012)326-31838','S1 1EE');
INSERT INTO NYR_Care_Centre VALUES (3,'WELLBEING CareHome','Meifod Isaf Cottage', 'WAKEFIELD','WELLBEING2023@GMAIL.COM','(088)224-341897','WF1 4DG');


-- -- INSERTING VALUES IN PATIENT TABLE
INSERT INTO NYR_PATIENT VALUES (1,'joy','ray','4 Church road', 'Bradford','BD8 3AG','(012)745-60713','joy@gmail.com','1/15/1950','Male','O positive','AA','90/60',37.1,'IN-PATIENT',71,176);
INSERT INTO NYR_PATIENT VALUES (2,'Esther','Solomon','11 Carrick Avenue', 'Bradford','BD19 4kG','(014)224-45113','solomon@gmail.com','5/20/1950','Female','O positive','AS','120/80',36.9,'IN-PATIENT',69,163);
INSERT INTO NYR_PATIENT VALUES (3,'Bola','Grace','4 wakefield road', 'Bradford','BD5 8KP','(014)224-45891','bola@gmail.com','5/20/1945','F','AB positive','SS','90/60',36.9,'IN-PATIENT',68,180);
INSERT INTO NYR_PATIENT VALUES (4,'Stone','Cold','1 Halley road', 'Leeds','LS5 8KP','(077)092-73266','stone@gmail.com','1/15/1940','Male','AB positive','AA','120/80',37.2,'',68,183);
INSERT INTO NYR_PATIENT VALUES (5,'Clara','Emily','5 Chads road', 'Leeds','LS3 5QP','(077)092-73265','joy@gmail.com','','Male','O positive','AA','140/90',37.0,'',71,174);
INSERT INTO NYR_PATIENT VALUES (6,'Akash','Gnit','9 bowley street', 'Leeds','LS5 9SG','(014)224-45113','gnitakash@gmail.com','10/20/1939','M','AB negative','AA','140/90',36.7,'IN-PATIENT',72,202);
INSERT INTO NYR_PATIENT VALUES (11,'Magaret','Queen','6 billy avenue', 'Leeds','LS1 3QW','(014)224-45125','mary@gmail.com','11/30/1935','Female','O positive','SS','90/60',37,'IN-PATIENT',73,181);
INSERT INTO NYR_PATIENT VALUES (7,'Smith','Turner','97 Whitcliffe Road, Cleckheaton', 'Bradford','BD19 3AG','(014)224-34125','SmithTurner@gmail.com','3/20/1940','Male','O positive','AA','90/60',37.9,'IN-PATIENT',71,176);
INSERT INTO NYR_PATIENT VALUES (8,'Johnson','Phillips','1 Black Edge Lane, Denholme', 'Bradford','BD13 4ET','(014)224-34126','JohnsonPhillips@gmail.com','1/15/1950','Male','O positive','AA','120/80',36.8,'IN-PATIENT',69,163);
INSERT INTO NYR_PATIENT VALUES (9,'Wilson','Parker','2 Greenfield Place','Glusburn','','(014)224-34127','WilsonParker@gmail.com','1/15/1935','Male','O positive','AS','140/90',36.8,'IN-PATIENT',68,180);
INSERT INTO NYR_PATIENT VALUES (10,'Moore','Edwards','36 Legrams Street', 'Bradford','BD7 1LH','(014)224-34128','MooreEdwards@gmail.com','1/15/1945','Male','O positive','AA','120/80',36.9,'IN-PATIENT',68,183);


-- -- INSERTING VALUES IN WARD TABLE
INSERT INTO NYR_WARD VALUES (1, 'GENERAL WARD', 20, 1,'MIXED','ACTIVE');
INSERT INTO NYR_WARD VALUES (2, 'GENERAL WARD', 20, 2,'','ACTIVE');
INSERT INTO NYR_WARD VALUES (3, 'ICU',20, 3,'MALE','ACTIVE');


-- --INSERTING VALUES IN BED TABLE ( ward fk here)
INSERT INTO NYR_BED VALUES (1,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (2,'MANUAL/not working', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (3,'MANUAL', 'OCCUPIED', 3, 10);
INSERT INTO NYR_BED VALUES (4,'SEMI E LECTRIC', 'OCCUPIED', 3, 15);
INSERT INTO NYR_BED VALUES (5,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (6,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (7,'ELECTRIC', 'OCCUPIED', 3, 20);
INSERT INTO NYR_BED VALUES (8,'ELECTRIC', 'NOT OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (9,'ELECTRIC', 'NOT OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (10,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (11,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (12,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (13,'MANUAL', 'OCCUPIED', 3, 10);
INSERT INTO NYR_BED VALUES (14,'SEMI ELECTRIC', 'OCCUPIED', 3, 15);
INSERT INTO NYR_BED VALUES (15,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (16,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (17,'ELECTRIC', 'OCCUPIED', 3, 20);
INSERT INTO NYR_BED VALUES (18,'ELECTRIC', 'NOT OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (19,'ELECTRIC', 'NOT OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (20,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (21,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (22,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (23,'MANUAL', 'OCCUPIED', 3, 10);
INSERT INTO NYR_BED VALUES (24,'SEMI ELECTRIC', 'OCCUPIED', 3, 15);
INSERT INTO NYR_BED VALUES (25,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (26,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (27,'ELECTRIC', 'OCCUPIED', 3, 20);
INSERT INTO NYR_BED VALUES (28,'ELECTRIC', 'NOT OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (29,'ELECTRIC', 'NOT OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (30,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (31,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (32,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (33,'MANUAL', 'OCCUPIED', 3, 10);
INSERT INTO NYR_BED VALUES (34,'SEMI ELECTRIC', 'OCCUPIED', 3, 15);
INSERT INTO NYR_BED VALUES (35,'MANUAL', 'OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (36,'ELECTRIC', 'OCCUPIED', 2, 20);
INSERT INTO NYR_BED VALUES (37,'ELECTRIC', 'OCCUPIED', 3, 20);
INSERT INTO NYR_BED VALUES (38,'ELECTRIC', 'NOT OCCUPIED', 1, 10);
INSERT INTO NYR_BED VALUES (39,'ELECTRIC', 'NOT OCCUPIED', 2, 20);


-- -- INSERTING VALUES IN ADMISSION TABLE(bed and patient fk here)
INSERT INTO NYR_ADMISSION VALUES (1,TO_DATE('03/25/2023 8:00:00 AM','mm/dd/yyyy hh:mi:ss AM'),1,1,'EMERGENCY','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (2,TO_DATE('04/13/2023 4:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),2,2,'ELECTIVE','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (3,TO_DATE('03/22/2023 2:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),3,4,'ELECTIVE','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (4,TO_DATE('01/05/2023 5:00:00 AM','mm/dd/yyyy hh:mi:ss AM'),4,3,'DAY CASE','CANCELLED');
INSERT INTO NYR_ADMISSION VALUES (5,TO_DATE('11/05/2022 1:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),5,5,'DAY CASE','DISCHARGED');
INSERT INTO NYR_ADMISSION VALUES (6,TO_DATE('11/02/2023 10:00:00 AM','mm/dd/yyyy hh:mi:ss AM'),6,6,'EMERGENCY','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (7,TO_DATE('11/03/2023 6:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),7,7,'ELECTIVE','');
INSERT INTO NYR_ADMISSION VALUES (8,TO_DATE('11/05/2022 1:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),8,8,'ELECTIVE','DISCHARGED');
INSERT INTO NYR_ADMISSION VALUES (9,TO_DATE('01/01/2022 3:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),9,9,'DAY CASE','DISCHARGED');
INSERT INTO NYR_ADMISSION VALUES (11,TO_DATE('03/25/2023 8:00:00 AM','mm/dd/yyyy hh:mi:ss AM'),1,1,'EMERGENCY','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (12,TO_DATE('04/13/2023 4:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),2,2,'ELECTIVE','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (13,TO_DATE('03/22/2023 2:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),3,4,'ELECTIVE','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (14,TO_DATE('01/05/2023 5:00:00 AM','mm/dd/yyyy hh:mi:ss AM'),4,3,'DAY CASE','CANCELLED');
INSERT INTO NYR_ADMISSION VALUES (15,TO_DATE('11/05/2022 1:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),5,5,'DAY CASE','');
INSERT INTO NYR_ADMISSION VALUES (16,TO_DATE('11/02/2023 10:00:00 AM','mm/dd/yyyy hh:mi:ss AM'),6,6,'EMERGENCY','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (17,TO_DATE('11/03/2023 6:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),7,7,'ELECTIVE','ACTIVE');
INSERT INTO NYR_ADMISSION VALUES (18,TO_DATE('11/05/2022 1:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),8,8,'ELECTIVE','DISCHARGED');
INSERT INTO NYR_ADMISSION VALUES (19,TO_DATE('01/01/2022 3:00:00 PM','mm/dd/yyyy hh:mi:ss PM'),9,9,'DAY CASE','DISCHARGED');


-- West Yorkshire Location

-- This DBMS is for three care homes in West of England

-- Tables required:
-- WYR_BED
-- WYR_WARD
-- WYR_Reservation
-- WYR_BedAssigned

-- DROPPING TABLES IN CASE THEY ALREADY EXIST

DROP TABLE WYR_Employee  CASCADE CONSTRAINTS;
DROP TABLE WYR_Reservation  CASCADE CONSTRAINTS;
DROP TABLE WYR_Bed  CASCADE CONSTRAINTS;
DROP TABLE WYR_CARE_CENTRE  CASCADE CONSTRAINTS;
DROP TABLE WYR_WARD  CASCADE CONSTRAINTS;
DROP TABLE WYR_BedAssigned  CASCADE CONSTRAINTS;


-- CREATING TABLES FOR WYR PATIENT MANAGEMENT SYSTEM

CREATE TABLE WYR_CARE_CENTRE (
    care_id NUMBER(2),
    care_centre_name VARCHAR2(20) UNIQUE,
    address VARCHAR2(60) NOT NULL,
    town VARCHAR2(35) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    phone VARCHAR2(25) NOT NULL UNIQUE,
    postcode VARCHAR2(10) NOT NULL,
    CONSTRAINTS pk_centre_id2 PRIMARY KEY (care_id)
);

CREATE TABLE WYR_Employee (
    employee_id INT   PRIMARY KEY,
    employee_name VARCHAR(100)  NOT NULL,
    employee_type VARCHAR(20),
    employee_address VARCHAR(200)  NOT NULL,
    employee_contact VARCHAR(20)  UNIQUE,
    gender VARCHAR(10),
    dob TIMESTAMP  NOT NULL,
    doj TIMESTAMP
);

CREATE TABLE WYR_Reservation (
    reservation_id INT   GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    waiting_code VARCHAR(10)  NOT NULL,
    booking_date TIMESTAMP,
    notes VARCHAR(500) ,
    reservation_type VARCHAR(20)  NOT NULL,
    reservation_subtype  VARCHAR(20)  NOT NULL,
    reservation_status VARCHAR(20),
    employee_id INT NULL ,
    admission_date TIMESTAMP  NULL,
    FOREIGN KEY (employee_id) REFERENCES WYR_Employee (employee_id)
);

-- Care centre id FK here
CREATE TABLE WYR_WARD(
    ward_no NUMBER(5),
    ward_name VARCHAR2(20),
    ward_capacity NUMBER(2) NOT NULL,
    care_id NUMBER(2) NOT NULL,
	ward_status VARCHAR2(8),
    CONSTRAINTS pk_ward_id2 PRIMARY KEY(ward_no),
    FOREIGN KEY (care_id) REFERENCES WYR_CARE_CENTRE(care_id)
    );

CREATE TABLE WYR_Bed (
  ward_no NUMBER(5),
  bed_no INT PRIMARY KEY,
  bed_type VARCHAR(50),
  bed_status VARCHAR(50),
  FOREIGN KEY (ward_no) REFERENCES WYR_WARD (ward_no)
);

CREATE TABLE WYR_BedAssigned (
    reservation_id INT NOT NULL,
    bed_no INT  NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES WYR_Reservation(reservation_id),
    FOREIGN KEY (bed_no) REFERENCES WYR_Bed(bed_no)
);







ALTER TABLE WYR_Employee
ADD CONSTRAINT CHK_Employee_Contact2 CHECK (REGEXP_LIKE(employee_contact, '^[0-9]{10}$'));



-- -- INSERTING VALUES INTO TABLES


-- INSERTING VALUES INTO VALUES CARE CENTRE TABLE
INSERT INTO WYR_Care_Centre VALUES (1,'LBU CareHome','80 Foxcroft Drive','Leeds','BEWAN321@GMAIL.COM','(0113)224-34125','LS4 0BN');
INSERT INTO WYR_Care_Centre VALUES (2,'OSCAR CareHome','59 Wales Road', 'Leeds','ALTORN212@GMAIL.COM','(0113)326-31838','LS1 1EE');
INSERT INTO WYR_Care_Centre VALUES (3,'JUNO CareHome','108 Otley Cottage', 'Harrogate','WELLBEING2023@GMAIL.COM','(0112)224-341897','HG1 4DG');


-- --INSERTING VALUES INTO WARD TABLE(care centre fk)
INSERT INTO WYR_WARD VALUES (1, 'GENERAL care', 20, 1,'ACTIVE');
INSERT INTO WYR_WARD VALUES (2, 'GENERAL care', 20, 2,'ACTIVE');
INSERT INTO WYR_WARD VALUES (3, 'GENERAL care',20, 3,'ACTIVE');


-- --INSERTING VALUES INTO EMPLOYEE TABLE(care centre fk)
INSERT INTO WYR_Employee ( employee_id, employee_name, employee_type, employee_address, employee_contact, gender, dob, doj)
VALUES ('1', 'Dr. Elizabeth P. Ervin', 'Doctor', '51 Stone St, CRAW KA27 4XU', '7124543490', 'Male', to_date('1980-03-11','yyyy-mm-dd'), to_date('2022-01-15','yyyy-mm-dd'));
INSERT INTO WYR_Employee (  employee_id, employee_name, employee_type, employee_address, employee_contact, gender, dob, doj)
VALUES ('2', 'Dr. Douglas B. Jones', 'Doctor', '78 Way, Kent Street, RHIWDERIN NP1 6DQ', '7124543491', 'Male', to_date('1970-08-12','yyyy-mm-dd'), to_date('2021-04-09','yyyy-mm-dd'));
INSERT INTO WYR_Employee (  employee_id, employee_name, employee_type, employee_address, employee_contact, gender, dob, doj)
VALUES ('3', 'Christine J. Sanchez', 'Nurse', '23 Kent Street, CROSSAIG PA29 5JL', '7124543492', 'Female', to_date('1956-01-01','yyyy-mm-dd'), to_date('2022-12-12','yyyy-mm-dd'));
INSERT INTO WYR_Employee (  employee_id, employee_name, employee_type, employee_address, employee_contact, gender, dob, doj)
VALUES ('4', 'Kristine J. Taylor', '', '58 Lammas Street, GREAT BUSBY TS9 1WW', '7124543493', '', to_date('1968-03-02','yyyy-mm-dd'), to_date('2023-07-05','yyyy-mm-dd'));


-- --INSERTING VALUES INTO RESERVATION TABLE(care centre fk)
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('01', to_date('2023-04-01','yyyy-mm-dd'), 'Patient needs wheelchair access','Bed','Single', 'Confirmed', to_date('2023-04-08','yyyy-mm-dd'),4);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('02', '', 'Patient has allergies to penicillin','Bed','Double', 'Confirmed', to_date('2023-04-08','yyyy-mm-dd'),3);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('03', to_date('2023-04-04','yyyy-mm-dd'), 'Patient requires interpreter','Bed','Single', 'Confirmed', to_date('2023-04-08','yyyy-mm-dd'),2);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('04', to_date('2023-04-05','yyyy-mm-dd'), 'Patient is diabetic','Bed','Single', 'Confirmed', to_date('2023-04-08','yyyy-mm-dd'),1);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('05', to_date('2023-04-06','yyyy-mm-dd'), 'Patient has high blood pressure','Bed','Double', 'Confirmed', to_date('2023-04-09','yyyy-mm-dd'),1);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('06', to_date('2023-04-07','yyyy-mm-dd'), 'Patient needs surgery','Room','Deluxe Kings Basic', 'Confirmed', to_date('2023-04-08','yyyy-mm-dd'),2);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('07', to_date('2023-04-08','yyyy-mm-dd'), 'Patient has history of heart disease','Bed','Single', 'Confirmed', to_date('2023-04-08','yyyy-mm-dd'),1);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('08', to_date('2023-04-09','yyyy-mm-dd'), 'Patient requires wheelchair access','Bed','Single', ' ', to_date('2023-04-12','yyyy-mm-dd'),4);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('09', to_date('2023-04-10','yyyy-mm-dd'), 'Patient has a broken leg','Room','Deluxe', 'Cancelled', NULL,NULL);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('10', to_date('2023-01-04','yyyy-mm-dd'), 'Patient requires interpreter','Room','Standard', '', to_date('2023-02-01','yyyy-mm-dd'),3);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('11', to_date('2023-02-01','yyyy-mm-dd'), 'Patient requires interpreter','Room','Deluxe', 'Confirmed', to_date('2023-02-19','yyyy-mm-dd'),2);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('12', to_date('2022-12-03','yyyy-mm-dd'), 'Patient has allergies to penicillin','Bed','Double', 'Confirmed', to_date('2023-01-11','yyyy-mm-dd'),3);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('13', to_date('2023-01-04','yyyy-mm-dd'), 'Patient requires interpreter','Bed','Single', '', to_date('2023-02-18','yyyy-mm-dd'),2);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('14', to_date('2022-10-13','yyyy-mm-dd'), 'Patient is diabetic','Bed','Single', 'Confirmed', to_date('2022-11-01','yyyy-mm-dd'),4);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('15', to_date('2023-03-02','yyyy-mm-dd'), 'Patient has high blood pressure','Bed','Double', 'Confirmed', to_date('2023-03-05','yyyy-mm-dd'),1);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('16', to_date('2021-09-01','yyyy-mm-dd'), 'Patient needs surgery','Room','Deluxe', 'Confirmed', to_date('2021-11-11','yyyy-mm-dd'),2);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('17', to_date('2023-03-12','yyyy-mm-dd'), 'Patient has history of heart disease','Bed','Single', 'Confirmed', to_date('2023-03-19','yyyy-mm-dd'),1);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('18', to_date('2022-01-19','yyyy-mm-dd'), 'Patient requires wheelchair access','Bed','Single', 'Confirmed', to_date('2022-02-22','yyyy-mm-dd'),4);
INSERT INTO WYR_Reservation ( waiting_code, booking_date, notes, reservation_type, reservation_subtype, reservation_status, admission_date,employee_id)
VALUES ('19', to_date('2022-11-04','yyyy-mm-dd'), 'Patient has a broken leg','Room','Deluxe', 'Cancelled',  NULL,NULL);


-- --INSERTING VALUES INTO BED TABLE(care centre fk)
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1102, 'Single', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1201, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1202, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1301, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1401, 'Single', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1402, 'Double', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1501, 'Double', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1502, 'Double', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (1,1601, 'Double', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2102, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2201, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2202, 'Single', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2301, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2401, 'Single', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2402, 'Double', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2501, 'Double', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2502, 'Double', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (2,2601, 'Double', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3102, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3201, 'Single', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3202, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3301, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3401, 'Single', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3402, 'Double', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3501, 'Double', 'Occupied');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3502, 'Double', 'Available');
INSERT INTO WYR_Bed (ward_no,bed_no, bed_type, bed_status) VALUES (3,3601, 'Double', 'Occupied');



-- INSERTING VALUES INTO BED ASSIGNED TABLE(care centre fk)
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (1, 1102);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (2, 1201);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (3, 1202);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (4, 1301);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (5, 1401);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (6, 1501);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (7, 1502);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (8, 3102);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (10, 3202);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (11, 3502);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (12, 2601);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (13, 2601);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (14, 3501);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (15, 3601);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (16, 2401);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (17, 2402);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (18, 2601);
INSERT INTO WYR_BedAssigned (reservation_id, bed_no) VALUES (19, 2202);




-- Forward Engineering
-- Creating Tables for FACTS and DIMENSIONS

-- DROPPING TABLES IN CASE THEY ALREADY EXIST

DROP TABLE TIME_DIM CASCADE CONSTRAINTS;

DROP TABLE WARD_DIM CASCADE CONSTRAINTS;

DROP TABLE BED_OCCUPANCY_FACT CASCADE CONSTRAINTS;

-- Create a Database table to represent the "TIME_DIM" entity.
CREATE TABLE TIME_DIM(
    Time_ID INTEGER NOT NULL,
    For_Year    INTEGER,
    -- Specify the PRIMARY KEY constraint for table "TIME_DIM".
    -- This indicates which attribute(s) uniquely identify each row of data.
    CONSTRAINT  pk_TIME_DIM PRIMARY KEY (Time_ID)
);

-- Create a Database table to represent the "WARD_DIM" entity.
-- Effective_Date attribute is to implement Type 2 SCD to accomodate changes made to Ward_Name attribute
CREATE TABLE WARD_DIM(
    Ward_ID INTEGER NOT NULL,
    Ward_No INTEGER,
    Ward_Name   VARCHAR(50),
    Care_Centre_Name    VARCHAR(50),
    Effective_Date    TIMESTAMP,
    -- Specify the PRIMARY KEY constraint for table "WARD_DIM".
    -- This indicates which attribute(s) uniquely identify each row of data.
    CONSTRAINT  pk_WARD_DIM PRIMARY KEY (Ward_ID)
);

-- Create a Database table to represent the "BED_OCCUPANCY_FACT" entity.
CREATE TABLE BED_OCCUPANCY_FACT(
    Report_No   INTEGER NOT NULL,
    Ward_ID INTEGER NOT NULL ,
    Time_ID INTEGER NOT NULL ,
    Total_number_of_occupied_beds   INTEGER,
    -- Specify the PRIMARY KEY constraint for table "BED_OCCUPANCY_FACT".
    -- This indicates which attribute(s) uniquely identify each row of data.
    CONSTRAINT  pk_BED_OCCUPANCY_FACT PRIMARY KEY (Report_No)
);

-- Alter Tables to add fk constraints --

-- Alter table to add new constraints required to implement the "BED_OCCUPANCY_FACT_TIME_DIM" relationship
-- This constraint ensures that the foreign key of table "BED_OCCUPANCY_FACT"
-- correctly references the primary key of table "TIME_DIM"

ALTER TABLE BED_OCCUPANCY_FACT ADD CONSTRAINT fk1_BED_OCCUPANCY_FACT_to_TIME_DIM FOREIGN KEY(Time_ID) REFERENCES TIME_DIM(Time_ID);


-- Alter table to add new constraints required to implement the "BED_OCCUPANCY_FACT_WARD_DIM" relationship
-- This constraint ensures that the foreign key of table "BED_OCCUPANCY_FACT"
-- correctly references the primary key of table "WARD_DIM"

ALTER TABLE BED_OCCUPANCY_FACT ADD CONSTRAINT fk2_BED_OCCUPANCY_FACT_to_WARD_DIM FOREIGN KEY(Ward_ID) REFERENCES WARD_DIM(Ward_ID);


-- Extract just the data we need for report total_no_of_occupied_beds per ward per year

-- explore NYR Location database

-- SELECT NYR_BED.ward_id AS WARD, NYR_ADMISSION.admission_date AS admission_date, NYR_BED.BED_STATUS FROM NYR_BED   
-- INNER JOIN NYR_ADMISSION on NYR_BED.bed_id = NYR_ADMISSION.bed_id  ;


-- -- explore WYR Location database

-- SELECT WYR_Bed.WARD_NO AS WARD, WYR_Reservation.admission_date AS admission_date, WYR_Bed.BED_STATUS FROM WYR_Bed  
-- INNER JOIN WYR_BedAssigned
-- on WYR_Bed.bed_no = WYR_BedAssigned.bed_no
-- INNER JOIN WYR_Reservation
-- on WYR_BedAssigned.reservation_id = WYR_Reservation.reservation_id;

-- -- --

-- -- EXTRACT

-- -- --

--Put all data  from NYR location to staging area
-- Extracting year from admission date to insert to staging area ( Extraction & Transformation)
DROP TABLE S1_STAGEAREA;
CREATE TABLE S1_STAGEAREA AS SELECT NYR_BED.ward_id AS WARD_No, NYR_WARD.ward_name AS WARD_Name, EXTRACT(YEAR FROM NYR_ADMISSION.admission_date) AS ADMISSION_YEAR, NYR_BED.BED_STATUS,
NYR_CARE_CENTRE.care_centre_name AS Care_Centre_Name FROM NYR_BED   
INNER JOIN NYR_ADMISSION on NYR_BED.bed_id = NYR_ADMISSION.bed_id
INNER JOIN NYR_WARD on NYR_WARD.ward_id = NYR_BED.ward_id
INNER JOIN NYR_CARE_CENTRE on NYR_WARD.care_centre_id = NYR_CARE_CENTRE.care_centre_id;

-- SELECT * FROM S1_STAGEAREA;

-- Adding a column to specify data source location
ALTER TABLE S1_STAGEAREA 
ADD DATASOURCE VARCHAR2(5);

-- Updating data source location as NYR
UPDATE S1_STAGEAREA SET DATASOURCE = 'NYR';



-- Put all data  from WYR location to staging area and mention data source as WYR
-- Extracting year from admission date to insert to staging area ( Extraction & Transformation)

INSERT INTO S1_STAGEAREA
SELECT
  WYR_Bed.WARD_NO,
  WYR_WARD.WARD_Name,
  EXTRACT(YEAR FROM WYR_Reservation.admission_date),
  WYR_Bed.BED_STATUS,
  WYR_CARE_CENTRE.care_centre_name,
  'WYR'
FROM
  WYR_Bed
  INNER JOIN WYR_BedAssigned ON WYR_Bed.bed_no = WYR_BedAssigned.bed_no
  INNER JOIN WYR_Reservation ON WYR_BedAssigned.reservation_id = WYR_Reservation.reservation_id
  INNER JOIN WYR_WARD ON WYR_WARD.ward_NO = WYR_BED.ward_NO
  INNER JOIN WYR_CARE_CENTRE ON WYR_WARD.care_id = WYR_CARE_CENTRE.care_id;




SELECT * FROM S1_STAGEAREA;


-- Data Quality checks and transformation on S1_STAGEAREA

--Table to log the changes made to the data,
-- log ETL changes
DROP table etl_log cascade constraints;

CREATE TABLE etl_log
(log_id NUMBER(5) NOT NULL, 
table_name VARCHAR2(20),
action_type VARCHAR2(50),
old_value VARCHAR2(50),
new_value VARCHAR2(50), 
status_update_date timestamp);

drop sequence EL_SEQ;
create sequence EL_SEQ
start with 1
increment by 1
maxvalue 10000
minvalue 1;

-- Now as part of the ETL - T for transformation, we will do data quality checks and log them in a data issues table
-- we have decided to update S1_STAGEAREA directly. 


DROP TRIGGER trg_year_etl_log;

-- trigger for the ETL Changes in year column
CREATE OR REPLACE TRIGGER trg_year_etl_log
AFTER INSERT OR UPDATE OR DELETE ON S1_STAGEAREA
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'INSERT', 'NA',:NEW.ADMISSION_YEAR, SYSTIMESTAMP);
--    ELSIF UPDATING THEN
--       INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
--       VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'UPDATE', :OLD.ADMISSION_YEAR, :NEW.ADMISSION_YEAR, SYSTIMESTAMP);
   ELSIF DELETING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'DELETE', :OLD.ADMISSION_YEAR, 'DELETED', SYSTIMESTAMP);
   END IF;
END;
/



DROP TRIGGER trg_bedstatus_etl_log;

-- trigger for the ETL Changes in BED_STATUS column
CREATE OR REPLACE TRIGGER trg_bedstatus_etl_log
AFTER INSERT OR UPDATE OR DELETE ON S1_STAGEAREA
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'INSERT', 'NA',:NEW.BED_STATUS, SYSTIMESTAMP);
   ELSIF UPDATING THEN
      IF :OLD.BED_STATUS != :NEW.BED_STATUS THEN
        INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
        VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'UPDATE', :OLD.BED_STATUS, :NEW.BED_STATUS, SYSTIMESTAMP);
      END IF;  
   ELSIF DELETING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'DELETE', :OLD.BED_STATUS, 'DELETED', SYSTIMESTAMP);
   END IF;
END;
/



DROP TRIGGER trg_carecentre_etl_log;

-- trigger for the ETL Changes in Care_Centre_Name column
CREATE OR REPLACE TRIGGER trg_carecentre_etl_log
AFTER INSERT OR UPDATE OR DELETE ON S1_STAGEAREA
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'INSERT', 'NA',:NEW.Care_Centre_Name, SYSTIMESTAMP);
   ELSIF UPDATING THEN
      IF :OLD.Care_Centre_Name != :NEW.Care_Centre_Name THEN
        INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
        VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'UPDATE', :OLD.Care_Centre_Name, :NEW.Care_Centre_Name, SYSTIMESTAMP);
      END IF;
   ELSIF DELETING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'DELETE', :OLD.Care_Centre_Name, 'DELETED', SYSTIMESTAMP);
   END IF;
END;
/

DROP TRIGGER trg_wardname_etl_log;

-- trigger for the ETL Changes in Ward_Name column
CREATE OR REPLACE TRIGGER trg_wardname_etl_log
AFTER INSERT OR UPDATE OR DELETE ON S1_STAGEAREA
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'INSERT', 'NA',:NEW.Ward_Name, SYSTIMESTAMP);
   ELSIF UPDATING THEN
      IF :OLD.Ward_Name != :NEW.Ward_Name THEN
        INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
        VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'UPDATE', :OLD.Ward_Name, :NEW.Ward_Name, SYSTIMESTAMP);
      END IF;
   ELSIF DELETING THEN
      INSERT INTO etl_log (log_id, table_name, action_type, old_value, new_value, status_update_date)
      VALUES (EL_SEQ.NEXTVAL, 'S1_STAGEAREA', 'DELETE', :OLD.Ward_Name, 'DELETED', SYSTIMESTAMP);
   END IF;
END;
/

-- -- --

-- -- TRANSFORM

-- -- --

-- Transformations in Staging Area


-- Cleaning Data

-- Deleting the row with an empty admission_date/year field as this is required for report generation and 
-- since the number of missing information rows is very minimal (=1 in this case)


DELETE FROM S1_STAGEAREA WHERE ADMISSION_YEAR IS NULL;

-- Displaying log table
SELECT * FROM etl_log;

-- Updating bed status values
-- Available -> NOT OCCUPIED
-- Occupied -> OCCUPIED
UPDATE S1_STAGEAREA SET BED_STATUS = 'NOT OCCUPIED' WHERE BED_STATUS = 'Available';
-- SELECT * FROM etl_log;


UPDATE S1_STAGEAREA SET BED_STATUS = 'OCCUPIED' WHERE BED_STATUS = 'Occupied';
-- SELECT * FROM etl_log;


-- Transforming Data

-- Updating Ward_Name and Care_Centre_Name to upper case values
UPDATE S1_STAGEAREA SET Care_Centre_Name = UPPER(Care_Centre_Name);
UPDATE S1_STAGEAREA SET Ward_Name = UPPER(Ward_Name);
SELECT * FROM etl_log;

SELECT * FROM S1_STAGEAREA;

-- -- --

-- -- LOAD

-- -- --


-- Populate the Dimension tables
-- Populate the fact table


-- Populate the time_dim
DROP sequence time_seq;
create sequence time_seq
start with 1
increment by 1
maxvalue 10000
minvalue 1;


INSERT INTO TIME_DIM (TIME_ID, FOR_YEAR)
SELECT time_seq.nextval, ADMISSION_YEAR
FROM (SELECT DISTINCT ADMISSION_YEAR FROM S1_STAGEAREA WHERE BED_STATUS='OCCUPIED');

SELECT * FROM TIME_DIM;



-- Populate the ward_dim
DROP sequence ward_seq;
create sequence ward_seq
start with 1
increment by 1
maxvalue 10000
minvalue 1;

INSERT INTO WARD_DIM (WARD_ID, ward_no, ward_name, care_centre_name, Effective_Date)
SELECT ward_seq.nextval, WARD_NO, WARD_NAME, Care_Centre_Name, SYSTIMESTAMP
FROM (SELECT DISTINCT WARD_NO, WARD_NAME, Care_Centre_Name
    FROM S1_STAGEAREA
    WHERE BED_STATUS = 'OCCUPIED');


SELECT * FROM WARD_DIM;


-- This tmp table is used to calculate the measure of total no of occupied beds 
DROP table tmp_bed_occupancy;

CREATE TABLE tmp_bed_occupancy AS
SELECT WARD_NO, admission_year, Care_Centre_Name, COUNT(*) as no_of_occupied_beds
FROM S1_STAGEAREA
WHERE bed_status = 'OCCUPIED' 
GROUP BY WARD_NO, admission_year, Care_Centre_Name  ;
SELECT * FROM tmp_bed_occupancy;


-- Populate the fact table
DROP sequence fact_seq;
create sequence fact_seq
start with 1
increment by 1
maxvalue 10000
minvalue 1;


INSERT INTO BED_OCCUPANCY_FACT (Report_No, Ward_ID, Time_ID, Total_number_of_occupied_beds)
SELECT fact_seq.nextval,  WARD_DIM.Ward_ID, TIME_DIM.TIME_ID, tmp_bed_occupancy.no_of_occupied_beds
FROM tmp_bed_occupancy
INNER JOIN TIME_DIM ON tmp_bed_occupancy.admission_year = TIME_DIM.For_Year
INNER JOIN WARD_DIM ON tmp_bed_occupancy.Care_Centre_Name = WARD_DIM.Care_Centre_Name;

SELECT * FROM BED_OCCUPANCY_FACT;
