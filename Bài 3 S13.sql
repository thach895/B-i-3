CREATE DATABASE IF NOT EXISTS RikkeiClinicDB;
USE RikkeiClinicDB;

CREATE TABLE Medicines (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE Price_Changes_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    medicine_id INT NOT NULL,
    old_price DECIMAL(10,2) NOT NULL,
    new_price DECIMAL(10,2) NOT NULL,
    change_type VARCHAR(20) NOT NULL,
    difference_amount DECIMAL(10,2) NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO Medicines
VALUES
(1, 'Paracetamol', 10000, 50),
(2, 'Vitamin C', 15000, 40),
(3, 'Amoxicillin', 25000, 30);

DELIMITER $$

CREATE TRIGGER trg_price_change
BEFORE UPDATE
ON Medicines
FOR EACH ROW
BEGIN
    IF NEW.price <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Giá thuốc mới không hợp lệ';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_log_price_change
AFTER UPDATE
ON Medicines
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN

        IF NEW.price > OLD.price THEN
            INSERT INTO Price_Changes_Log
            (
                medicine_id,
                old_price,
                new_price,
                change_type,
                difference_amount
            )
            VALUES
            (
                OLD.medicine_id,
                OLD.price,
                NEW.price,
                'TĂNG GIÁ',
                NEW.price - OLD.price
            );

        ELSE
            INSERT INTO Price_Changes_Log
            (
                medicine_id,
                old_price,
                new_price,
                change_type,
                difference_amount
            )
            VALUES
            (
                OLD.medicine_id,
                OLD.price,
                NEW.price,
                'GIẢM GIÁ',
                OLD.price - NEW.price
            );

        END IF;

    END IF;
END $$

DELIMITER ;

UPDATE Medicines
SET price = 12000
WHERE medicine_id = 1;

UPDATE Medicines
SET price = 10000
WHERE medicine_id = 2;

UPDATE Medicines
SET stock_quantity = 100
WHERE medicine_id = 3;

UPDATE Medicines
SET price = -5000
WHERE medicine_id = 1;

SELECT * FROM Medicines;

SELECT * FROM Price_Changes_Log;