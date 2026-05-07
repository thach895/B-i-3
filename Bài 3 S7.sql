CREATE DATABASE OnlineLearning;
USE OnlineLearning;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    created_at DATE
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATE NOT NULL,

    FOREIGN KEY (student_id)
    REFERENCES Students(student_id)
);

INSERT INTO Students (full_name, email, created_at)
VALUES
('Nguyễn Văn A', 'a@gmail.com', '2023-01-10'),
('Trần Thị B', 'b@gmail.com', '2023-03-15'),
('Lê Văn C', 'c@gmail.com', '2023-06-20'),
('Phạm Thị D', 'd@gmail.com', '2023-08-11'),
('Hoàng Văn E', 'e@gmail.com', '2023-10-01'),
('Đỗ Thị F', 'f@gmail.com', '2024-01-05');


INSERT INTO Payments (student_id, amount, payment_date)
VALUES
(1, 2500000, '2024-01-15'),
(1, 1500000, '2024-03-20'),
(2, 5000000, '2024-07-10'),
(5, 3000000, '2024-11-01'),

(3, 2000000, '2023-05-01'),
(4, 4500000, '2025-02-15');

SELECT s.student_id,
       s.full_name,
       s.email
FROM Students s
WHERE NOT EXISTS (
    SELECT 1
    FROM Payments p
    WHERE p.student_id = s.student_id
    AND p.payment_date >= '2024-01-01'
    AND p.payment_date < '2025-01-01'
);