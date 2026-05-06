CREATE DATABASE BookingSystem;
USE BookingSystem;

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    hotel_id INT,
    status VARCHAR(20)
);
INSERT INTO Bookings (user_id, hotel_id, status) VALUES

(1, 101, 'CANCELLED'),
(1, 102, 'CANCELLED'),
(1, 103, 'CANCELLED'),
(1, 104, 'CANCELLED'),
(1, 105, 'CANCELLED'),
(1, 106, 'CANCELLED'),
(1, 107, 'COMPLETED'),
(1, 108, 'COMPLETED'),
(1, 109, 'PENDING'),
(1, 110, 'COMPLETED'),
(1, 111, 'PENDING'),
(1, 112, 'COMPLETED'),
(2, 101, 'CANCELLED'),
(2, 102, 'CANCELLED'),
(2, 103, 'CANCELLED'),
(2, 104, 'COMPLETED'),
(2, 105, 'COMPLETED'),
(2, 106, 'COMPLETED'),
(2, 107, 'PENDING'),
(2, 108, 'COMPLETED'),
(2, 109, 'PENDING'),
(2, 110, 'COMPLETED'),
(2, 111, 'COMPLETED'),
(2, 112, 'PENDING'),
(2, 113, 'COMPLETED'),
(2, 114, 'COMPLETED'),
(2, 115, 'PENDING'),
(3, 101, 'CANCELLED'),
(3, 102, 'CANCELLED'),
(3, 103, 'CANCELLED'),
(3, 104, 'CANCELLED'),
(3, 105, 'CANCELLED'),
(3, 106, 'CANCELLED'),
(3, 107, 'COMPLETED'),
(3, 108, 'PENDING'),
(4, 101, 'CANCELLED'),
(4, 102, 'CANCELLED'),
(4, 103, 'CANCELLED'),
(4, 104, 'CANCELLED'),
(4, 105, 'CANCELLED'),
(4, 106, 'COMPLETED'),
(4, 107, 'COMPLETED'),
(4, 108, 'PENDING'),
(4, 109, 'COMPLETED'),
(4, 110, 'PENDING'),
(5, 101, 'CANCELLED'),
(5, 102, 'CANCELLED'),
(5, 103, 'CANCELLED'),
(5, 104, 'CANCELLED'),
(5, 105, 'CANCELLED'),
(5, 106, 'CANCELLED'),
(5, 107, 'CANCELLED'),
(5, 108, 'CANCELLED'),
(5, 109, 'CANCELLED'),
(5, 110, 'CANCELLED'),
(5, 111, 'COMPLETED'),
(5, 112, 'COMPLETED'),
(5, 113, 'PENDING'),
(5, 114, 'COMPLETED'),
(5, 115, 'COMPLETED'),
(5, 116, 'PENDING'),
(5, 117, 'COMPLETED'),
(5, 118, 'COMPLETED'),
(5, 119, 'PENDING'),
(5, 120, 'COMPLETED');

select user_id, count(*),sum(
case
when status ='CANCELLED'then 1
else 0
end) as total_cancelled
from Bookings
group by user_id
having count(*)>10 and sum(
case
when status ='CANCELLED'then 1
else 0
end)>5
