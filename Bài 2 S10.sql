CREATE DATABASE HospitalIndexDB;
USE HospitalIndexDB;

CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100),
    Phone VARCHAR(20),
    Age INT
);

DELIMITER $$

CREATE PROCEDURE InsertPatients()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 500000 DO
        INSERT INTO Patients (Full_Name, Phone, Age)
        VALUES (
            CONCAT('Patient_', i),
            CONCAT('090', LPAD(i, 7, '0')),
            FLOOR(18 + (RAND() * 60))
        );

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL InsertPatients();

SELECT * 
FROM Patients
WHERE Phone = '0900001000';

EXPLAIN
SELECT * 
FROM Patients
WHERE Phone = '0900001000';

CREATE INDEX idx_phone
ON Patients(Phone);

SELECT * 
FROM Patients
WHERE Phone = '0900001000';

EXPLAIN
SELECT * 
FROM Patients
WHERE Phone = '0900001000';

DROP PROCEDURE IF EXISTS Insert1000WithoutIndex;

DELIMITER $$

CREATE PROCEDURE Insert1000WithoutIndex()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Patients (Full_Name, Phone, Age)
        VALUES (
            CONCAT('NewPatient_', i),
            CONCAT('091', LPAD(i, 7, '0')),
            FLOOR(18 + (RAND() * 60))
        );

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

DROP INDEX idx_phone ON Patients;

SET profiling = 1;

CALL Insert1000WithoutIndex();

SHOW PROFILES;

CREATE INDEX idx_phone
ON Patients(Phone);

DROP PROCEDURE IF EXISTS Insert1000WithIndex;

DELIMITER $$

CREATE PROCEDURE Insert1000WithIndex()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Patients (Full_Name, Phone, Age)
        VALUES (
            CONCAT('IndexPatient_', i),
            CONCAT('092', LPAD(i, 7, '0')),
            FLOOR(18 + (RAND() * 60))
        );

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

SET profiling = 1;

CALL Insert1000WithIndex();

SHOW PROFILES;